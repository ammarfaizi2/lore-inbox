Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262860AbVBEHjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbVBEHjQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 02:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVBEHjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 02:39:16 -0500
Received: from colin2.muc.de ([193.149.48.15]:55818 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266531AbVBEHie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 02:38:34 -0500
Date: 5 Feb 2005 08:38:33 +0100
Date: Sat, 5 Feb 2005 08:38:33 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: [PATCH] x86-64: Fix compilation of 2.6.11rc3
Message-ID: <20050205073833.GB58749@muc.de>
References: <3174569B9743D511922F00A0C94314230808546A@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230808546A@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Linus, please apply before 2.6.11]

> > >   CC      arch/x86_64/kernel/asm-offsets.s
> > > arch/x86_64/kernel/asm-offsets.c: In function `main':
> > > arch/x86_64/kernel/asm-offsets.c:65: error: invalid 
> > application of `sizeof'
> > > to an incomplete type


This patch fixes a compile problem on x86-64 when CONFIG_PM 
is turned off. 

Signed-off-by: Andi Kleen <ak@suse.de>


diff -u linux-2.6.11rc3/include/linux/suspend.h-o linux-2.6.11rc3/include/linux/suspend.h
--- linux-2.6.11rc3/include/linux/suspend.h-o	2005-02-04 09:13:32.000000000 +0100
+++ linux-2.6.11rc3/include/linux/suspend.h	2005-02-05 08:25:13.000000000 +0100
@@ -10,7 +10,6 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 
-#ifdef CONFIG_PM
 /* page backup entry */
 typedef struct pbe {
 	unsigned long address;		/* address of the copy */
@@ -33,6 +32,7 @@
 extern void drain_local_pages(void);
 extern void mark_free_pages(struct zone *zone);
 
+#ifdef CONFIG_PM
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
 
