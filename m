Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbTA2SI7>; Wed, 29 Jan 2003 13:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTA2SI6>; Wed, 29 Jan 2003 13:08:58 -0500
Received: from mail.somanetworks.com ([216.126.67.42]:57539 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S266772AbTA2SIw>; Wed, 29 Jan 2003 13:08:52 -0500
Date: Wed, 29 Jan 2003 13:18:10 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Stanley Wang <stanley.wang@linux.co.intel.com>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [RFC] Enhance CPCI Hot Swap driver
In-Reply-To: <Pine.LNX.4.44.0301291538190.10354-100000@manticore.sh.intel.com>
Message-ID: <Pine.LNX.4.44.0301291119350.17194-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2003, Stanley Wang wrote:

> Hi, Scott,
> After reading your CPCI Hot Swap support codes, I have a suggestion
> to enhance it:
> How about to make it be full hot swap compliant?
> I mean we could also do some works like "disable_slot" when we receive
> the #ENUM & EXT signal. Hence the user could yank the hot swap board 
> without issuing command on the console.
> How do you think about it?

Since most hardware devices need some form of userspace cleanup before
they can be removed, the separation of notification and extraction is
on purpose in the current cPCI hotplug driver.  Full Hot Swap compliance 
per the PICMG 2.1 R2.0 specification can be achieved through the use of
a daemon in userspace that:

1) detects extract requests, either through the directory notifications
   sent by pci_hp_update_slot_info, or by simple polling of the latch and
   adapter files.
2) does the desired userspace cleanup.
3) completes the extraction by writing 0 to the slot's power file.

For reference, I'm putting the GPL'd userspace daemon I wrote for use in 
our product here at SOMA on our download site at:

ftp://oss.somanetworks.com/pub/linux/cpci/pcihotplugd/pcihotplugd-20030129.tar.gz

Note that it requires the directory notifications provided by calling 
pci_hp_change_slot_info, so your sysfs patch will keep it from working
correctly.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com


