Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbUBID2Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 22:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUBID2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 22:28:24 -0500
Received: from web21408.mail.yahoo.com ([216.136.232.78]:18540 "HELO
	web21408.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262745AbUBID2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 22:28:21 -0500
Message-ID: <20040209032820.12809.qmail@web21408.mail.yahoo.com>
Date: Sun, 8 Feb 2004 19:28:20 -0800 (PST)
From: Trideepraj Roychoudhury <fsalabs@yahoo.com>
Subject: 2.6.1-"kernel panic: init not found"
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I installed the 2.6.1 kernel and having problems with
initrd. My GRUB.CONF looks like this-

<<<truncated>>>

title Linux(2.6.1)
	root (hd0,4)
	kernel /boot/vmlinuz-2.6.1 ro root=LABEL=/
	initrd /boot/initrd-2.6.1.img

title RedHat Linux(2.4.20-8)
	root (hd0,4)
	kernel /boot/vmlinuz-2.4.20-8 ro root=LABEL=/
	initrd /boot/initrd-2.4.20-8.img

<<<truncated>>>

2.4.20-8 is the kernel installed by RH 9.0 and works
fine. 2.6.1 is what i compiled from source and gives
me problem with initrd saying - 

"kernel panic: no init found. try passing init= option
to kernel"

I understand that there is no problem with the kernel
but with the initrd file. 

Linux is on /dev/hda5 with EXT3 fs and has NO BOOT
partition. In 2.4.20-8 i can see EXT3 loading as a
module while booting, but in 2.6 EXT3 loading fails
with this -

"mount: error 19 on loading ext3"

_________________________________

When i remove the initrd line from GRUB.CONF i.e. -

<<<truncated>>>

title Linux(2.6.1)
	root (hd0,4)
	kernel /boot/vmlinuz-2.6.1 ro root=LABEL=/

title RedHat Linux(2.4.20-8)
	root (hd0,4)
	kernel /boot/vmlinuz-2.4.20-8 ro root=LABEL=/
	initrd /boot/initrd-2.4.20-8.img

<<<truncated>>>

2.6.1 loads completely without the module support...so
i see that /dev/hda5 is mounted as '/' with fs EXT2
and not EXT3.
Now, after 2.6.1 is loaded, i try this-
#depmod 
which tells me that EXT3 requires JBD. After manually
'insmod jbd.ko' and 'insmod ext3.ko' EXT3 module
loads.

So my problem is that during boot EXT3 isnt getting
loaded due to JBD and hence kernel cannot load initrd
from /boot/initrd-2.6.1.img( which is on EXT3 fs)

This is how i compile-
#mkdir /usr/src/build-2.6.1
#cd /usr/src/linux-2.6.1
#make O=/usr/src/build-2.6.1 menuconfig
#make O=/usr/src/build-2.6.1 
#make O=/usr/src/build-2.6.1 modules_install

i even tried -
#mkinitrd /boot/System-2.6.1.map
/boot/initrd-2.6.1.img
but that fails too...

any help...?

__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
