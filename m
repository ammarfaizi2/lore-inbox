Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264558AbSIQTxJ>; Tue, 17 Sep 2002 15:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264559AbSIQTxJ>; Tue, 17 Sep 2002 15:53:09 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:39907 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S264558AbSIQTxI>; Tue, 17 Sep 2002 15:53:08 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Steven Cole <elenstev@mesatop.com>
To: Robert Love <rml@tech9.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1032290611.4592.206.camel@phantasy>
References: <Pine.LNX.4.44.0209172055550.13829-100000@localhost.localdomain> 
	<1032290611.4592.206.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 17 Sep 2002 13:54:28 -0600
Message-Id: <1032292468.11907.44.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 13:23, Robert Love wrote:
> On Tue, 2002-09-17 at 14:57, Ingo Molnar wrote:
> 
> > i'd do (a). current->state is to be used anyway, and the default-untaken
> > first branch should be cheap. Plus by moving things down the splitup of
> > the function would create more code duplication than necessery i think.
> 
> Note by moving it down, the only gain over keeping it at the top is not
> having to check for the BKL...
> 
> Anyhow, I would appreciate it if you could give this a try (with kernel
> preemption enabled)... any comments are appreciated.
> 
> (Note you need a 2.5.35-bk release to get the dump_stack().  Otherwise
> use show_trace(0).)
> 
> 	Robert Love
> 
I applied that patch to 2.5.35-bk3 and with PREEMPT enabled.  And it
booted without any of the usual complaints with preempt and the
in_atomic check.  But then, I ran

1) dbench 1 OK
2) dbench 2 OK
3) dbench 3 blam!  

Running dbench 3 resulted in the dbench clients hanging and being
unkillable with kill -9 in the D state.

steven    1046  0.0  0.0  1440  472 ?        D    13:46   0:00 ./dbench 3
steven    1047  0.0  0.0  1440  420 ?        D    13:46   0:00 ./dbench 3
steven    1048  0.0  0.0  1440  472 ?        D    13:46   0:00 ./dbench 3

I can ssh and enter my user password, but it hangs after that with
no bash prompt.  Other ssh sessions which I started previously are still
responsive.

Test box is 2-way pIII, kernel SMP.

Steven

