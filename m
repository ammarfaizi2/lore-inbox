Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268681AbUIXLF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268681AbUIXLF4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 07:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268682AbUIXLF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 07:05:56 -0400
Received: from relay.pair.com ([209.68.1.20]:65294 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S268681AbUIXLFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 07:05:54 -0400
X-pair-Authenticated: 66.188.111.210
Message-ID: <4153FF90.1010209@cybsft.com>
Date: Fri, 24 Sep 2004 06:05:52 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm3-S5
References: <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <415384E1.2080907@cybsft.com> <415394EE.50106@cybsft.com> <20040924074026.GB17368@elte.hu>
In-Reply-To: <20040924074026.GB17368@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>The following, on top of Ingo's patch above, fixes the problem with
>>dropping new connections and doesn't have any adverse affects that
>>I've seen:
>>
>>--- linux-2.6.9-rc2-pre-mm3/net/ipv4/tcp_output.c.orig  2004-09-23 
>>22:16:42.249435870 -0500
>>+++ linux-2.6.9-rc2-pre-mm3/net/ipv4/tcp_output.c       2004-09-23 
>>22:12:03.911811945 -0500
>>@@ -699,11 +699,6 @@
>>
>>                        tcp_minshall_update(tp, mss_now, skb);
>>                        sent_pkts = 1;
>>-                       /*
>>-                        * Break out early - we'll continue later:
>>-                        */
>>-                       if (softirq_need_resched())
>>-                               break;
> 
> 
> hm, ok, i'll revert this in my tree. I suspect we'll see some latencies
> resurfacing under high network load again, but correctness goes first
> obviously. If then we'll have to find some other method to break that
> critical path.
> 
> 	Ingo
> 
Ingo,

Maybe this wasn't the right way to fix the problem? I just looked at the 
S4 patch and it had the same change in it, but did not exhibit the same 
problem. Not knowing exactly what I was looking for, I just started 
looking for obvious changes that might affect dropping tcp connections 
and this one seemed reasonable. I made the change and the problem went 
away. Maybe this needs looking at a little closer.

kr
