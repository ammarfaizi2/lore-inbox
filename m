Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266267AbUBQQut (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUBQQut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:50:49 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:32153 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266267AbUBQQup
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:50:45 -0500
Message-ID: <4032452F.2090001@cyberone.com.au>
Date: Wed, 18 Feb 2004 03:45:35 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
Subject: Re: [BENCHMARK] 2.6.3-rc2 v 2.6.3-rc3-mm1 kernbench
References: <Pine.LNX.3.96.1040217110549.8209A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1040217110549.8209A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bill Davidsen wrote:

>On Tue, 17 Feb 2004, Nick Piggin wrote:
>
>
>
>>Bill, I have CC'ed your message without modification because Con is
>>not subscribed to the list. Even for people who are subscribed, the
>>convention on lkml is to reply to all.
>>
>>Anyway, the "no SMT" run is with CONFIG_SCHED_SMT turned off, P4 HT
>>is still on. This was my fault because I didn't specify clearly that
>>I wanted to see a run with hardware HT turned off, although these
>>numbers are still interesting.
>>
>>Con hasn't tried HT off AFAIK because we couldn't work out how to
>>turn it off at boot time! :(
>>
>
>The curse of the brain-dead BIOS :-(
>
>So does CONFIG_SCHED_SMT turned off mean not using more than one sibling
>per package, or just going back to using them poorly? Yes, I should go
>root through the code.
>
>

It just goes back to treating them the same as physical CPUs.
The option will be eventually removed.

>Clearly it would be good to get one more data point with HT off in BIOS,
>but from this data it looks as if the SMT stuff really helps little when
>the system is very heavily loaded (Nproc>=Nsibs), and does best when the
>load is around Nproc==Ncpu. At least as I read the data. The really
>interesting data would be the -j64 load without HT, using both schedulers.
>
>

The biggest problems with SMT happen when 1 < Nproc < Nsibs,
because every two processes that end up on one physical CPU
leaves one physical CPU idle, and the non HT scheduler can't
detect or correct this.

At higher numbers of processes, you fill all virtual CPUs,
so physical CPUs don't become idle. You can still be smarter
about cache and migration costs though.


>I just got done looking at a mail server with HT, kept the load avg 40-70
>for a week. Speaks highly for the stability of RHEL-3.0, but I wouldn't
>mind a little more performance for free.
>
>

Not sure if they have any sort of HT aware scheduler or not.
If they do it is probably a shared runqueues type which is
much the same as sched domains in terms of functionality.
I don't think it would help much here though.

