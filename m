Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130941AbRCGWoi>; Wed, 7 Mar 2001 17:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRCGWoS>; Wed, 7 Mar 2001 17:44:18 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:12297 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131155AbRCGWoK>; Wed, 7 Mar 2001 17:44:10 -0500
Message-Id: <200103072243.f27MhdO31896@aslan.scsiguy.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.3 and new aic7xxx 
In-Reply-To: Your message of "Wed, 07 Mar 2001 16:55:50 EST."
             <3AA6AE66.700D806@mandrakesoft.com> 
Date: Wed, 07 Mar 2001 15:43:39 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I would prefer to sort the list at probe not boot time.  That makes it
>easy to reverse the order on the fly, depending on what the driver
>requests at runtime.  It's SMP-friendly, because I can grab a private
>copy of the PCI device list, sort it, and scan it.  You don't have to
>re-sort at every pci_insert_device, for hotplug machines.  The only
>potential downside is I need to check and see if the bootmem case needs
>to be handled, when making a private copy of the pci devices list for
>sorting.

How often is the list manipulated?  My guess is not very often.
You can allow people to read the list without taking a spinlock and
only acquire the spinlock on list manipulations.  Inserting an
element can be performed atomically so there isn't an SMP issue
so long as you don't allow more than one processor to insert at
the same time.  This would allow you to perform insertion sort
meaning that everything from /proc to device drivers auto-magically
sees the devices in the order they were probed.  For hot plug devices
you might want to insert them at the end to follow the "order probed"
motif.

--
Justin
