Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbTAIHCj>; Thu, 9 Jan 2003 02:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbTAIHCi>; Thu, 9 Jan 2003 02:02:38 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:37899 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id <S261724AbTAIHCi>; Thu, 9 Jan 2003 02:02:38 -0500
Subject: 2.4.21-pre3 fails compile of ehci-hcd.c
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 09 Jan 2003 02:11:15 -0500
Message-Id: <1042096276.8219.126.camel@madmax>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Noticed that I could not get patch-2.4.21-pre3 to compile:

	make[3]: Entering directory `/usr/src/kernels/linux-2.4.20/drivers/usb'
	ld -m elf_i386 -r -o usbcore.o usb.o usb-debug.o hub.o devio.o inode.o drivers.o devices.o hcd.o
	gcc -D__KERNEL__ -I/usr/src/kernels/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -iwithprefix include -DKBUILD_BASENAME=ehci_hcd  -c -o hcd/ehci-hcd.o hcd/ehci-hcd.chcd/ehci-hcd.c: In function `ehci_start':
	hcd/ehci-hcd.c:343: parse error before `;'
	hcd/ehci-hcd.c:416: parse error before `;'
	hcd/ehci-hcd.c: In function `ehci_stop':
	hcd/ehci-hcd.c:501: parse error before `;'
	hcd/ehci-hcd.c: In function `ehci_irq':
	hcd/ehci-hcd.c:685: parse error before `;'

I'm not sure why gcc 2.95.3 is failing on the macro expansion, but it is
turning:
	ehci_warn (ehci, "illegal capability!\n");
into:
	printk("<4>"  "%s %s: "   "illegal capability!\n" , hcd_name, ( ehci   ) ;
which is missing the ->... structure reference.  The macros in
ehci-dbg.c work just fine if you give them one or more arguments
following the format string definition.

Compiler is gcc 2.95.3, binutils 2.12.90.0.9 20020526, glibc 2.2.5 on a
Slackware 8.0 distribution.

Kris


