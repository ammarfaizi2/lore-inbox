Return-Path: <linux-kernel-owner+w=401wt.eu-S932627AbXAHILl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbXAHILl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbXAHILg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:11:36 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:42076 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932583AbXAHILR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:11:17 -0500
Date: Mon, 8 Jan 2007 13:41:13 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3/4] i386: sched_clock using init data tsc_disable fix
Message-ID: <20070108081113.GE7889@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o sched_clock() a non-init function is using init data tsc_disable. This
  is flagged by MODPOST on i386 if CONFIG_RELOCATABLE=y 

WARNING: vmlinux - Section mismatch: reference to .init.data:tsc_disable from .text between 'sched_clock' (at offset 0xc0109d58) and 'tsc_update_callback'

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/tsc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/kernel/tsc.c~sched_clock-using-init-data-tsc_disable-fix arch/i386/kernel/tsc.c
--- linux-2.6.20-rc2-mm1-reloc/arch/i386/kernel/tsc.c~sched_clock-using-init-data-tsc_disable-fix	2007-01-08 09:23:13.000000000 +0530
+++ linux-2.6.20-rc2-mm1-reloc-root/arch/i386/kernel/tsc.c	2007-01-08 09:23:48.000000000 +0530
@@ -26,7 +26,7 @@
 unsigned int tsc_khz;
 unsigned long long (*custom_sched_clock)(void);
 
-int tsc_disable __cpuinitdata = 0;
+int tsc_disable = 0;
 
 #ifdef CONFIG_X86_TSC
 static int __init tsc_setup(char *str)
_
