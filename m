Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbUKVKG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbUKVKG4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUKVKG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:06:56 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:30943 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262017AbUKVKGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:06:20 -0500
From: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
Message-Id: <200411221006.iAMA6Gk23164@inv.it.uc3m.es>
Subject: Re: kernel analyser to detect sleep under spinlock
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Mon, 22 Nov 2004 11:06:16 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@inv.it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another minor functional update to the kernel source code analysis tool,
though actually I reorganised it thoroughly internally in order to run
off externally defined trigger-action rules instead of a mess of gunky C
code.

   ftp://oboe.it.uc3m.es/pub/Programs/c-1.2.3.tgz

This tool locates "sleep under spinlock" abuses in the kernel.

The latest revision eliminates some false positives, by taking notice of
the second argument to kmalloc where it can.

% ./c -nostdinc -iwithprefix include -D__KERNEL__
 -I/usr/local/src/linux-2.6.3/include -D__KERNEL__ -Wall
 -Wstrict-prototypes -Wno-trigraphs
 -I/usr/local/src/linux-2.6.8.1-uml/include/asm-i386/mach-default -O2
 -DMODULE /usr/local/src/linux-2.6.8.1-uml/drivers/block/nbd.c
 /usr/local/src/linux-2.6.8.1-uml/drivers/block/nbd.c
/************** sleep calls ************************************
 *  function                     line    calls (locks)
 *
 * - /usr/local/src/linux-2.6.3/include/linux/slab.h
 *  kmalloc                      98      __kmalloc (0)
 *
 * - /usr/local/src/linux-2.6.3/include/linux/fs.h
 *  lock_super                   741     down (0)
 *
 * - /usr/local/src/linux-2.6.8.1-uml/drivers/block/nbd.c
 *  nbd_send_req                 245     down (0)
 *  nbd_ioctl                    548     down (0)
 *
 *
 * *** found 0 instances of sleep under spinlock ***
 *
 **************************************************************/



GPL, LGPL, etc.

This is also useful for locating functions which can sleep, though of
course that can be done in other ways.


Peter (ptb (at) inv.it.uc3m.es)
 
 
