Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266599AbRGQPun>; Tue, 17 Jul 2001 11:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266600AbRGQPue>; Tue, 17 Jul 2001 11:50:34 -0400
Received: from intra.cyclades.com ([209.81.55.6]:10765 "HELO
	intra.cyclades.com") by vger.kernel.org with SMTP
	id <S266599AbRGQPu2>; Tue, 17 Jul 2001 11:50:28 -0400
Date: Tue, 17 Jul 2001 08:51:40 -0700 (PDT)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: RAMDisk Blues
Message-ID: <Pine.LNX.4.30.0107170850030.19996-100000@intra.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm trying to boot a Linux system that has the following configuration:
- 32MB of Flash (IDE Flash Drive), where a kernel image and a compressed
  root filesystem image are stored.
- 256MB of RAM, 128MB of which will be used as a RAMDisk (believe me, this
  is cheaper than 128MB Flash + 128MB RAM ... :).

After looking for information on how to do that on the 'Net and in the
Documentation/ directory of the kernel src, I've been able make the Flash
Drive bootable. Unfortunately, it's bootable, but it doesn't boot
successfully ... :(

What I tried:
- Compressed the image I used to boot the system from a regular IDE HD to
  a file called rd_image.gz (~20MB compressed), and copied it to the IDE
  Flash Drive.
- Compiled a 2.4.6 kernel with RAMDisk and initrd support built-in, and
  then copied it to the IDE Flash Drive.
- Ran LILO with the following config. file (based on the doc. I found so
  far):

	boot=/dev/hda		# The FlashDrive device
	install=/boot/boot.b
	map=/boot/map
	append="ramdisk_size=131072 initrd=rd_image.gz"
	vga=normal
	default=Linux
	delay=5
	image=/boot/vmlinuz
		initrd=/boot/rd_image.gz
		root=/dev/ram0
		label=Linux
		read-only

LILO completes the operation without problems (no errors). However, when I
boot the system from the FlashDrive, this is the output I get:

LILO Loading Linux ......................................................
..............................................

That's it!! The system hangs at this point (it really hangs, to the point
that the "soft" power on/off doesn't work anymore, and I have to turn off
the system from the back in order to reboot it).

What am I doing wrong?? Is my RAMDisk image too big (I thought there was
no limit, as long as you had enough RAM ...)?? Does anyone here know a
good resource on the 'Net where I can find more detailed information about
creating a RAMDisk-based Linux system that boots from a device other than
a floppy disk?? Most of the docs I found were related to boot / rescue /
utility floppies, so I don't know whether this is the right way to do it
or not ...

Any help would be appreciated.

Later,
Ivan

