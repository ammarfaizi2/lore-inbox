Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUCBL2L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 06:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbUCBL2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 06:28:11 -0500
Received: from alpha.zarz.agh.edu.pl ([149.156.122.231]:26372 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261606AbUCBL2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 06:28:08 -0500
Date: Tue, 2 Mar 2004 13:24:03 +0100 (CET)
From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [SPARC][patch] sys_ioperm
Message-ID: <Pine.LNX.4.58L.0403021316370.7737@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I try to build linux-2.6.4-rc1 with cset-20040302_0009 on SPARC.
And I got error:

In file included from include/linux/unistd.h:9,
                 from init/main.c:21:
include/asm/unistd.h:464: error: conflicting types for `sys_ioperm'
include/linux/syscalls.h:291: error: previous declaration of `sys_ioperm'
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

Fixed this (?) by this patch: 

--- linux-2.6.4-rc1/include/asm-sparc/unistd.h.org	2004-02-27 23:20:57.000000000 +0100
+++ linux-2.6.4-rc1/include/asm-sparc/unistd.h	2004-03-02 13:10:39.229091144 +0100
@@ -461,7 +461,7 @@
 				unsigned long addr, unsigned long len,
 				unsigned long prot, unsigned long flags,
 				unsigned long fd, unsigned long pgoff);
-asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int on);
+asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,

-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
