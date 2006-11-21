Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbWKUHoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbWKUHoo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 02:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030628AbWKUHoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 02:44:44 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:39071 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030507AbWKUHon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 02:44:43 -0500
Date: Tue, 21 Nov 2006 08:43:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compile problems Re: 2.6.19-rc6-rt5
Message-ID: <20061121074319.GB24711@elte.hu>
References: <20061120220230.GA30835@elte.hu> <1164078473.3258.8.camel@monteirov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164078473.3258.8.camel@monteirov>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.1119]
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> wrote:

> Now with CONFIG_HOTPLUG_CPU=y I got:
>   UPD     include/linux/compile.h
> kernel/fork.c:72: error: section of 'tasklist_lock' conflicts with previous declaration
> make[1]: *** [kernel/fork.o] Error 1

this one should be fixed by the patch below.

	Ingo

Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c
+++ linux/kernel/fork.c
@@ -69,7 +69,7 @@ int max_threads;		/* tunable limit on nr
 
 DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
-__cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
+DEFINE_RWLOCK(tasklist_lock);  /* outer */
 
 /*
  * Delayed mmdrop. In the PREEMPT_RT case we
