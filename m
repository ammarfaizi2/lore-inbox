Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263240AbUCTGk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 01:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbUCTGk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 01:40:29 -0500
Received: from dp.samba.org ([66.70.73.150]:35772 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263240AbUCTGk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 01:40:28 -0500
Date: Sat, 20 Mar 2004 17:36:42 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] cpu hotplug fix
Message-ID: <20040320063642.GF1153@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


start_cpu_timer was changed to __init a few hours before the cpu hotplug
patches went in. With cpu hotplug it can be called at any time, so fix
this.

Anton

===== slab.c 1.125 vs edited =====
--- 1.125/mm/slab.c	Wed Mar 17 13:10:10 2004
+++ edited/slab.c	Sat Mar 20 17:34:57 2004
@@ -576,7 +576,7 @@
  * Add the CPU number into the expiry time to minimize the possibility of the
  * CPUs getting into lockstep and contending for the global cache chain lock.
  */
-static void __init start_cpu_timer(int cpu)
+static void start_cpu_timer(int cpu)
 {
 	struct timer_list *rt = &per_cpu(reap_timers, cpu);
 
