Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262535AbSJAVLi>; Tue, 1 Oct 2002 17:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262834AbSJAVLi>; Tue, 1 Oct 2002 17:11:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58858 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262535AbSJAVLh>;
	Tue, 1 Oct 2002 17:11:37 -0400
Date: Tue, 1 Oct 2002 23:27:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
In-Reply-To: <Pine.LNX.4.44.0210011251050.10307-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0210012323200.25070-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Oct 2002, Kai Germaschewski wrote:

> I'm possibly messing things up here, but doesn't it generally make more
> sense to convert tq_immediate users to tasklets instead of work queues?
> 
> tq_immediate users do not need process context, and one use I'm familiar
> with is basically doing bottom half interrupt processing, e.g. in lots
> of places in the ISDN code. Introducing a context switch for no obvious
> gain there seems rather pointless to me?
> 
> The same may be true for the tq_timer users as well?

the main reason was that it was easier to convert everything (even old-BH
style code) that did deferred processing to workqueues than to tasklets -
since a fair chunk of deferred processing needs process context. Another
reason is that generally it's easier to handle overload situations if the
work is done in process contexts. But i agree, for things where it really
matters performance-wise, introducing a tasklet should be the next step.

	Ingo

