Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTJQXnh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 19:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTJQXnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 19:43:37 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:48444 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263632AbTJQXnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 19:43:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test8
References: <Pine.LNX.4.44.0310171530001.1988-100000@home.osdl.org>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 17 Oct 2003 16:43:29 -0700
In-Reply-To: <Pine.LNX.4.44.0310171530001.1988-100000@home.osdl.org>
Message-ID: <52ptgvo2fy.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Oct 2003 23:43:34.0067 (UTC) FILETIME=[7A4D5030:01C39508]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
