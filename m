Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbUKANIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbUKANIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 08:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbUKANIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 08:08:37 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:20530 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261782AbUKANIc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:08:32 -0500
Subject: Re: [PATCH][plugsched 0/28] Pluggable cpu scheduler framework
From: Kasper Sandberg <lkml@metanurb.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Pavel Machek <pavel@ucw.cz>, Con Kolivas <kernel@kolivas.org>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20041101114124.GA31458@elte.hu>
References: <4183A602.7090403@kolivas.org>
	 <20041031233313.GB6909@elf.ucw.cz>  <20041101114124.GA31458@elte.hu>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 14:08:22 +0100
Message-Id: <1099314502.14135.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-01 at 12:41 +0100, Ingo Molnar wrote:
<snip>
> I believe that by compartmenting in the wrong way [*] we kill the
> natural integration effects. We'd end up with 5 (or 20) bad generic
> schedulers that happen to work in one precise workload only, but there
> would not be enough push to build one good generic scheduler, because
> the people who are now forced to care about the Linux scheduler would be
> content about their specialized schedulers. Yes, it would be easier to
> make a specialized scheduler work well in that precise workload (because
> the developer can make the 'this is only for this parcticular workload'
> excuse), and this approach may satisfy the embedded and high-end needs
> in a quicker way. So i consider scheduler plugins as the STREAMS
> equivalent of scheduling and i am not very positive about it. Just like
> STREAMS, i consider 'scheduler plugins' as the easy but deceptive and
> wrong way out of current problems, which will create much worse problems
> than the ones it tries to solve.

i see your point, and i agree its not very nice to have specialized
schedulers for particular workloads only. however, as i see it,
plugsched doesent have any direct overhead, and plugsched doesent remove
the ability to develop on one allround scheduler, which tries to handle
all workloads good. however plugsched does give the opportunity to
create specialized schedulers, and as i see it not, staircase does a
better job in handling allround workloads(atleast for me). and it
certainly do make stuff easier.

> 
> 	Ingo
> 
> ( [*] how is this different from say the IO scheduler plugin
> architecture?  Just compare the two, it's two very different things.
> Firstly, the timescale is very different - the process scheduler cares
> about microseconds, the IO scheduler's domain is milliseconds. Also, IO
> scheduling is fundamentally per-device and often there is good
> per-device workload isolation so picking an IO scheduler per queue makes
> much more sense than say picking a scheduler per CPU ... There are other
> differences too, such as complexity and isolation from the rest of the
> system. )
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

