Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUIETOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUIETOs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 15:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUIETOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 15:14:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57801 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266912AbUIETNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 15:13:15 -0400
Date: Sun, 5 Sep 2004 21:12:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
Message-ID: <20040905191227.GA29797@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu> <1094408203.4445.5.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094408203.4445.5.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Ok, first new one in a while.  This was with -R0, but I haven't seen
> anyone else report it.  Let me know if you need the complete trace.
> 
> preemption latency trace v1.0.2
> -------------------------------
>  latency: 511 us, entries: 951 (951)
>     -----------------
>     | task: dbench/4810, uid:1000 nice:0 policy:0 rt_prio:0
>     -----------------
>  => started at: kill_pg_info+0x10/0x50
>  => ended at:   kill_pg_info+0x2e/0x50
> =======>
> 00000001 0.000ms (+0.000ms): kill_pg_info (sys_kill)
> 00000001 0.000ms (+0.000ms): __kill_pg_info (kill_pg_info)
> 00000001 0.000ms (+0.000ms): find_pid (__kill_pg_info)

this is quite hard to fix - lots of processes were SIGKILL-ed (or
SIGTERM-ed) and the signal semantics require us to deliver signals
atomically. The only fix would be to turn the signal locks into
semaphores but that's quite hard. (it's also a bit problematic for
interrupt-delivered signals.)

	Ingo
