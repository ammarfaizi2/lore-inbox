Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317404AbSGISf0>; Tue, 9 Jul 2002 14:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317405AbSGISfZ>; Tue, 9 Jul 2002 14:35:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10961 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317404AbSGISfZ>;
	Tue, 9 Jul 2002 14:35:25 -0400
Date: Wed, 10 Jul 2002 20:31:03 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>
Subject: Re: O(1) scheduler "complex" macros
In-Reply-To: <200207091927.14537.efocht@ess.nec.de>
Message-ID: <Pine.LNX.4.44.0207102027120.14732-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jul 2002, Erich Focht wrote:

> Suppose we have 
>   cpu1: idle1
>   cpu2: prev2 -> next2  (in the switch)
> 
> I don't understand how task_lock(prev2) done on cpu2 can prevent cpu1 to
> schedule prev2, which it stole after the RQ#2 lock release. It will just
> try to task_lock(idle1), which will be successfull.

you are right - the 'complex' macros also need to lock the 'next' task,
not only the 'previous' task - but to do that deadlock-free, they need to
drop the runqueue lock ...

	Ingo

