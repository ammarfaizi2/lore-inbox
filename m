Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbULCBnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbULCBnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 20:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbULCBnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 20:43:20 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:56199 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S261836AbULCBnP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 20:43:15 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041201162034.GA8098@elte.hu>
References: <41358.195.245.190.93.1101734020.squirrel@195.245.190.93>
	 <20041129143316.GA3746@elte.hu> <20041129152344.GA9938@elte.hu>
	 <48590.195.245.190.94.1101810584.squirrel@195.245.190.94>
	 <20041130131956.GA23451@elte.hu>
	 <17532.195.245.190.94.1101829198.squirrel@195.245.190.94>
	 <20041201103251.GA18838@elte.hu>
	 <32831.192.168.1.5.1101905229.squirrel@192.168.1.5>
	 <20041201154046.GA15244@elte.hu> <20041201160632.GA3018@elte.hu>
	 <20041201162034.GA8098@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1102038118.7234.1544.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Dec 2004 17:41:58 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-01 at 08:20, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > ok, this could be ACPI CPU-sleep related. Could you disable all ACPI
> > options in your .config (as a workaround), and re-check whether the
> > xruns still occur?
> 
> i think i found the bug - it's an upstream ACPI bug. Does the patch
> below (or the -31-19 kernel, which i've just uploaded) fix the xruns?

I'm trying unsuccessfully to boot my dual processor athlon into an smp
V0.7.31-20 patched kernel, with PREEMPT_DESKTOP (has not booted
correctly with realtime preemption compiled in for a long time):

(copied from the screen)

BUG: scheduling while atomic: swapper/0x10000000/1
caller is preempt_schedule_irq+0x34/0x50
[<c0105303>] dump_stack+-x23/0x30 (20)
[<c03726dc>] __schedule+0xd5c/0xdb0 (124)
[<c0372904>] preempt_schedule_irq+0x34/0x50 (12)
[<c010429b>] need_resched+0x20/0x29 (-7256)
-------
|preempt_count: 10000001
1-level deep critical section nesting
.. [<c014610d>] .... preint_tracs+0x1d/0x60
.....[<c0105303>] .. ( <= dump_stack+0x23/0x30)
BUG at kernel/latency.c: 918!
--------
invalid operand: 0000 [#1]
PREEMPT SMP

Tried booting with softirq-preempt=1 hardirq-preempt=0 with no change. 

The matching uniprocessor kernel boots fine.
-- Fernando


