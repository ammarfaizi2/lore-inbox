Return-Path: <linux-kernel-owner+w=401wt.eu-S1750708AbXACLeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbXACLeq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 06:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbXACLeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 06:34:46 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:50876 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbXACLep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 06:34:45 -0500
Date: Wed, 3 Jan 2007 17:04:39 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 2/4] i386: fix another modpost warning
Message-ID: <20070103113439.GG17546@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o MODPOST generates warning for i386 if kernel is compiled with
  CONFIG_RELOCATABLE=y

WARNING: vmlinux - Section mismatch: reference to .init.data: from .data between 'this_cpu' (at offset 0xc05194d0) and 'cpuinfo_op'

o this_cpu pointer should be of type __cpuinitdata.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/cpu/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/kernel/cpu/common.c~misc-vmlinux-modpost-warning-fixes arch/i386/kernel/cpu/common.c
--- linux-2.6.20-rc2-mm1-reloc/arch/i386/kernel/cpu/common.c~misc-vmlinux-modpost-warning-fixes	2007-01-03 11:56:49.000000000 +0530
+++ linux-2.6.20-rc2-mm1-reloc-root/arch/i386/kernel/cpu/common.c	2007-01-03 11:56:49.000000000 +0530
@@ -54,7 +54,7 @@ static struct cpu_dev __cpuinitdata defa
 	.c_init	= default_init,
 	.c_vendor = "Unknown",
 };
-static struct cpu_dev * this_cpu = &default_cpu;
+static struct cpu_dev * this_cpu __cpuinitdata = &default_cpu;
 
 static int __init cachesize_setup(char *str)
 {
_
