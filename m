Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSHOGtT>; Thu, 15 Aug 2002 02:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSHOGtT>; Thu, 15 Aug 2002 02:49:19 -0400
Received: from dp.samba.org ([66.70.73.150]:61057 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S313571AbSHOGtT>;
	Thu, 15 Aug 2002 02:49:19 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, ak@suse.de
Subject: Getting rid of irq_stat_t
Date: Thu, 15 Aug 2002 16:52:52 +1000
Message-Id: <20020815015340.52C2B2C24B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Doing per-cpu cleanups: everyone except ia64 and x86_64 use
the generic irq_stat_t macros.  There are two obvious ways to go: one
is to simply use per-cpu macros directly (nice and clean), the other
is to rework the softirq_pending() etc macros (adding
local_softirq_pending()) to use per-cpu everywhere except your two
platforms, which means callers need to disable preemption explicitly
(get_* and put* versions of the macros seems overkill).

	The motivation is that accessing irq_stat_t is one of the main
reasons for smp_processor_id() etc.

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
