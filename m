Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131238AbRCUIK5>; Wed, 21 Mar 2001 03:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131239AbRCUIKh>; Wed, 21 Mar 2001 03:10:37 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:4839 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131238AbRCUIKa>; Wed, 21 Mar 2001 03:10:30 -0500
Message-ID: <3AB860A8.182A10C7@mvista.com>
Date: Wed, 21 Mar 2001 00:04:56 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nigel@nrg.org
CC: Keith Owens <kaos@ocs.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <Pine.LNX.4.05.10103201920410.26853-100000@cosmic.nrg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Gamble wrote:
> 
> On Wed, 21 Mar 2001, Keith Owens wrote:
> > I misread the code, but the idea is still correct.  Add a preemption
> > depth counter to each cpu, when you schedule and the depth is zero then
> > you know that the cpu is no longer holding any references to quiesced
> > structures.
> 
> A task that has been preempted is on the run queue and can be
> rescheduled on a different CPU, so I can't see how a per-CPU counter
> would work.  It seems to me that you would need a per run queue
> counter, like the example I gave in a previous posting.

Exactly so.  The method does not depend on the sum of preemption being
zip, but on each potential reader (writers take locks) passing thru a
"sync point".  Your notion of waiting for each task to arrive
"naturally" at schedule() would work.  It is, in fact, over kill as you
could also add arrival at sys call exit as a (the) "sync point".  In
fact, for module unload, isn't this the real "sync point"?  After all, a
module can call schedule, or did I miss a usage counter somewhere?

By the way, there is a paper on this somewhere on the web.  Anyone
remember where?

George
