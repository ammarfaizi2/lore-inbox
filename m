Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283677AbRLRBzx>; Mon, 17 Dec 2001 20:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283667AbRLRBzq>; Mon, 17 Dec 2001 20:55:46 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:55169 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S283621AbRLRBz2>; Mon, 17 Dec 2001 20:55:28 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: "ChristianK."@t-online.de (Christian Koenig)
To: linux-kernel@vger.kernel.org
Subject: Making Linux multiboot capable and grub loading kernel modules at boot time.
Date: Tue, 18 Dec 2001 03:54:46 +0100
X-Mailer: KMail [version 1.3.2]
Cc: richardt@vzavenue.net.maciek@mzn.dyndns.org.andrew.grover@intel.com.dcinege@psychosis.com.rusty@rustcorp.com.au
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <16G9TS-0RVzQ8C@fwd02.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I send this to every one who seems to be interested in it as cc.
(If you don't want this simple let me know).

This is the next release off my Kernel Patch letting grub loads 
Kernel-Modules at boot time.

This patch is against Kernel 2.5.1 and grub 0.90 and consider off 3 Parts:

1. mboot.diff: Makes vmlinux multiboot compliant.
   
   Changes made since last Version:
	1.  added 2 new build targets to the Kernel Makefiles "mImage"
	     and "mImage.gz" creating clean Multiboot Kernel-Images in
	     arch/i386/boot.
	2.  setup.c now evaluates the multiboot apm table correctly.

2. bootmodules.diff: Adds a new elf-object file loader, evaluating and 
   inserting the modules grub have loaded into the Kernel.

   Changes made since last Version:
	1.  Module Parameters are evaluated correctly now.
	2.  Fixed some memory leaks and 1 byte miss bug in boot_modules.c.
	3.  Fixed a ugly bug that made modules exporting much kernel symbols oops at 
	     boott up.

3. grub.diff: This is a new patch adding a command to grub who loads all
 	     modules in a specified file with correct module-dependecies.
	     Now you could do something like:

	     root (hd0,1)
	     kernel /boot/vmlinux-2.5.1prex root=/dev/hda1 ro
	     modulesfromfile /etc/modules /lib/modules/2.5.1/modules.dep

	     inside your grub menu.lst and every thing specified in /etc/module
	     gets loaded before the Kernel is booted.

You can download these patches at

http://home.t-online.de/home/ChristianK./patches/mboot.diff
http://home.t-online.de/home/ChristianK./patches/bootmodules.diff
http://home.t-online.de/home/ChristianK./patches/grub.diff

Please tell me what you think about it / how it works.

MfG, Christian König. (Sorry for my poor English)
