Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSGMPyy>; Sat, 13 Jul 2002 11:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSGMPyx>; Sat, 13 Jul 2002 11:54:53 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:31472 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314707AbSGMPyx>; Sat, 13 Jul 2002 11:54:53 -0400
Subject: Re: Removal of pci_find_* in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Matt_Domsch@Dell.com, greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <3D304940.7020207@mandrakesoft.com>
References: <F44891A593A6DE4B99FDCB7CC537BBBB0724D1@AUSXMPS308.aus.amer.dell.com>
	<3D2FAF94.7070100@mandrakesoft.com>
	<1026570939.9958.92.camel@irongate.swansea.linux.org.uk> 
	<3D304940.7020207@mandrakesoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 18:06:35 +0100
Message-Id: <1026579995.13885.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 16:37, Jeff Garzik wrote:
> My point is that depending on any method of internal kernel ordering is 
> fragile.

Its actually -extremely- reliable. Simply because we've kept the
behaviour constant over time.
 
> I would rather have the kernel export which drives are listed in CMOS / 
> BIOS ROM, and let userspace say "my boot drive is the nth BIOS-listed 
> drive."  For example, looking through the aic7xxx (or was it 

There is a BIOS extension for this (EDID 3.0 I believe). It only
addresses where the boot device went, not how to sort the IDE device
ordering and the like

> Depending on pci_find_* ordering is very situation-dependent, and only 
> covers N cases.  Then you have another N cases covered by the order in 
> which you modprobe key drivers.  Then you have another N cases covered 

Forget about modprobe. The areas this bites people are areas where the
ordering is compiled in stuff (eg IDE) and where you have multiple of
the same controller.

A good example here is that many systems order devices internally based
on mainboard versus external. Dell do this a lot. That ordering happens
not to be the pci scan order some times.

Even with BIOS help you have to know this. And with only the basic BIOS
you have to know the full ROM initialisation ordering, which is -very-
non trivial for complex systems.

> in the kernel, the way the user wants.  That's why I say the 
> responsibility for figuring out the boot drive should be pushed to 
> initrd/initramfs.

Finding the rootfs by label is a minor problem, figuring out how to name
the controllers consistently between 2.2/2.4/2.6 is a showstopper in the
real world even if its not in happy hackerdom.


