Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261503AbSJAHP5>; Tue, 1 Oct 2002 03:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbSJAHP5>; Tue, 1 Oct 2002 03:15:57 -0400
Received: from mail.ccur.com ([208.248.32.212]:60682 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id <S261503AbSJAHP4>;
	Tue, 1 Oct 2002 03:15:56 -0400
Message-ID: <3D994CD9.3FDFA09F@ccur.com>
Date: Tue, 01 Oct 2002 03:20:57 -0400
From: Jim Houston <jim.houston@ccur.com>
Reply-To: jim.houston@ccur.com
Organization: Concurrent Computer Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Jim Houston <jim.houston@attbi.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: O(1) Scheduler (tuning problem/live-lock)
References: <200209061844.g86IiF701825@linux.local> <20020930161019.GH1235@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea, Ingo,

Andrea I tried your patch and it does solve the live-lock
in the LTP waitpid06 test.  The mouse movement gets a bit
jerky but atleast it doesn't lock up.

I guess the next question is how does it do on normal work loads?

I like the idea of making the child processes start with a smaller
sleep_avg value.  Maybe it should just be a constant rather than a
fraction of the parents sleep_avg?  Its really the child processes
inheriting the favorable sleep_avg that caused the problem with
waitpid06.

I liked the idea of giving interactive tasks special treatment. 
Andrea please don't remove this.  Always putting processes
(which have used up there time slice) into the rq->expired array
makes all processes round robin at the same priority.  It makes
sense to do this to fail gracefully if the system is overloaded
but not all the time.

I hope this make sense.  I'm falling asleep writing it:-)

Jim Houston - Concurrent Computer Corp.
