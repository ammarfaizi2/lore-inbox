Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269788AbUICUpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269788AbUICUpW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269781AbUICUnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 16:43:19 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:12694 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269810AbUICUkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 16:40:01 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
In-Reply-To: <4138A397.3060103@cybsft.com>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
	 <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu>
	 <4138A397.3060103@cybsft.com>
Content-Type: text/plain
Message-Id: <1094244004.6575.29.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 16:40:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 13:02, K.R. Foley wrote:
> OK. I previously reported about the system hanging trying to boot this 
> patch. It may have been a fluke. In any event, it doesn't hang 
> consistently. I have rebooted several times now without problems. I do 
> however still get some of these:
> 
> (ksoftirqd/0/2): new 131 us maximum-latency critical section.
>   => started at: <netif_receive_skb+0x82/0x280>
>   => ended at:   <netif_receive_skb+0x1d7/0x280>

This is actually a good sign if this is the most common one you see. 
The netif_receive softirq is basically the longest code path that can't
easily be made preemptible; on my hardware about 150 usecs seems to be
the best we can do.  This is really good, I can't imagine an application
that you would use PC hardware for where 150 usecs is not enough, though
I am sure the hard realtime crowd has a few.

Even fixing this one would not help much because it seems there are many
other non-preemtible code paths that are only a little shorter than this
one.

Lee

