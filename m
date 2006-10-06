Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWJFJMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWJFJMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 05:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWJFJMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 05:12:10 -0400
Received: from twin.jikos.cz ([213.151.79.26]:37802 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S932110AbWJFJMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 05:12:09 -0400
Date: Fri, 6 Oct 2006 11:11:56 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: keith mannthey <kmannth@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] make mach-generic/summit.c compile on UP
In-Reply-To: <1160087093.5664.14.camel@keithlap>
Message-ID: <Pine.LNX.4.64.0610061109360.12556@twin.jikos.cz>
References: <Pine.LNX.4.64.0610051913010.12556@twin.jikos.cz> 
 <1160080292.5664.9.camel@keithlap>  <Pine.LNX.4.64.0610052308000.12556@twin.jikos.cz>
 <1160087093.5664.14.camel@keithlap>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, keith mannthey wrote:

> Yea I am pretty sure CONFIG_X86_GENERIC is ment to boot UP and SMP 
> kernels.
>  Maybe just moving apicid_2_node to a UP safe location would be a good 
> way to go as well.  I overlooked the fact that CONFIG_X86_GENERIC wasn't 
> always SMP.

Below is the patch doing exactly this. Fixes compilation of Linus' git 
tree, applicable also to -mm. Please apply.

[PATCH] make kernels with CONFIG_X86_GENERIC and !CONFIG_SMP compilable

CONFIG_X86_GENERIC is not exclusively CONFIG_SMP, as mach-default/ could
be compiled also for UP archs. The patch fixes compilation error in 
include/asm/mach-summit/mach_apic.h in case CONFIG_X86_GENERIC && !CONFIG_SMP

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

 include/asm-i386/smp.h                   |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

--- a/include/asm-i386/smp.h
+++ b/include/asm-i386/smp.h
@@ -46,8 +46,6 @@ extern u8 x86_cpu_to_apicid[];
 
 #define cpu_physical_id(cpu)	x86_cpu_to_apicid[cpu]
 
-extern u8 apicid_2_node[];
-
 #ifdef CONFIG_HOTPLUG_CPU
 extern void cpu_exit_clear(void);
 extern void cpu_uninit(void);
@@ -101,6 +99,9 @@ #define NO_PROC_ID		0xFF		/* No processo
 #endif
 
 #ifndef __ASSEMBLY__
+
+extern u8 apicid_2_node[];
+
 #ifdef CONFIG_X86_LOCAL_APIC
 static __inline int logical_smp_processor_id(void)
 {

-- 
Jiri Kosina
