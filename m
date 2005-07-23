Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVGWSGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVGWSGm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 14:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVGWSGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 14:06:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9365 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261423AbVGWSFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 14:05:41 -0400
Date: Sat, 23 Jul 2005 11:02:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
In-Reply-To: <1122140791.3582.25.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0507231056270.6074@g5.osdl.org>
References: <200507230313_MC3-1-A554-6927@compuserve.com> 
 <Pine.LNX.4.58.0507231033370.6074@g5.osdl.org> <1122140791.3582.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Jul 2005, Arjan van de Ven wrote:
> 
> For the kernel the runtime measurement is obviously tricky (kgprof
> anyone?)

Ehh, doesn't "opgprof" do that already?

Anyway, judging by real life, people just don't _do_ profile runs. Any 
build automation that depends on the user profiling the result is a total 
wet dream by compiler developers - it just doesn't happen in real life.

So:

> but the static analysis method really shouldn't be too hard.

I really think that the static analysis is the only one that actually 
would matter in real life. It's also the only one that is repeatable, 
which is a big big bonus, since at least that way different people are 
running basically the same code (heisenbugs, anyone?) and benchmarks are 
actually meaningful, since they don't depend on whatever load was picked 
to generate the layout.

So dynamic analysis with dynamic profile data is just one big theoretical
compiler-writer masturbation session, in my not-so-humble opinion. I bet
static analysis (with possibly some hints from the programmer, the same
way we use likely/unlikely) gets you 90% of the way, without all the
downsides.

		Linus
