Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266406AbTGEUbl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 16:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbTGEUbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 16:31:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:63105 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266406AbTGEUbi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 16:31:38 -0400
Date: Sat, 5 Jul 2003 16:49:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?V=EDctor=20Romero?= <victor.romero@gesline.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: console=tty2
In-Reply-To: <200307041504.24844.victor.romero@gesline.com>
Message-ID: <Pine.LNX.4.53.0307051644370.12508@chaos>
References: <200307041504.24844.victor.romero@gesline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jul 2003, [iso-8859-1] Víctor Romero wrote:

>
>
> 	Dear kernel hackers,
>
> 	In a little appliance (i386) I'm working on I have a linux(2.4.20 vanilla)
> booting with a pretty nice logo in fb mode, but I dont want to see text in
> the boot process just the logo, so I tryed on boot : linux console=tty2, but
> still see everything, If i put to ttyS0 works but I have a modem there,so its
> not a good idea, anyway tty2 should work, but it doesnt, any idea?


This is the tail end of the script I wrote to make a bootable RAM
disk for an embedded system. I assure you that ttyS0, ttyS1m and null
work fine. You must make sure that you have actually created the
devices in /dev


#
#  Compress the RAM Disk image into a file on the mounted file-system.
#  Remove the original RAM Disk image, then copy the required boot
#  files to the mounted file-system also.
#
umount	${RAMDISK}
dd if=${RAMDISK_IMAGE} bs=1k count=${DISKSIZE} | gzip -9 >/mnt/initrd-${VER}
rm -f ${RAMDISK_IMAGE}
rmdir   ${RAMDISK}
#
cp ${SYS} /mnt/vmlinuz-${VER}
cp /boot/boot.b /mnt/boot.b
cp message /mnt/message
#
#  Now execute lilo to install the boot-loader onto the mounted file-
#  system. Lilo allows its configuration to be taken from standard input.
#
/sbin/lilo -C - <<EOF
#
#  Lilo boot-configuration script.
#
#message = /mnt/message
boot    = ${RAMDEV}
disk	= ${RAMDEV}
	bios = 0x00
	sectors = 18
	heads = 2
	cylinders = 80
map     = /mnt/map
backup  = /dev/null
compact
vga = normal	# force sane state
 install = /mnt/boot.b
 image   = /mnt/vmlinuz-${VER}
 initrd  = /mnt/initrd-${VER}
 root    = /dev/ram0
 label   = Platinum
# append  = "console=ttyS1,9600"
# append  = "console=ttyS0,9600"
 append  = "console=null"
EOF

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

