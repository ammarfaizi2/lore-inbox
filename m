Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266210AbUGTUAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266210AbUGTUAA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 16:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUGTT6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:58:47 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2796 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266210AbUGTT4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:56:30 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200407202011.20558.musical_snake@gmx.de>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1090306769.22521.32.camel@mindpipe> <20040720071136.GA28696@elte.hu>
	 <200407202011.20558.musical_snake@gmx.de>
Content-Type: text/plain
Message-Id: <1090353405.28175.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Jul 2004 15:56:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-20 at 14:11, Ralf Beck wrote:
> > it's an issue for all block IO drivers that do IO completions from IRQ
> > context and that can do DMA - i.e. every block IO hardware that uses
> > interrupts. This includes SCSI too. In fact for SCSI it's a norm to have
> 
> I renew a question i asked earlier.
> 
> To my understanding, on a SMP or hyperthreading system, disabling of
> IRQs is always local to one (virtual on HT) cpu.
> 
> So would it be possible to get ultralow latency by simply hardlock all irqs 
> and processes to cpu1 and the irq triggering the audiothread (together with 
> the audiothread) to cpu 2 using the sched_affinity and irq-affinity 
> capabilites of the kernel?
> 
> This would be an easy to use lowlatency hardware patch for  linux audio users
> with SMP/HT systems. Anybody knows?
> 
> I'm currently thinking about getting a new system and consider a dualsystem if 
> this worked.

Should work.  For example, the RTLinux people report excellent results
on SMP systems by binding all RT threads to one CPU and having the Linux
part of the system run on the other.  This is just a "softer" version of
that setup.  Even if there are cases where IRQs are disabled globally,
it would be an improvement.  I suspect you are not getting much of a
response because no one has actually tested it with an audio system.

Lee

