Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315544AbSGLRrD>; Fri, 12 Jul 2002 13:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSGLRrC>; Fri, 12 Jul 2002 13:47:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4088 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315544AbSGLRrC>; Fri, 12 Jul 2002 13:47:02 -0400
Subject: Re: spinlock assertion macros
From: Robert Love <rml@tech9.net>
To: Dave Jones <davej@suse.de>
Cc: Daniel Phillips <phillips@arcor.de>, Jesse Barnes <jbarnes@sgi.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020712140751.A14671@suse.de>
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com>
	<E17SWXm-0002BL-00@starship> <20020711180326.GH709072@sgi.com>
	<E17SjRh-0002VI-00@starship>  <20020712140751.A14671@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Jul 2002 10:49:42 -0700
Message-Id: <1026496182.1352.385.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-12 at 05:07, Dave Jones wrote:

> When I came up with the idea[1] I envisioned some linked-lists frobbing,
> but in more recent times, we can now check the preempt_count for a
> quick-n-dirty implementation (without the additional info of which locks
> we hold, lock-taker, etc).

Neat idea.  I have seen some other good similar ideas: check
preempt_count on schedule(), check preempt_count in usleep/msleep
(Arjan's idea), and check preempt_count in wakeup/context switch/etc.
code...

Note some of these need one or both of: subtracting out
current->lock_depth+1 since we can sleep with the BKL and NAND'ing out
PREEMPT_ACTIVE as that is set before entering schedule off a preemption.

As we move preempt_count to more of a generic "are we atomic" count in
2.5, these become easier and more useful...

	Robert Love

