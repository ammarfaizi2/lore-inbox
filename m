Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265441AbTIJSWT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbTIJSWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:22:19 -0400
Received: from imap.gmx.net ([213.165.64.20]:33242 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265441AbTIJSWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:22:13 -0400
From: "Sebastian Piecha" <spi@gmxpro.de>
To: linux-kernel@vger.kernel.org
Date: Wed, 10 Sep 2003 20:22:15 +0200
MIME-Version: 1.0
Subject: Re: PROBLEM: kernel panic when accessing data via samba
Message-ID: <3F5F87F7.8245.C851CE4@localhost>
In-reply-to: <3F5B65C2.31545.5CE5D0@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Sep 2003 at 17:07, Sebastian Piecha wrote:

> ...
> 
> 2) full description:
> 
> I'm using Samba to distribute some shares to Windows clients. One of 
> the shares is an Image-directory where I'm storing PQDI Images of 
> Windows clients. One of the created images is about 40GB of size and 
> is split up to 56  files each of same size. When verifying this image 
> from a Win XP client, PQDI  stops with an error (error 1811, "Could 
> not read from image file") and the Linux  kernel panic. Verifying 
> this image from DOS (with MS network client) is done without any 
> error. Also verifying smaller images is done without any error. 
> Verifying this Image via NFS is also done without an error. Another 
> PQDI version (7.0) also reports an error and let the Linux Kernel  
> panic. Copying more than 4 GB to the samba share also let the kernel 
> panic with an OOPS. Copying data locally from the Linux console is 
> done without an error.
> 
> In the beginning I thought that the Promise controller is the source 
> of problem, now I'm not sure. Maybe it's samba or the combination of 
> samba and a Promise controller.
> 
> ...  
> 
> The share is lying in a directory on a Reiser filesystem: 
> 
> share Images 
> ReiserFS 
> LVM (on /dev/md0 only, 120GB) 
> RAID1 /dev/md0 (120GB) 
> /dev/hda1 + /dev/hde1 (one primary partition of 120GB on each drive)
> /dev/hda + /dev/hde (each 120GB) IDE UDMA133-controller 
> 
> As IDE-controller I first used a Promise FastTrak TX2000 (which 
> supports "hardware"-RAID). I tried the binary Promise-driver 
> (1.03.0.1) and the source  code-driver (1.02.0.25), both without 
> success. All time the OOPS occurred.  Then I replaced the controller 
> and both Samsung SP1203N-hard drives (each  120GB) against a Promise 
> UltraTrak 133 TX2 and two Maxtor drives  (6Y120P0, each 1 20GB) and 
> installed a Linux native software-RAID without  any Promise-driver. 
> But again the OOPS occurred. Of course I updated the Promise-firmware 
> to the latest level.  
> 
> To eliminate the RAID and LVM-drivers as the source of problem I 
> installed just a Reiser FS on one 120GB-primary partition on one of 
> both Maxtor disks  (after removing the drive from the RAID). But 
> again the Linux kernel panicked. Trying ext3 instead of reiserfs 
> didn't help. As I do not have enough space on my scsi-disks I can't 
> verify this big image from a scsi-disk.
> 
> Sometimes the Linux kernel panic occurs immediately some minutes 
> after starting the verify, sometimes it happens after reading half of 
> all image files. Samba doesn't report any error. I also tried a 
> different PCI-slot for the Promise- adapter without any success. Next 
> thing would be to try a different IDE-controller...
> ...

Same happens with Samba 2.2.8a with or without LVM and RAID.
Does anybody have a clue how to fix this?

On the Samba mailing list I was told Samba as an user space 
application can't cause a kernel oops.

Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

