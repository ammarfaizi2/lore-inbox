Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbTAWB12>; Wed, 22 Jan 2003 20:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbTAWB12>; Wed, 22 Jan 2003 20:27:28 -0500
Received: from air-2.osdl.org ([65.172.181.6]:43753 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264790AbTAWB11>;
	Wed, 22 Jan 2003 20:27:27 -0500
Date: Wed, 22 Jan 2003 17:31:01 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <high-res-timers-discourse@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
cc: <jim.houston@attbi.com>
Subject: alternate high-res-timers patch comments (II)
Message-ID: <Pine.LNX.4.33L2.0301221712200.3511-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here are more comments/questions on Jim's alternate high-res-timers
patch.  Some of this is just to understand the code.


a.  Why return here and skip profiling?
    Is this an intermediate (high-res) timer interrupt that shouldn't be
    used for profiling?

 inline void smp_local_timer_interrupt(struct pt_regs * regs)
 {
   	int cpu = smp_processor_id();
+
+	if (!run_posix_timers((void *)regs))
+		return;

  	x86_do_profile(regs);


b.  In kernel/id2ptr.c,

<id_free_cnt>:  change cnt to count; just a style thing.
Linux doesn't use many abbreviations, which makes it easier on
everyone not having to remember "what is the abbreviation that code
uses for <whatever>?".

sub_alloc() is recursive.  How bounded is it?  32 calls max?
I'm not totally against recursion, but it needs to be *well-bounded*.

Same for sub_remove().

-- 
~Randy

