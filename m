Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270870AbTHFVKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270926AbTHFVKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:10:30 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:50094
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270870AbTHFVKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:10:24 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Interactivity improvements
Date: Thu, 7 Aug 2003 07:15:29 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200308050207.18096.kernel@kolivas.org> <3F2F21DF.1050601@cyberone.com.au> <3F314D6B.9090302@techsource.com>
In-Reply-To: <3F314D6B.9090302@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308070715.29461.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003 04:48, Timothy Miller wrote:
> Here's a kooky idea...
>
> I'm not sure about this detail, but I would guess that the int
> schedulers are trying to determine relatively stable priority values for
> processes.  A process does not instantly come to its correct priority
> level, because it gets there based on accumulation of behavioral patterns.
>
> Well, it occurs to me that we could benefit from situations where
> priority changes are underdamped.  The results would sometimes be an
> oscillation in priority levels.  In the short term, a given process may
> be given different amounts of CPU time when it is run, although in the
> long term, it should average out.
>
> At the same time, certain tasks can only be judged correctly over the
> long term, like X, for example.  Its long-term behavior is interactive,
> but now and then, it will become a CPU hog, and we want to LET it.
>
> The idea I'm proposing, however poorly formed, is that if we allow some
> "excessive" oscillation early on in the life of a process, we may be
> able to more quickly get processes to NEAR its correct priority, OR get
> its CPU time over the course of three times being run for the
> underdamped case to be about the same as it would be if we knew in
> advance what the priority should be.  But in the underdamped case, the
> priority would continue to oscillate up and down around the correct
> level, because we are intentionally overshooting the mark each time we
> adjust priority.
>
> This may not be related, but something that pops into my mind is a
> numerical method called Newton's Method.  It's a way to solve for roots
> of an equation, and it involved derivatives, and I don't quite remember
> how it works.  But in any event, the results are less accurate than,
> say, bisection, but you get to the answer MUCH more quickly.

Good thinking, but this is more or less already done in my code. I do have 
very rapid elevation of priority, and once something is known interactive it 
decays more slowly. It still _must_ be able to vary after the fact as 
interactive tasks can turn into cpu hogs and so on. 

Con

