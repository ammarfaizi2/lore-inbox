Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266898AbUGVSPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266898AbUGVSPf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUGVSPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 14:15:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19422 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265203AbUGVSNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 14:13:11 -0400
Date: Thu, 22 Jul 2004 20:14:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Rudo Thomas <rudo@matfyz.cz>, Matt Heler <lkml@lpbproductions.com>
Subject: Re: voluntary-preempt I0: sluggish feel
Message-ID: <20040722181426.GA892@elte.hu>
References: <20040721210051.GA2744@yoda.timesys> <20040721211826.GB30871@elte.hu> <20040721223749.GA2863@yoda.timesys> <20040722100657.GA14909@elte.hu> <20040722160055.GA4837@ss1000.ms.mff.cuni.cz> <20040722161941.GA23972@elte.hu> <20040722172428.GA5632@ss1000.ms.mff.cuni.cz> <20040722175457.GA5855@ss1000.ms.mff.cuni.cz> <20040722180142.GC30059@elte.hu> <20040722180821.GA377@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722180821.GA377@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > > Oh, sorry for the noise. It was the NVIDIA driver. The open one works
> > > much better with the I0 patch.
> > 
> > i can reproduce this and i dont have the NVIDIA driver. When logging
> > in over the network then shell output is chunky with a setting of 2
> > (softirq redirection), shell output is smooth with a value of 1.
> 
> found the reason: ksoftirqd runs at priority 19 by default and this
> causes batching and some softirq starvation. Does the sluggishness go
> away if you do 'renice -10 2' [where '2' is the PID of ksoftirqd]?

i've uploaded -I1 which does this automatically:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-I1

	Ingo
