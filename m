Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268054AbUJVWJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268054AbUJVWJN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 18:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUJVWFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 18:05:42 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:55944 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S268054AbUJVWCp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 18:02:45 -0400
Message-ID: <41797852.9070700@free.fr>
Date: Fri, 22 Oct 2004 23:14:58 +0200
From: Remi Colinet <remi.colinet@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-mm1-U10.3 : compile error fix with CONFIG_HOTPLUG_CPU enable
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

With CONFIG_HOTPLUG_CPU and CONFIG_SMP enable, this patch fixes the 
following compile error.

--- mm/swap.c.orig      2004-10-22 22:31:58.000000000 +0200
+++ mm/swap.c   2004-10-22 23:10:44.202728352 +0200
@@ -423,12 +423,12 @@
 #ifdef CONFIG_HOTPLUG_CPU
 static void lru_drain_cache(unsigned int cpu)
 {
-       struct pagevec *pvec = &per_cpu(lru_add_pvecs, cpu);
+       struct pagevec *pvec = &per_cpu_var_locked(lru_add_pvecs, cpu);
 
        /* CPU is dead, so no locking needed. */
        if (pagevec_count(pvec))
                __pagevec_lru_add(pvec);
-       pvec = &per_cpu(lru_add_active_pvecs, cpu);
+       pvec = &per_cpu_var_locked(lru_add_active_pvecs, cpu);
        if (pagevec_count(pvec))
                __pagevec_lru_add_active(pvec);
 }


  CC      mm/page_alloc.o
  CC      mm/page-writeback.o
  CC      mm/pdflush.o
  CC      mm/prio_tree.o
  CC      mm/readahead.o
  CC      mm/slab.o
  CC      mm/swap.o
mm/swap.c: In function `lru_drain_cache':
mm/swap.c:426: `per_cpu__lru_add_pvecs' undeclared (first use in this 
function)
mm/swap.c:426: (Each undeclared identifier is reported only once
mm/swap.c:426: for each function it appears in.)
mm/swap.c:426: warning: type defaults to `int' in declaration of `type name'
mm/swap.c:426: invalid type argument of `unary *'
mm/swap.c:431: `per_cpu__lru_add_active_pvecs' undeclared (first use in 
this function)
mm/swap.c:431: warning: type defaults to `int' in declaration of `type name'
mm/swap.c:431: invalid type argument of `unary *'
make[1]: *** [mm/swap.o] Error 1
make: *** [mm] Error 2

Remi

