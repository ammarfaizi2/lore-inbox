Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266049AbUHASHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbUHASHw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 14:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266081AbUHASHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 14:07:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:22409 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266049AbUHASHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 14:07:48 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Scott Wood <scott@timesys.com>
In-Reply-To: <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com>
References: <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <1091141622.30033.3.camel@mindpipe>  <20040730064431.GA17777@elte.hu>
	 <1091228074.805.6.camel@mindpipe> <1091234100.1677.41.camel@mindpipe>
	 <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1091383695.17634.228.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 01 Aug 2004 14:08:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-01 at 07:28, Ingo Molnar wrote:
> On Fri, 30 Jul 2004, Lee Revell wrote:
> 
> > Results with 2.6.8-rc2-M5:
> > 
> > Configuration						max usecs
> > -----------------------------------------------------------------
> > All IRQs threaded					370 
> > Soundcard IRQ not threaded				335
> > Soundcard IRQ not threaded + max_sectors_kb -> 64	161
> > 
> > So, it looks like the added configurability does add some overhead - 161
> > usecs vs. 50. [...]
> 
> +110 usecs is too much to be explained by redirection and configurability
> overhead. The configurability overhead is near zero.
> 
> could you try to repeat the '50 usecs' test with -L2 [that was the one you
> used?] to make sure it's repeatable? The latencies of -L2 and -M5 should
> be near identical. The configurability should at most cause a 1-2 usecs
> overhead - definitely not two orders of magnitude higher. So if there's a
> difference then i must have degraded one of the latency reduction changes
> between L2 and M5.

The above numbers really do not tell you much, I have some better ones. 
Here is the histogram for a 5,000,000 sample run with M5:

 Delay   Count
-----   -----
6       98189
7       2013275
8       51025
9       120465
10      93339
11      72087
12      116165
13      106433
14      85930
15      57178
16      59835
17      51096
18      71671
19      106738
20      109491
21      84906
22      2215
23      946
24      1755
25      1977
26      1589
27      1117
28      1889
29      1616
30      1858
31      2926
32      3111
33      2558
34      400
35      1366
36      2172
37      2840
38      1088
39      1042
40      172
41      26
42      32
43      43
44      41
45      10
46      8
47      36
48      109
49      125
50      83
51      45
52      36
53      7
55      1
56      1
58      1
61      1
62      1
68      1
75      1
77      1
79      1
89      1
97      1

So if you discard the highest ~10 of 5,000,000, it's the same as L2.  Maybe a 
corner case, or a new race condition?  I will run the above test with L2.

I wonder if the multiple spikes represent different code paths, or the same 
but with a hot/warm/cold cache?

Lee



