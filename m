Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWFAXgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWFAXgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWFAXgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:36:49 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:60638 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750964AbWFAXgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:36:49 -0400
Date: Thu, 1 Jun 2006 16:39:25 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: dwalker@mvista.com, James Perkins <james.perkins@windriver.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH-rt] ARM: Fix dump_stack() config dependencies
Message-ID: <20060601233925.GA23811@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DEBUG_ERRORS does not depend on DEBUG_MUTEXES and the kernel will not
build if the former is enabled and the later disables. Other option is
to make DEBUG_ERRORS automatically enabled DEBUG_MUTEXES in the RT case.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


Index: linux-2.6-rt/arch/arm/kernel/traps.c
===================================================================
--- linux-2.6-rt.orig/arch/arm/kernel/traps.c
+++ linux-2.6-rt/arch/arm/kernel/traps.c
@@ -178,8 +178,10 @@ void dump_stack(void)
 #ifdef CONFIG_DEBUG_ERRORS
 	__backtrace();
 	print_traces(current);
+#ifdef CONFIG_DEBUG_MUTEXES
 	show_held_locks(current);
 #endif
+#endif
 }
 
 EXPORT_SYMBOL(dump_stack);

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertold Brecht
