Return-Path: <linux-kernel-owner+w=401wt.eu-S932321AbWLQS0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWLQS0r (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 13:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWLQS0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 13:26:47 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:32253 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932321AbWLQS0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 13:26:46 -0500
Date: Sun, 17 Dec 2006 10:27:41 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Zach Brown <zach.brown@oracle.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
Message-Id: <20061217102741.58d2c425.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0612171301020.24836@localhost.localdomain>
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
	<2F8F687E-C5E5-4F7D-9585-97DA97AE1376@oracle.com>
	<Pine.LNX.4.64.0612141721580.10217@localhost.localdomain>
	<4581DAB0.2060505@s5r6.in-berlin.de>
	<Pine.LNX.4.61.0612151135330.22867@yvahk01.tjqt.qr>
	<Pine.LNX.4.64.0612151547290.6136@localhost.localdomain>
	<Pine.LNX.4.63.0612152351360.16895@gockel.physik3.uni-rostock.de>
	<Pine.LNX.4.64.0612171301020.24836@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2006 13:13:59 -0500 (EST) Robert P. J. Day wrote:

> 
>   so here's the end result of my experiment to replace unnecessary
> code snippets with an invocation of the ARRAY_SIZE() macro from
> include/linux/kernel.h.  i've attached the script that i ran on the
> entire tree, then (after adding al viro's connector patch), did:
> 
>   $ make allyesconfig	# for the stress factor
>   $ make
> 
> to see what would happen.
> 
>   amazingly, the compile worked all the way down to:
> 
>   AS      arch/i386/boot/bootsect.o
>   LD      arch/i386/boot/bootsect
>   AS      arch/i386/boot/setup.o
>   LD      arch/i386/boot/setup
>   AS      arch/i386/boot/compressed/head.o
>   CC      arch/i386/boot/compressed/misc.o
>   OBJCOPY arch/i386/boot/compressed/vmlinux.bin
>   HOSTCC  arch/i386/boot/compressed/relocs
> arch/i386/boot/compressed/relocs.c: In function 'sym_type':
> arch/i386/boot/compressed/relocs.c:72: warning: implicit declaration of function 'ARRAY_SIZE'

That's a userspace program and shouldn't use kernel.h.

> /tmp/ccRTpFxM.o: In function `main':
> relocs.c:(.text+0xb13): undefined reference to `ARRAY_SIZE'
> relocs.c:(.text+0xddb): undefined reference to `ARRAY_SIZE'
> relocs.c:(.text+0xe10): undefined reference to `ARRAY_SIZE'
> relocs.c:(.text+0xe2b): undefined reference to `ARRAY_SIZE'
> collect2: ld returned 1 exit status
> make[2]: *** [arch/i386/boot/compressed/relocs] Error 1
> make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2
> make: *** [bzImage] Error 2

---
~Randy
