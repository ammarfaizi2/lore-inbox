Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVEXPVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVEXPVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVEXPV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:21:26 -0400
Received: from tag.witbe.net ([81.88.96.48]:22196 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S262093AbVEXPTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:19:31 -0400
Message-Id: <200505241519.j4OFJUR24338@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <linux-os@analogic.com>
Cc: <linux-kernel@vger.kernel.org>, <rol@witbe.net>
Subject: Re: Linux and Initrd used to access disk : how does it work ?
Date: Tue, 24 May 2005 17:19:30 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <Pine.LNX.4.61.0505241032250.16158@chaos.analogic.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
thread-index: AcVgcAcAWRs3gVrrRM2uik40OlyceAAA0s7A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dick,

> initrd means Initial RAM disk.
> 
> The boot image is put onto your Hard disk. The hard disk needs
> to be accessible from the BIOS to boot from it. Most controllers
> have a BIOS module that lets it be accessed during boot so you
> don't need a chicken before the egg to start the boot.

Ok, basically, the trick is that the BIOS knows how to access the
disk, and Linux doesn't because it doesnt use the BIOS ? Or is it
some more subtle (though I doubt) thing in which only a part of the
disk can be accessed by the BIOS.

> Then, when booting, LILO or grub starts linux which uncompresses
> a RAM disk and mounts it instead of your hard disk. A special
> version of `init` (called nash) gets started which reads a script
> called linuxrc. It contains commands like:
Yes, I've seen that in my .img file...

> The module(s) are in the /lib directory of the RAM disk.
> They are put there by a build-script that installs initrd.
> This script gets executed when you do 'make install' in
> the kernel directory. If you have private modules, you
> can copy them to the appropriate /lib/modules/`uname 
> -r`/kernel/drivers
> directory. You put the module(s) name(s) you need to boot
> in /etc/modprobe.conf or /etc/modules.conf (depends upon the
> module tools version) as:
> 
> alias scsi_hostadapter aic7xxx
> alias scsi_hostadapter1 ata_piix
> 
> ... any scsi_hostadapter stuff will be put into initrd when
> you execute the script, /sbin/mkinitrd.
> 

Hmmm... I didn't know this part, thanks for the details.

So, it seems that I'm stuck with my binary module unless I can find a
way to tell the kernel to use the BIOS to access the disk ;-)))

Cheers,
Paul

