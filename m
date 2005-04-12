Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbVDMAaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbVDMAaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVDLUT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:19:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:23752 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262134AbVDLKb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:29 -0400
Message-Id: <200504121031.j3CAVK5K005288@shell0.pdx.osdl.net>
Subject: [patch 041/198] ppc32: fix compilation error in arch/ppc/kernel/time.c
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benoit.boissinot@ens-lyon.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

make defconfig give the following error on ppc (gcc-4):

arch/ppc/kernel/time.c:92: error: static declaration of ‘time_offset’
follows non-static declaration
include/linux/timex.h:236: error: previous declaration of ‘time_offset’
was here

The following patch solves it (time_offset is declared in timer.c).

Signed-Off-By: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/kernel/time.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN arch/ppc/kernel/time.c~ppc32-fix-compilation-error-in-arch-ppc-kernel-timec arch/ppc/kernel/time.c
--- 25/arch/ppc/kernel/time.c~ppc32-fix-compilation-error-in-arch-ppc-kernel-timec	2005-04-12 03:21:13.140139296 -0700
+++ 25-akpm/arch/ppc/kernel/time.c	2005-04-12 03:21:13.143138840 -0700
@@ -89,8 +89,6 @@ unsigned long tb_to_ns_scale;
 
 extern unsigned long wall_jiffies;
 
-static long time_offset;
-
 DEFINE_SPINLOCK(rtc_lock);
 
 EXPORT_SYMBOL(rtc_lock);
_
