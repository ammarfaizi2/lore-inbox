Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264148AbTEGSLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264149AbTEGSLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:11:21 -0400
Received: from holomorphy.com ([66.224.33.161]:28049 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264148AbTEGSLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:11:20 -0400
Date: Wed, 7 May 2003 11:23:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030507182336.GV8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <20030507143315.GA6879@stargate.galaxy> <20030507144736.GE8978@holomorphy.com> <20030507164901.GB19324@wohnheim.fh-wedel.de> <Pine.LNX.4.50.0305071009050.2208-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0305071009050.2208-100000@blue1.dev.mcafeelabs.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 10:18:29AM -0700, Davide Libenzi wrote:
> I'm afraid I do not agree with both your sentences. Changing a *working
> kernel* code is definitely not much fun and not really less work if your
> target is the per-cpu kernel stack. You'll completely lose kernel
> preemption and this is really bad since many paths inside the kernel are
> easily preemptable. The design and the code of the kernel will become more
> complex (and slow) and even people that are correctly programming it are
> going to pay the price. No thanks, I'd say screw you thread maniacs ...

Yes, the interrupt model of programming more or less requires
preemption be explicit in every case. Every scheduling point would have
to be explicitly registered as a splitup of the function into the code
run before the scheduling point and a continuation for the code after.
As preempt works now most points should be clearly delimited, since it
inserts an implicit schedule() at lock droppings, and things like
cond_sched() and yield(). The points where preempt_count() == 0 and
things could be preempted by scheduling off of returning from interrupts
would be lost, though. Yes, this is probably as inefficient as it sounds
from the bit about introducing an indirect function call and queueing
operation at all those points.

I did mention something about the overhead for the general case, which
is one reason why no one will ever seriously entertain the notion.

I don't see a threat of anything like this appearing in the near future,
since the implementation effort required is probably greater than that
of reimplementing significant chunks of the kernel from scratch if not
writing an entire kernel from scratch. In fact, the model is a poor fit
for the C language and is basically just too painful to program, which
is probably more important than even the performance considerations.
But some appropriate performance-relevant bits for aio shouldn't hurt,
especially since they fall back to normal methods when not async.


-- wli
