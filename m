Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285246AbRL2Sw3>; Sat, 29 Dec 2001 13:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285236AbRL2SwT>; Sat, 29 Dec 2001 13:52:19 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:38025 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285229AbRL2SwF>;
	Sat, 29 Dec 2001 13:52:05 -0500
Date: Sat, 29 Dec 2001 13:52:03 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Bernhard Rosenkraenzer <bero@redhat.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] exporting seq_* stuff
In-Reply-To: <Pine.LNX.4.42.0112291626430.23274-200000@bochum.stuttgart.redhat.com>
Message-ID: <Pine.GSO.4.21.0112291328160.5671-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Dec 2001, Bernhard Rosenkraenzer wrote:

> depmod: *** Unresolved symbols in /lib/modules/2.5.2-pre3/kernel/fs/nfs/nfs.o
> depmod:         seq_escape
> depmod:         seq_printf
> 
> I'm quite sure the patch I've attached is *not* the right thing to do(tm), 
> but it works for me until we get a better fix. ;)
> 
> LLaP
> bero

[snip the attached horror]

diff -urN C2-pre3/kernel/ksyms.c C2-pre3-fix/kernel/ksyms.c
--- C2-pre3/kernel/ksyms.c	Thu Dec 27 19:48:04 2001
+++ C2-pre3-fix/kernel/ksyms.c	Sat Dec 29 13:48:12 2001
@@ -46,6 +46,7 @@
 #include <linux/tty.h>
 #include <linux/in6.h>
 #include <linux/completion.h>
+#include <linux/seq_file.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -480,6 +481,12 @@
 EXPORT_SYMBOL(reparent_to_init);
 EXPORT_SYMBOL(daemonize);
 EXPORT_SYMBOL(csum_partial); /* for networking and md */
+EXPORT_SYMBOL(seq_escape);
+EXPORT_SYMBOL(seq_printf);
+EXPORT_SYMBOL(seq_open);
+EXPORT_SYMBOL(seq_release);
+EXPORT_SYMBOL(seq_read);
+EXPORT_SYMBOL(seq_lseek);
 
 /* Program loader interfaces */
 EXPORT_SYMBOL(setup_arg_pages);

