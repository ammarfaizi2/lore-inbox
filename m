Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSGIBI7>; Mon, 8 Jul 2002 21:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSGIBI6>; Mon, 8 Jul 2002 21:08:58 -0400
Received: from jalon.able.es ([212.97.163.2]:44959 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316500AbSGIBI5>;
	Mon, 8 Jul 2002 21:08:57 -0400
Date: Tue, 9 Jul 2002 03:11:33 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: rwhron@earthlink.net
Cc: andrea@suse.de, jamagallon@able.es, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: pipe and af/unix latency differences between aa and jam on smp
Message-ID: <20020709011133.GA1835@werewolf.able.es>
References: <20020709005901.GA9616@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020709005901.GA9616@rushmore>; from rwhron@earthlink.net on Tue, Jul 09, 2002 at 02:59:01 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.09 rwhron@earthlink.net wrote:
>The -jam patchset is interesting because it starts out
>with the entire -aa patchset and adds a few things.
>
>Sometimes small differences in LMbench between -jam and -aa are 
>just CPU bounces on SMP.  The difference for pipe and af/unix latency
>only appears on SMP too, but it is very consistent.  (My k6/2
>has small differences between -aa and -jam for pipe and af/unix
>latency).
>
>You will know better what could make the difference:
>
>This is the averages:
>
>*Local* Communication latencies in microseconds - smaller is better
>-------------------------------------------------------------------
>kernel              Pipe    AF/Unix
>-----------------  -------  -------
>2.4.19-pre10-aa4    33.941   70.216
>2.4.19-pre10-jam2    7.877   16.699
>

Candidates in pre10-jam2 could be:

11-irqbalance-B1.bz2
12-smptimers-A0.bz2
13-irqrate-A1.bz2

excluding anything that has nothing to do with pipes or latency.

Could you try latest -rc1-aa2 ? It includes also irqbalance, so it could be
on varable less in the equation.
I dropped smptimers and irqrate because they did not mix very well  with
bproc and O1 scheduler, but I can try to add them again.

I have a rc1-jam2 ready, but the only important change wrt SMP could be the
mem-barrier specific implementation for P3/P4, and your box is an AMD.

??

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc1-jam2, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.7mdk)
