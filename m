Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVAKUl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVAKUl2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVAKUl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:41:28 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:12435
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262174AbVAKUkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:40:53 -0500
Subject: Re: User space out of memory approach
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Edjard Souza Mota <edjard@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <1105461106.16168.41.camel@localhost.localdomain>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <1105461106.16168.41.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 21:40:47 +0100
Message-Id: <1105476047.17853.120.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 16:32 +0000, Alan Cox wrote:
> On Maw, 2005-01-11 at 08:44, Thomas Gleixner wrote:
> > I consider the invocation of out_of_memory in the first place. This is
> > the real root of the problems. The ranking is a different playground.
> > Your solution does not solve
> > - invocation madness
> > - reentrancy protection
> > - the ugly mess of timers, counters... in out_of_memory, which aren't
> > neccecary at all
> > 
> > This must be solved first in a proper way, before we talk about ranking.
> 
> echo "2" >/proc/sys/vm/overcommit_memory
> 
> End of problem (except for extreme cases) and with current 2.6.10-bk
> (and -ac because I pulled the patch back into -ac) also for most extreme
> cases as Andries pre-reserves the stack address spaces.

Maybe for you it's end of problem, but I still can reproduce the weird
behaviour with 2.6.10-bk with the tests I posted before. I don't buy end
of problem proclamations, as long as I can proove the contrary.

The only working patch so far is Andrea's fix of the invocation, which
also solves the reentrancy problem, gets rid of the timer,counter hack
and my small contribution to the selection algorithm.

tglx


