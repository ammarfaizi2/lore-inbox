Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUJCGux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUJCGux (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 02:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUJCGux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 02:50:53 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59592 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266308AbUJCGuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 02:50:50 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <1096785457.1837.0.camel@krustophenia.net>
References: <1094683020.1362.219.camel@krustophenia.net>
	 <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
	 <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>
	 <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
	 <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
	 <20040924074416.GA17924@elte.hu>  <20040928000516.GA3096@elte.hu>
	 <1096785457.1837.0.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1096786248.1837.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 03 Oct 2004 02:50:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-03 at 02:37, Lee Revell wrote:
> On Mon, 2004-09-27 at 20:05, Ingo Molnar wrote:
> > i've released the -S7 VP patch:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm4-S7
> > 
> 
> This one was caused by amlat:

And here's another produced by "lsof /foo":

preemption latency trace v1.0.7 on 2.6.9-rc2-mm4-VP-S7
-------------------------------------------------------
 latency: 399 us, entries: 608 (608)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: lsof/4347, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: unix_seq_start+0x10/0x50
 => ended at:   rtc_interrupt+0x294/0x450
=======>
00000001 0.000ms (+0.000ms): unix_seq_start (seq_read)
00000001 0.000ms (+0.039ms): unix_seq_idx (unix_seq_start)
00000001 0.040ms (+0.000ms): unix_seq_show (seq_read)
00000002 0.040ms (+0.001ms): sock_i_ino (unix_seq_show)
00000002 0.041ms (+0.000ms): seq_printf (unix_seq_show)
00000002 0.042ms (+0.002ms): vsnprintf (seq_printf)
00000002 0.045ms (+0.003ms): number (vsnprintf)
00000002 0.048ms (+0.000ms): skip_atoi (vsnprintf)
00000002 0.049ms (+0.001ms): number (vsnprintf)
00000002 0.050ms (+0.000ms): skip_atoi (vsnprintf)
00000002 0.051ms (+0.000ms): number (vsnprintf)
00000002 0.052ms (+0.000ms): skip_atoi (vsnprintf)
00000002 0.052ms (+0.000ms): number (vsnprintf)
00000002 0.053ms (+0.000ms): skip_atoi (vsnprintf)
00000002 0.053ms (+0.000ms): number (vsnprintf)
00000002 0.054ms (+0.000ms): skip_atoi (vsnprintf)
00000002 0.055ms (+0.000ms): number (vsnprintf)
00000002 0.056ms (+0.000ms): skip_atoi (vsnprintf)
00000002 0.056ms (+0.001ms): number (vsnprintf)
00000002 0.058ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.059ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.059ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.059ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.060ms (+0.000ms): seq_putc (unix_seq_show)
00000002 0.060ms (+0.000ms): seq_putc (unix_seq_show)

...

Full trace:

http://krustophenia.net/testresults.php?dataset=2.6.9-rc2-mm4-S7#/var/www/2.6.9-rc2-mm4-S7/lsof-latency-trace.txt

Lee



