Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268947AbUJEK5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268947AbUJEK5l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 06:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268968AbUJEK5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 06:57:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:50914 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268947AbUJEK5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 06:57:38 -0400
X-Authenticated: #4399952
Date: Tue, 5 Oct 2004 13:12:37 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm2-T0
Message-ID: <20041005131237.63378c53@mango.fruits.de>
In-Reply-To: <Pine.LNX.4.58.0410050257400.5641@devserv.devel.redhat.com>
References: <20040919122618.GA24982@elte.hu>
	<414F8CFB.3030901@cybsft.com>
	<20040921071854.GA7604@elte.hu>
	<20040921074426.GA10477@elte.hu>
	<20040922103340.GA9683@elte.hu>
	<20040923122838.GA9252@elte.hu>
	<20040923211206.GA2366@elte.hu>
	<20040924074416.GA17924@elte.hu>
	<20040928000516.GA3096@elte.hu>
	<20041003210926.GA1267@elte.hu>
	<20041004215315.GA17707@elte.hu>
	<Pine.LNX.4.58.0410050257400.5641@devserv.devel.redhat.com>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004 03:02:05 -0400 (EDT)
Ingo Molnar <mingo@redhat.com> wrote:

> i've released the -T0 VP patch:

>  - fix !4K stack compilation breakage (reported by Lee Revell)

I still need to enable 4k stacks to get it to build [see error below w/o 4k
stacks].

But xrun hell is no more [as opposed to S8 and S9]. jackd seems to run fine
again. I suspect the reverted scheduler changes to have fixed this
[uneducated guess], since in S8 and S9 the system behaved all different
[sloppy X when compiling stuff. jackd producing xruns although everything is
setup for ll ok].

flo

  CC      arch/i386/kernel/irq.o
arch/i386/kernel/irq.c:205: error: redefinition of `is_irq_stack_ptr'
include/asm/hardirq.h:25: error: `is_irq_stack_ptr' previously defined here
arch/i386/kernel/irq.c: In function `is_irq_stack_ptr':
arch/i386/kernel/irq.c:209: error: `hardirq_stack' undeclared (first use in this function)
arch/i386/kernel/irq.c:209: error: (Each undeclared identifier is reported only once
arch/i386/kernel/irq.c:209: error: for each function it appears in.)
arch/i386/kernel/irq.c:212: error: `softirq_stack' undeclared (first use in this function)
make[1]: *** [arch/i386/kernel/irq.o] Error 1
make: *** [arch/i386/kernel] Error 2
