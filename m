Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265448AbSJXXgM>; Thu, 24 Oct 2002 19:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265697AbSJXXgM>; Thu, 24 Oct 2002 19:36:12 -0400
Received: from host194.steeleye.com ([66.206.164.34]:27666 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265448AbSJXXgL>; Thu, 24 Oct 2002 19:36:11 -0400
Message-Id: <200210242342.g9ONgGT04819@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Steven Dake <sdake@mvista.com>
cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Advanced TCA SCSI Disk Hotswap 
In-Reply-To: Message from Steven Dake <sdake@mvista.com> 
   of "Thu, 24 Oct 2002 13:45:48 PDT." <3DB85BFC.2080009@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 24 Oct 2002 18:42:16 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The locking most definately needs to be added to the kernel.  I'm
> surprised the original patch didn't contain any locking, but then
> again, my first patch didn't  either:) 

When I first read the SCSI code many years ago, I found surprise wasn't 
adequate and I was forced to resort to astonishment.  It's being cleaned up 
slowly.

Originally hot removal/insertion was the exception, so nobody tripped over the 
locking issue.  Now it's fast becoming the rule.

> This may be true, but most systems will only have at most 4-5 devices.
> 
>  Theres only so much room on PCI for FC devices :) 

I have to think about other SCSI systems as well.  Some IBM beasties have > 
256 PCI slots.  Infiniband is threatening direct bus-fibre attachment.

> In Advanced TCA (what spawned this work) a button is pressed to
> indicate  hotswap removal which makes for easy detection of hotswap
> events.  This is why there are  kernel interfaces for removal and
> insertion (so a kernel driver can be written to detect  the button
> press and remove the devices from the os data structures and then
> light a blue  led indicating safe for removal). 

OK, I understand what's going on now.  It's no different from those hotplug 
PCI busses where you press the button and a second or so later the LED goes 
out and you can remove the card.  10ms sounds rather a short maximum time for 
a technician to wait for a light to go out....I suppose Telco technicians are 
rather impatient.

I really think you need to lengthen this interval.  The kernel is moving 
towards this type of hotplug infrastructure which you can easily leverage (or 
even help build), but it's definitely going to be mainly in user space.

James



