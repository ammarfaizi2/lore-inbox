Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUAGBVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 20:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUAGBVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 20:21:53 -0500
Received: from dp.samba.org ([66.70.73.150]:4767 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266116AbUAGBVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 20:21:51 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: 2.6.1-rc1-mm[1|2] on Alpha build failure 
Cc: Nathan Poznick <kraken@drunkmonkey.org>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net
In-reply-to: Your message of "Tue, 06 Jan 2004 16:44:38 -0800."
             <20040106164438.6f5756ff.akpm@osdl.org> 
Date: Wed, 07 Jan 2004 12:16:48 +1100
Message-Id: <20040107012149.0C83D2C097@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040106164438.6f5756ff.akpm@osdl.org> you write:
> A change to include/asm-alpha/smp.h went in during 2.6.1-rc1-mm1 which
> appears to have broken compilation on Alpha.  Specifically, the addition
> of:
> #define cpu_possible_map       cpu_present_map

Arg, it's "cpu_present_mask" not "cpu_present_map" on Alpha.

My bad, but fix is trivial:

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.1-rc1-mm2/include/asm-alpha/smp.h working-2.6.1-rc1-mm2-fix-alpha/include/asm-alpha/smp.h
--- linux-2.6.1-rc1-mm2/include/asm-alpha/smp.h	2004-01-06 16:30:42.000000000 +1100
+++ working-2.6.1-rc1-mm2-fix-alpha/include/asm-alpha/smp.h	2004-01-07 12:16:13.000000000 +1100
@@ -48,7 +48,7 @@ extern struct cpuinfo_alpha cpu_data[NR_
 extern cpumask_t cpu_present_mask;
 extern cpumask_t cpu_online_map;
 extern int smp_num_cpus;
-#define cpu_possible_map	cpu_present_map
+#define cpu_possible_map	cpu_present_mask
 
 #define cpu_online(cpu)		cpu_isset(cpu, cpu_online_map)
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
