Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318136AbSHLPii>; Mon, 12 Aug 2002 11:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318138AbSHLPii>; Mon, 12 Aug 2002 11:38:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59829 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318136AbSHLPih>;
	Mon, 12 Aug 2002 11:38:37 -0400
Date: Mon, 12 Aug 2002 19:41:12 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Alexandre Julliard <julliard@winehq.com>,
       Luca Barbieri <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.31-D5
In-Reply-To: <20020812112155.S1596@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0208121939260.22188-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Aug 2002, Jakub Jelinek wrote:

> As each supported TLS entry has its context-switch time cost, I think we
> should stay at 2 supported TLS entries.

4 are almost as good - and they also solve the 0x40 problem.

> My understanding was that the GDT patches were written to optimize the
> common case (all threaded apps using LDT and with the advent of __thread
> support causing every single application to use LDT), with 2 TLS entries
> where one is for libc/libpthread and the other one is for application
> usage I think it is enough for 99.9% of apps. In the rare case someone
> needs more, there is still LDT which offers 8192 entries.

well, i think i have to agree ... if it wasnt for Wine's 0x40 descriptor.  
But it certainly does not come free. We could have 3 TLS entries (0x40
will be the last entry), and the copying cost is 9 cycles. (compared to 6
cycles in the 2 entries case.) Good enough?

	Ingo

