Return-Path: <linux-kernel-owner+w=401wt.eu-S1750718AbXACLe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbXACLe6 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 06:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbXACLe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 06:34:58 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:53892 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbXACLew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 06:34:52 -0500
Date: Wed, 3 Jan 2007 17:04:48 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 3/4] i386: modpost smpboot code warning fix
Message-ID: <20070103113448.GH17546@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Currently synchronize_tsc_ap() is of type __init. It is called by
  smp_callin() which is of type __cpuinit. So synchronize_tsc_ap()
  should be of type __cpuinit.

o Modpost generates warnings for i386 if CONFIG_RELOCATABLE=y and
  CONFIG_HOTPLUG_CPU=y

WARNING: vmlinux - Section mismatch: reference to .init.data: from .text between 'start_secondary' (at offset 0xc01164dc) and 'initialize_secondary'
WARNING: vmlinux - Section mismatch: reference to .init.data: from .text between 'start_secondary' (at offset 0xc01164e8) and 'initialize_secondary'

o tsc is of type __initdata. It should be of type __cpuinitdata. 

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/smpboot.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/smpboot.c~i386-modpost-smpboot-code-warning-fixes arch/i386/kernel/smpboot.c
--- linux-2.6.20-rc2-mm1-reloc/arch/i386/kernel/smpboot.c~i386-modpost-smpboot-code-warning-fixes	2007-01-03 11:56:55.000000000 +0530
+++ linux-2.6.20-rc2-mm1-reloc-root/arch/i386/kernel/smpboot.c	2007-01-03 11:56:55.000000000 +0530
@@ -227,7 +227,7 @@ static struct {
 	atomic_t count_start;
 	atomic_t count_stop;
 	unsigned long long values[NR_CPUS];
-} tsc __initdata = {
+} tsc __cpuinitdata = {
 	.start_flag = ATOMIC_INIT(0),
 	.count_start = ATOMIC_INIT(0),
 	.count_stop = ATOMIC_INIT(0),
@@ -332,7 +332,7 @@ static void __init synchronize_tsc_bp(vo
 		printk("passed.\n");
 }
 
-static void __init synchronize_tsc_ap(void)
+static void __cpuinit synchronize_tsc_ap(void)
 {
 	int i;
 
_
