Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272359AbTHECPA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 22:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272371AbTHECO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 22:14:59 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:30106
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272359AbTHECO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 22:14:58 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 5 Aug 2003 12:20:04 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200308050207.18096.kernel@kolivas.org> <3F2F1236.6050900@cyberone.com.au>
In-Reply-To: <3F2F1236.6050900@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308051220.04779.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 12:11, Nick Piggin wrote:
> Con Kolivas wrote:
> >Changes:
> >
> >Reverted the child penalty to 95 as new changes help this from hurting
> >
> >Changed the logic behind loss of interactive credits to those that burn
> > off all their sleep_avg
> >
> >Now all tasks get proportionately more sleep as their relative bonus drops
> >off. This has the effect of detecting a change from a cpu burner to an
> >interactive task more rapidly as in O10.
> >
> >The _major_ change in this patch is that tasks on uninterruptible sleep do
> > not earn any sleep avg during that sleep; it is not voluntary sleep so
> > they should not get it. This has the effect of stopping cpu hogs from
> > gaining dynamic priority during periods of heavy I/O. Very good for the
> > jerks you may see in X or audio skips when you start a whole swag of disk
> > intensive cpu hogs (eg make -j large number). I've simply dropped all
> > their sleep_avg, but weighting it may be more appropriate. This has the
> > side effect that pure disk tasks (eg cp) have relatively low priority
> > which is why weighting may be better. We shall see.
>
> I don't think this is a good idea. Uninterruptible does not mean its
> not a voluntary sleep. Its more to do with how a syscall is implemented.
> I don't think it should be treated any differently to any other type of
> sleep.
>
> Any task which calls schedule in kernel context is sleeping volintarily
> - if implicity due to having called a blocking syscall.
>
> >Please test this one extensively. It should _not_ affect I/O throughput
> > per se, but I'd like to see some of the I/O benchmarks on this. I do not
> > want to have detrimental effects elsewhere.
>
> Well the reason it can affect IO thoughput is for example when there is
> an IO bound process and a CPU hog on the same processor: the longer the
> IO process has to wait (after being woken) before being run, the more
> chance the disk will fall idle for a longer period. And of course the
> CPU uncontended case is somewhat uninteresting when it comes to a CPU
> scheduler.

I've already posted a better solution in O13.1

Con

