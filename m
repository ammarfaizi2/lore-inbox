Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbUBIQCd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 11:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUBIQCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 11:02:33 -0500
Received: from mailout.informatik.tu-muenchen.de ([131.159.0.5]:22756 "EHLO
	mailout.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S262603AbUBIQCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 11:02:30 -0500
From: Daniel Schranz <schranz@in.tum.de>
Reply-To: schranz@in.tum.de
To: linux-kernel@vger.kernel.org
Subject: [Problem]: strange ramdisk-errors with 2.6.1
Date: Mon, 9 Feb 2004 17:01:10 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402091701.10737.schranz@in.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I encountered a problem with the ramdisk under 2.6.1 (will test with 2.6.2 
after my exams)
When modifying a mounted ramdisk i get strange errors (see below)

Kernel is 2.6.1 (compiled with gcc 3.3.2, binutils 2.14.90.0.8)
ramdisk-support is compiled in (not a module)
with kernel 2.4.22 everything works fine (rd-support also compiled in)
Intel P3 (Coppermine) with 512MB RAM

Regards,
Daniel



dd if=/dev/zero of=/dev/ram7 bs=1k count=4096
mke2fs -b 1024 -m0 /dev/ram7
mount /dev/ram7 /mnt/tmp
cp -dpR initrd/* /mnt/tmp/
--> all files under /mnt/tmp

umount /mnt/tmp
mount /mnt/tmp:
--> only lost+ found is there

rmdir /mnt/tmp/lost+found
umount + mount:
--> lost+found is there again

dd if=image of=/dev/ram7 bs=1k count=4096 (image created using a 
loopback-file)
--> all files there

rm /mnt/tmp/linuxrc:
--> all files there except linuxrc

umount + mount + ls /mnt/tmp:
--> ls: /mnt/tmp/linuxrc: Input/output error
--> bin  cdrom  dev  etc  lib  lost+found  newroot  sbin

touch dummy + ls:
--> ls: /mnt/tmp/linuxrc: Input/output error
--> bin  cdrom  dev  dummy  etc  lib  lost+found  newroot  sbin

umount + mount:
--> ls: /mnt/tmp/linuxrc: Input/output error
--> bin  cdrom  dev  etc  lib  lost+found  newroot  sbin

touch linuxrc:
-->  touch: cannot touch `/mnt/tmp/linuxrc': Input/output error

