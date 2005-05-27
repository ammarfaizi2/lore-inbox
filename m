Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVE0JXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVE0JXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVE0JXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:23:54 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:22947
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262408AbVE0JDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:03:35 -0400
Subject: Re: RT patch acceptance
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andi Kleen <ak@muc.de>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       dwalker@mvista.com, bhuey@lnxw.com, nickpiggin@yahoo.com.au,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050526202747.GB86087@muc.de>
References: <20050525005942.GA24893@nietzsche.lynx.com>
	 <1116982977.19926.63.camel@dhcp153.mvista.com>
	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>
	 <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu>
	 <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
	 <20050526193230.GY86087@muc.de>
	 <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
	 <20050526202747.GB86087@muc.de>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 27 May 2005 11:03:50 +0200
Message-Id: <1117184630.6736.415.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 22:27 +0200, Andi Kleen wrote:
> I really dislike the idea of interrupt threads. It seems totally
> wrong to me to make such a fundamental operation as an interrupt
> much slower.  If really any interrupts take too long they should
> move to workqueues instead and be preempted there. 

I don't see a real good argument why an interrupt is such a fundamental
operation which has to be treated seperately. It is a computation type
with a set of constraints. It depends on your system requirements which
importance and execution mechanism you select for the computation in
order to fulfil the constraints.

If you want deterministic control in an OS you have to control _all_
computation types by the scheduler. IRQ to thread conversion is one of
many mechanisms to gain control over the execution behaviour of
interrupt type computations. It has an nice advantage over other
mechanisms as it is simple to understand; people are used to deal with
threads and priorities.

> But keep
> the basic fundamental operations fast please (at least that used to be one
> of the Linux mottos that served it very well for many years, although more
> and more people seem to forget it now) 

"It has been that way since ages" arguments are not really productive in
a discussion. If you look at the history of Linux over the years, many
things which seemed to be untouchable have been changed in order to make
it usable for specific application types.

Linux deals quite well with a broad range of application scenarios and
there is quite a lot of interest from industrial users to have RT
features included. Sure you may argue that the addon solutions,
nanokernel approaches are available for that, but industrial users are
looking for a scalable all in one solution, where they can turn on the
features they need for the specific application.


tglx


