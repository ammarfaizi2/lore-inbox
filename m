Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbTJRPY5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 11:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTJRPY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 11:24:57 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:39809 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S261680AbTJRPY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 11:24:27 -0400
Date: Sat, 18 Oct 2003 16:22:14 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: Thomas Giese <Thomas.Giese@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-microcode
In-Reply-To: <008c01c39588$9b6f7650$fb457dc0@tgasterix>
Message-ID: <Pine.LNX.4.44.0310181620130.11299-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Yes, thank you, it was noticed by several people already. Just apply this 
patch and it will compile. The version of gcc that I am using didn't have 
a problem with that:

$ gcc --version
gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7)

Kind regards
Tigran

>From roland@topspin.com Sat Oct 18 16:20:08 2003
Date: 17 Oct 2003 16:43:29 -0700
From: Roland Dreier <roland@topspin.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test8

Here's a fix for compiling with gcc 2.95 (a variable declaration got
mixed in with code):

--- linux-2.6.0-test8/arch/i386/kernel/microcode.c.orig	Fri Oct 17 16:36:47 2003
+++ linux-2.6.0-test8/arch/i386/kernel/microcode.c	Fri Oct 17 16:37:03 2003
@@ -324,8 +324,9 @@
 					/* check extended table checksum */
 					if (ext_table_size) {
 						int ext_table_sum = 0;
+						int * ext_tablep;
 						i = ext_table_size / DWSIZE;
-						int * ext_tablep = (((void *) newmc) + MC_HEADER_SIZE + data_size);
+						ext_tablep = (((void *) newmc) + MC_HEADER_SIZE + data_size);
 						while (i--) ext_table_sum += ext_tablep[i];
 						if (ext_table_sum) {
 							printk(KERN_WARNING "microcode: aborting, bad extended signature table checksum\n");

