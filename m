Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263395AbUJ2PnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbUJ2PnS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbUJ2Pih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:38:37 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:22183
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S263354AbUJ2PSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:18:00 -0400
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       javier@marcet.info, LKML <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, barry <barry@disus.com>
In-Reply-To: <20041028120650.GD5741@logos.cnet>
References: <Pine.LNX.4.44.0410251823230.21539-100000@chimarrao.boston.redhat.com>
	 <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com>
	 <20041028120650.GD5741@logos.cnet>
Content-Type: multipart/mixed; boundary="=-sc1X2s7ZcocesNCOISLC"
Organization: linutronix
Date: Fri, 29 Oct 2004 17:09:42 +0200
Message-Id: <1099062582.22115.54.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sc1X2s7ZcocesNCOISLC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Marcelo,

On Thu, 2004-10-28 at 10:06 -0200, Marcelo Tosatti wrote:
> Can you please test Rik's patch with your spurious OOM kill testcase?

I have similar problems with hackbench on a PIII/Celeron 300MHz, 128MB
RAM. 

Also Rik's patch does not help. I have the impression that it makes
almost no difference whether swap is on or not. With swap on, oom-killer
even kills rpc.mountd when it prints out that 56MB memory are available.

It happens on 2.6.8.1 too. On 2.6.7 I can run hackbench 40 without any
problem.

Full logs are attached.

tglx

Running hackbench 40, with swap on, I get 

oom-killer: gfp_mask=0xd0
Free pages:         356kB (0kB HighMem)
Out of Memory: Killed process 1030 (portmap).

oom-killer: gfp_mask=0xd0
Free pages:        6684kB (0kB HighMem)
Out of Memory: Killed process 1182 (atd).

oom-killer: gfp_mask=0xd0
Free pages:       17076kB (0kB HighMem)
Out of Memory: Killed process 1173 (sshd).

oom-killer: gfp_mask=0xd0
Free pages:       20160kB (0kB HighMem)
Out of Memory: Killed process 1191 (bash).
 - That's the shell on which hackbench was started

oom-killer: gfp_mask=0xd0
Free pages:       56544kB (0kB HighMem)
Out of Memory: Killed process 1149 (rpc.mountd).


Switching swap off, I get 

oom-killer: gfp_mask=0xd0
Free pages:         404kB (0kB HighMem)
Out of Memory: Killed process 1031 (portmap).

oom-killer: gfp_mask=0xd0
Free pages:         356kB (0kB HighMem)
Out of Memory: Killed process 1169 (atd).

oom-killer: gfp_mask=0xd0
Free pages:         792kB (0kB HighMem)
Out of Memory: Killed process 1160 (sshd).

oom-killer: gfp_mask=0xd0
Free pages:        2340kB (0kB HighMem)
Out of Memory: Killed process 1178 (bash).
- That's the shell on which hackbench was started


--=-sc1X2s7ZcocesNCOISLC
Content-Disposition: attachment; filename=hb-swapon.log
Content-Type: text/x-log; name=hb-swapon.log; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 12, high 36, batch 6
cpu 0 cold: low 0, high 12, batch 6
HighMem per-cpu: empty

Free pages:         356kB (0kB HighMem)
Active:0 inactive:0 dirty:0 writeback:2 unstable:0 free:89 slab:14778 mapped:9244 pagetables:6472
DMA free:44kB min:44kB low:88kB high:132kB active:0kB inactive:0kB present:16384kB
protections[]: 0 0 0
Normal free:312kB min:312kB low:624kB high:936kB active:0kB inactive:0kB present:114676kB
protections[]: 0 0 0
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 44kB
Normal: 0*4kB 1*8kB 1*16kB 1*32kB 0*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 312kB
HighMem: empty
Swap cache: add 992, delete 727, find 10/11, race 0+0
Out of Memory: Killed process 1030 (portmap).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 12, high 36, batch 6
cpu 0 cold: low 0, high 12, batch 6
HighMem per-cpu: empty

Free pages:        6684kB (0kB HighMem)
Active:7 inactive:15 dirty:0 writeback:0 unstable:0 free:1671 slab:14067 mapped:8332 pagetables:6448
DMA free:2292kB min:44kB low:88kB high:132kB active:0kB inactive:24kB present:16384kB
protections[]: 0 0 0
Normal free:4392kB min:312kB low:624kB high:936kB active:28kB inactive:36kB present:114676kB
protections[]: 0 0 0
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
DMA: 277*4kB 80*8kB 30*16kB 2*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2292kB
Normal: 666*4kB 120*8kB 30*16kB 1*32kB 0*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4392kB
HighMem: empty
Swap cache: add 1871, delete 1435, find 33/44, race 0+0
Out of Memory: Killed process 1182 (atd).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 12, high 36, batch 6
cpu 0 cold: low 0, high 12, batch 6
HighMem per-cpu: empty

Free pages:       17076kB (0kB HighMem)
Active:0 inactive:6 dirty:0 writeback:1 unstable:0 free:4269 slab:12021 mapped:7389 pagetables:6316
DMA free:4332kB min:44kB low:88kB high:132kB active:0kB inactive:24kB present:16384kB
protections[]: 0 0 0
Normal free:12744kB min:312kB low:624kB high:936kB active:0kB inactive:0kB present:114676kB
protections[]: 0 0 0
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
DMA: 481*4kB 199*8kB 47*16kB 2*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4332kB
Normal: 1646*4kB 482*8kB 114*16kB 7*32kB 0*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 12744kB
HighMem: empty
Swap cache: add 2737, delete 1849, find 95/118, race 0+0
Out of Memory: Killed process 1173 (sshd).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 12, high 36, batch 6
cpu 0 cold: low 0, high 12, batch 6
HighMem per-cpu: empty

Free pages:       20160kB (0kB HighMem)
Active:0 inactive:7 dirty:0 writeback:2 unstable:0 free:5040 slab:11694 mapped:6115 pagetables:6252
DMA free:4704kB min:44kB low:88kB high:132kB active:0kB inactive:24kB present:16384kB
protections[]: 0 0 0
Normal free:15456kB min:312kB low:624kB high:936kB active:0kB inactive:4kB present:114676kB
protections[]: 0 0 0
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
DMA: 474*4kB 217*8kB 61*16kB 3*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4704kB
Normal: 1576*4kB 674*8kB 187*16kB 16*32kB 0*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 15456kB
HighMem: empty
Swap cache: add 4460, delete 2529, find 279/365, race 0+0
Out of Memory: Killed process 1191 (bash).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 12, high 36, batch 6
cpu 0 cold: low 0, high 12, batch 6
HighMem per-cpu: empty

Free pages:       56544kB (0kB HighMem)
Active:6 inactive:11 dirty:0 writeback:219 unstable:0 free:14136 slab:10701 mapped:1064 pagetables:2804
DMA free:4752kB min:44kB low:88kB high:132kB active:0kB inactive:24kB present:16384kB
protections[]: 0 0 0
Normal free:51792kB min:312kB low:624kB high:936kB active:24kB inactive:20kB present:114676kB
protections[]: 0 0 0
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
DMA: 474*4kB 219*8kB 63*16kB 3*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4752kB
Normal: 2542*4kB 2035*8kB 1038*16kB 263*32kB 1*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 51792kB
HighMem: empty
Swap cache: add 7575, delete 6377, find 368/540, race 0+0
Out of Memory: Killed process 1149 (rpc.mountd).

--=-sc1X2s7ZcocesNCOISLC
Content-Disposition: attachment; filename=hb-swoff.log
Content-Type: text/x-log; name=hb-swoff.log; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 12, high 36, batch 6
cpu 0 cold: low 0, high 12, batch 6
HighMem per-cpu: empty

Free pages:         404kB (0kB HighMem)
Active:6603 inactive:9 dirty:0 writeback:0 unstable:0 free:101 slab:13757 mapped:10233 pagetables:6472
DMA free:44kB min:44kB low:88kB high:132kB active:1560kB inactive:0kB present:16384kB
protections[]: 0 0 0
Normal free:360kB min:312kB low:624kB high:936kB active:24852kB inactive:36kB present:114676kB
protections[]: 0 0 0
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 44kB
Normal: 18*4kB 0*8kB 0*16kB 1*32kB 0*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 360kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Out of Memory: Killed process 1031 (portmap).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 12, high 36, batch 6
cpu 0 cold: low 0, high 12, batch 6
HighMem per-cpu: empty

Free pages:         356kB (0kB HighMem)
Active:5728 inactive:0 dirty:0 writeback:0 unstable:0 free:89 slab:14301 mapped:10171 pagetables:6472
DMA free:44kB min:44kB low:88kB high:132kB active:792kB inactive:0kB present:16384kB
protections[]: 0 0 0
Normal free:312kB min:312kB low:624kB high:936kB active:22120kB inactive:0kB present:114676kB
protections[]: 0 0 0
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 44kB
Normal: 0*4kB 1*8kB 1*16kB 1*32kB 0*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 312kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Out of Memory: Killed process 1169 (atd).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 12, high 36, batch 6
cpu 0 cold: low 0, high 12, batch 6
HighMem per-cpu: empty

Free pages:         792kB (0kB HighMem)
Active:6588 inactive:1 dirty:0 writeback:0 unstable:0 free:198 slab:14647 mapped:9883 pagetables:6304
DMA free:48kB min:44kB low:88kB high:132kB active:1700kB inactive:4kB present:16384kB
protections[]: 0 0 0
Normal free:744kB min:312kB low:624kB high:936kB active:24652kB inactive:0kB present:114676kB
protections[]: 0 0 0
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
DMA: 2*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 48kB
Normal: 88*4kB 3*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 744kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Out of Memory: Killed process 1160 (sshd).
oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 12, high 36, batch 6
cpu 0 cold: low 0, high 12, batch 6
HighMem per-cpu: empty

Free pages:        2340kB (0kB HighMem)
Active:7217 inactive:7 dirty:0 writeback:0 unstable:0 free:585 slab:15072 mapped:9371 pagetables:5968
DMA free:1436kB min:44kB low:88kB high:132kB active:1832kB inactive:4kB present:16384kB
protections[]: 0 0 0
Normal free:904kB min:312kB low:624kB high:936kB active:27036kB inactive:24kB present:114676kB
protections[]: 0 0 0
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
DMA: 205*4kB 65*8kB 4*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1436kB
Normal: 52*4kB 9*8kB 5*16kB 7*32kB 1*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 904kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Out of Memory: Killed process 1178 (bash).

--=-sc1X2s7ZcocesNCOISLC--

