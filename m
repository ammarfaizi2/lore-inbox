Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUDZOVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUDZOVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 10:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUDZOVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 10:21:40 -0400
Received: from h001061b078fa.ne.client2.attbi.com ([24.91.86.110]:8580 "EHLO
	linuxfarms.com") by vger.kernel.org with ESMTP id S262170AbUDZOV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 10:21:27 -0400
Date: Mon, 26 Apr 2004 10:22:51 -0400 (EDT)
From: Arthur Perry <kernel@linuxfarms.com>
X-X-Sender: kernel@tiamat.perryconsulting.net
To: Seve Ho <sho@mailprove.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: mkinitrd error
In-Reply-To: <408CDBF1.90301@mailprove.com>
Message-ID: <Pine.LNX.4.58.0404261005210.8600@tiamat.perryconsulting.net>
References: <408CDBF1.90301@mailprove.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

You probably want to communicate this back to RedHat. (I assume you are
using RedHat)..
I have seen the same thing, but honestly did not take it too seriously.
I figured someone else would report it to them ;)

The mkinitrd script is located at /sbin/mkinitrd.
It creates a fixed-size ramdisk at 4000 kbytes if i386, and 8000 kbytes
for "all" other architectures (or more accurately, other architectures
that would see this specific script) .. That would be ia64.
For a quick fix, you can change this value to something larger like 12000.
This should fit what you need.
Just change line 45 from "IMAGESIZE=8000" to "IMAGESIZE=12000".
You now can re-run it and it should complete without errors.

Then you will need to modify your elilo.conf file, passing the new
ramdisk size to the kernel command line.
This has to be done because the new ramdisk size is larger than the
default value which the kernel expects.

Simply find your active kernel paragraph in the
/boot/efi/efi/redhat/elilo.conf file, and make sure your append line
reads,
append="root=LABEL=/ ramdisk_size=12000"

Off the top of my head, I think this is all you need to do.

FYI, correct me if I am wrong everyone, but this really should go to a
RedHat support mail group. Not the kernel development one.
It was just a free ticket and I am just having my morning coffee ;)

Arthur Perry
Lead Linux Developer / Linux Systems Architect
Validation, CSU Celestica
Sair/Linux Gnu Certified Professional, 2000
Project Manager, Linuxfarms
http://www.linuxfarms.com



On Mon, 26 Apr 2004, Seve Ho wrote:

> Hi,
>
> I am trying to recompile kernel on Itanium2 Redhat box.( This is my
> first time to do it and actually I am new to Linux )
> After recompilation, I tried to create initial ramdisk with mkinitrd.
> However, it failed with following error messages...
> Does anyone have idea about what is jdb? And how can i make the ramdisk
> successfully?
>
> Any help  or hints will be greatly appreciated.( I am not on the list,
> could you kindly cc your answer or suggestion to sho@mailprove.com ? )
>
>
> Seve
>
>
> [root@SDV900 root]# mkinitrd -v initrd-2.4.18-e.31custom20040426.img
> 2.4.18-e.31custom20040426
> Using modules:  ./kernel/drivers/scsi/scsi_mod.o
> ./kernel/drivers/scsi/sd_mod.o
> ./kernel/drivers/scsi/sym53c8xx_2/sym53c8xx_2.o ./kernel/fs/jbd/jbd.o
> ./kernel/fs/ext3/ext3.o
> Using loopback device /dev/loop0
> /sbin/nash -> /tmp/initrd.naSZEa/bin/nash
> /sbin/insmod.static -> /tmp/initrd.naSZEa/bin/insmod
> `/lib/modules/2.4.18-e.31custom20040426/./kernel/drivers/scsi/scsi_mod.o'
> -> `/tmp/initrd.naSZEa/lib/scsi_mod.o'
> `/lib/modules/2.4.18-e.31custom20040426/./kernel/drivers/scsi/sd_mod.o'
> -> `/tmp/initrd.naSZEa/lib/sd_mod.o'
> `/lib/modules/2.4.18-e.31custom20040426/./kernel/drivers/scsi/sym53c8xx_2/sym53c8xx_2.o'
> -> `/tmp/initrd.naSZEa/lib/sym53c8xx_2.o'
> `/lib/modules/2.4.18-e.31custom20040426/./kernel/fs/jbd/jbd.o' ->
> `/tmp/initrd.naSZEa/lib/jbd.o'
> `/lib/modules/2.4.18-e.31custom20040426/./kernel/fs/ext3/ext3.o' ->
> `/tmp/initrd.naSZEa/lib/ext3.o'
> Loading module scsi_mod
> Loading module sd_mod
> Loading module sym53c8xx_2
> Loading module jbd
> Loading module ext3
> *tar: ./lib/jbd.o: Wrote only 0 of 10240 bytes
> tar: Skipping to next header
> tar: Error exit delayed from previous errors*
>
> --
> Seve Ho
> Programmer
>
> Tel   (852) 3105 2920
> Fax   (852) 3105 2926
> Email Seve.Ho@MailProve.com
>
>
> Mail Prove Ltd.
> 806, Cyberport 1
> 100 Cyberport Rd.
> Pokfulam, H. K.
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
