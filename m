Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316567AbSGIBXA>; Mon, 8 Jul 2002 21:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSGIBW7>; Mon, 8 Jul 2002 21:22:59 -0400
Received: from jalon.able.es ([212.97.163.2]:60319 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316567AbSGIBW6>;
	Mon, 8 Jul 2002 21:22:58 -0400
Date: Tue, 9 Jul 2002 03:25:34 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: rwhron@earthlink.net
Cc: andrea@suse.de, jamagallon@able.es, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: pipe and af/unix latency differences between aa and jam on smp
Message-ID: <20020709012534.GE1835@werewolf.able.es>
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

I took a look at your numbers:

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
kernel                          Pipe    AF/Unix    UDP    RPC/UDP    TCP    RPC/TCP  TCPconn
-----------------------------  -------  -------  -------  -------  -------  -------  -------
2.4.19-pre7-jam6                29.513   42.369  58.6165  60.7792  50.2572  82.4976   87.321
2.4.19-pre8-jam2                 7.697   15.274  59.6730  60.8190   55.276  82.1297   89.416
2.4.19-pre8-jam2-nowuos          7.739   14.929  57.9326  60.5497  55.9745  81.8908   90.370

(last line says that wake-up-sync is not responsible...)

Main changes between first two were irqbalance and ide6->ide10.


-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc1-jam2, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.7mdk)
