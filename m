Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267660AbUGWL6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267660AbUGWL6o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 07:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267661AbUGWL6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 07:58:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:20676 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267660AbUGWL6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 07:58:42 -0400
Date: Fri, 23 Jul 2004 14:00:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: linux-kernel@vger.kernel.org, Rudo Thomas <rudo@matfyz.cz>,
       Matt Heler <lkml@lpbproductions.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-I3
Message-ID: <20040723120014.GA5573@elte.hu>
References: <20040722161941.GA23972@elte.hu> <20040722172428.GA5632@ss1000.ms.mff.cuni.cz> <20040722175457.GA5855@ss1000.ms.mff.cuni.cz> <20040722180142.GC30059@elte.hu> <20040722180821.GA377@elte.hu> <20040722181426.GA892@elte.hu> <20040723104246.GA2752@elte.hu> <4d8e3fd30407230358141e0e58@mail.gmail.com> <20040723110430.GA3787@elte.hu> <4d8e3fd30407230442afe80c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e3fd30407230442afe80c1@mail.gmail.com>
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


* Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:

> Hi Ingo,
> thanks for the clarification.
> 
> What about performance of vanilla vs voluntary-preempt-2.6.8-rc2-I3 ?
> Do you have numbers available ? Can we, somehow, support you ?

All known performance problems have been fixed in -I4. The focus is
mainly on latency. You can best support this patch by trying it out and
doing measurements - both latency and throughput measurements are
welcome. Latency measurement can be done via the latencytest tool:

  http://www.alsa-project.org/~iwai/latencytest-0.5.4.tar.gz

If you enable both CONFIG_PREEMPT_VOLUNTARY and CONFIG_PREEMPT then you
can use the /proc/sys/kernel/voluntary_preemption|kernel_preemption
sysctl knobs to turn the preemption features on/off. The following flag
combinations can be used to do comparisons:

 vanilla:                                             vp:0 kp:0
 CONFIG_PREEMPT:                                      vp:0 kp:1
 voluntary-preempt:                                   vp:1 kp:0
 voluntary-preempt + CONFIG_PREEMPT:                  vp:1 kp:1
 voluntary-preempt + softirq defer:                   vp:2 kp:0 [default]
 voluntary-preempt + softirq defer + CONFIG_PREEMPT:  vp:2 kp:1

each of the above combinations should work and should pretty exactly
represent that particular kernel (i.e. you can get vanilla
non-preemptible 2.6.8-rc2 kernel behavior by switching both flags on) -
but i typically use the default one for testing. 

	Ingo
