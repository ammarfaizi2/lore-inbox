Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269070AbUJUMwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269070AbUJUMwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268766AbUJUMwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:52:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31250 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269070AbUJUMuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:50:18 -0400
Date: Thu, 21 Oct 2004 14:49:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] 2.6.9-ac1: invalid SUBLEVEL
Message-ID: <20041021124945.GD10801@stusta.de>
References: <1098356892.17052.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098356892.17052.18.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

$ make
  CHK     include/linux/version.h
expr: non-numeric argument
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC      kernel/power/swsusp.o
kernel/power/swsusp.c: In function `init_header':
kernel/power/swsusp.c:327: parse error before `;'
kernel/power/swsusp.c: In function `sanity_check':
kernel/power/swsusp.c:1074: parse error before `)'
make[2]: *** [kernel/power/swsusp.o] Error 1
make[1]: *** [kernel/power] Error 2
make: *** [kernel] Error 2
$ cat 
include/linux/version.h 
#define UTS_RELEASE "2.6.9-ac1"
#define LINUX_VERSION_CODE
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
$ 

<--  snip  -->


Proposed fix:


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-ac1-full/Makefile.old	2004-10-21 14:48:07.000000000 +0200
+++ linux-2.6.9-ac1-full/Makefile	2004-10-21 14:48:30.000000000 +0200
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
-SUBLEVEL = 9-ac1
-EXTRAVERSION =
+SUBLEVEL = 9
+EXTRAVERSION = -ac1
 NAME=AC 1
 
 # *DOCUMENTATION*

