Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263382AbTC2EjY>; Fri, 28 Mar 2003 23:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263383AbTC2EjY>; Fri, 28 Mar 2003 23:39:24 -0500
Received: from fmr05.intel.com ([134.134.136.6]:32709 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S263382AbTC2EjX> convert rfc822-to-8bit; Fri, 28 Mar 2003 23:39:23 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C780B7177A5@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>,
       "'Ingo Molnar (mingo@redhat.com)'" <mingo@redhat.com>
Subject: migration_thread()'s priority too low?
Date: Fri, 28 Mar 2003 20:50:32 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all, Ingo

I am having some trouble in the priority-inheritance wakeup code when
using FIFO tasks - I was wondering: migration_thread() has the equivalent of
a FIFO priority 0; thus, it will be left out by any FIFO task and migration
won't work - I don't think this is causing the problem to my test cases, but
I was curious anyway.

Setting it in 2.5.66's sched.c like this

@@ -2436,7 +2435,7 @@
  */
 static int migration_thread(void * data)
 {
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
+	struct sched_param param = { .sched_priority = 0 };
 	int cpu = (long) data;
 	runqueue_t *rq;
 	int ret;

gives it max priority; it'd be interesting though to have an extra level so
have FIFO 99 be 1 in the index and 0 still be free for system stuff.

Of course I can be missing anything really clear. Is it intentionate that
migration_thread() has FIFO 0?

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
