Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUEJLVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUEJLVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 07:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbUEJLVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 07:21:44 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:14480 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264638AbUEJLUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 07:20:02 -0400
Date: Mon, 10 May 2004 12:18:45 +0100
From: Dave Jones <davej@redhat.com>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-mm1
Message-ID: <20040510111845.GB21671@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dominik Karall <dominik.karall@gmx.net>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20040510024506.1a9023b6.akpm@osdl.org> <200405101252.33205.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405101252.33205.dominik.karall@gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 12:52:33PM +0200, Dominik Karall wrote:
 > 
 >   CC      arch/i386/kernel/cpu/cpufreq/p4-clockmod.o
 > arch/i386/kernel/cpu/cpufreq/p4-clockmod.c: In Funktion >>cpufreq_p4_get<<:
 > arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:283: error: `sibling' undeclared 
 > (first use in this function)
 > arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:283: error: (Each undeclared 
 > identifier is reported only once
 > arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:283: error: for each function it 
 > appears in.)
 > make[4]: *** [arch/i386/kernel/cpu/cpufreq/p4-clockmod.o] Fehler 1

Oops.

		Dave

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/10 12:17:30+01:00 davej@redhat.com 
#   [CPUFREQ] Compilation fix.
# 
# arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
#   2004/05/10 12:17:25+01:00 davej@redhat.com +3 -2
#   [CPUFREQ] Compilation fix.
# 
diff -Nru a/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c b/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- a/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Mon May 10 12:18:08 2004
+++ b/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	Mon May 10 12:18:08 2004
@@ -74,7 +74,7 @@
 	hyperthreading = ((cpu_has_ht) && (smp_num_siblings == 2));
 	if (hyperthreading) {
 		sibling = cpu_sibling_map[cpu];
-                cpu_set(sibling, affected_cpu_map);
+		cpu_set(sibling, affected_cpu_map);
 	}
 #endif
 	set_cpus_allowed(current, affected_cpu_map);
@@ -283,12 +283,13 @@
 #ifdef CONFIG_X86_HT
 	hyperthreading = ((cpu_has_ht) && (smp_num_siblings == 2));
 	if (hyperthreading) {
+		int sibling;
 		sibling = cpu_sibling_map[cpu];
 		cpu_set(sibling, affected_cpu_map);
 	}
 #endif
 	set_cpus_allowed(current, affected_cpu_map);
-        BUG_ON(!cpu_isset(smp_processor_id(), affected_cpu_map));
+	BUG_ON(!cpu_isset(smp_processor_id(), affected_cpu_map));
 
 	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
 
