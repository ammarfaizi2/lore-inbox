Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317372AbSFRJgr>; Tue, 18 Jun 2002 05:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317370AbSFRJgq>; Tue, 18 Jun 2002 05:36:46 -0400
Received: from mail.webmaster.com ([216.152.64.131]:54782 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317368AbSFRJgp> convert rfc822-to-8bit; Tue, 18 Jun 2002 05:36:45 -0400
From: David Schwartz <davids@webmaster.com>
To: <rml@tech9.net>
CC: <mgix@mgix.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Tue, 18 Jun 2002 02:36:43 -0700
In-Reply-To: <1024361703.924.176.camel@sinai>
Subject: Re: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020618093644.AAA9337@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>And you seem to have a misconception about sched_yield, too.  If a
>machine has n tasks, half of which are doing CPU-intense work and the
>other half of which are just yielding... why on Earth would the yielding
>tasks get any noticeable amount of CPU use?

	Because they are not blocking. They are in an endless CPU burning loop. They 
should get CPU use for the same reason they should get CPU use if they're the 
only threads running. They are always ready-to-run.

>Quite frankly, even if the supposed standard says nothing of this... I
>do not care: calling sched_yield in a loop should not show up as a CPU
>hog.

	It has to. What if the only task running is:

	while(1) sched_yield();

	What would you expect? You cannot use sched_yield as a replacement for 
blocking or scheduling priority. You cannot use it to be 'nice'. You can only 
use it to try to give other threads a chance to run, usually to give them a 
chance to release a resource.

	Imagine if a spinlock uses sched_yield in its wait loop, what would you 
expect on a dual-CPU system with a process on CPU A holding the lock? You 
*want* the sched_yield process to burn the CPU fully, so that it notices the 
spinlock acquisition as soon as possible.

	While linux's sched_yield behavior is definitely sub-optimal, the particular 
criticism being leveled (that sched_yield processes get too much CPU) is 
wrong-headed.

	DS


