Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267626AbUGWLDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267626AbUGWLDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 07:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267627AbUGWLDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 07:03:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:53169 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267626AbUGWLDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 07:03:14 -0400
Date: Fri, 23 Jul 2004 13:04:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: linux-kernel@vger.kernel.org, Rudo Thomas <rudo@matfyz.cz>,
       Matt Heler <lkml@lpbproductions.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-I3
Message-ID: <20040723110430.GA3787@elte.hu>
References: <20040722100657.GA14909@elte.hu> <20040722160055.GA4837@ss1000.ms.mff.cuni.cz> <20040722161941.GA23972@elte.hu> <20040722172428.GA5632@ss1000.ms.mff.cuni.cz> <20040722175457.GA5855@ss1000.ms.mff.cuni.cz> <20040722180142.GC30059@elte.hu> <20040722180821.GA377@elte.hu> <20040722181426.GA892@elte.hu> <20040723104246.GA2752@elte.hu> <4d8e3fd30407230358141e0e58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e3fd30407230358141e0e58@mail.gmail.com>
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

> > i've uploaded the -I3 voluntary-preempt patch:
> > 
> >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-I3
> > 
> > it mainly fixes an ext3 livelock that could result in long delays during
> > heavy commit traffic.
> 
> Hello Ingo, do you have any measurement of the improvement available ?

it's a bug in the patch, not really a latency fix. When this (rare)
condition under heavy write traffic occurs then kjournald would loop for
many seconds (or tens of seconds) in __journal_clean_checkpoint_list(),
effectively hanging the system. The system is still preemptible but the
user cannot do much with it. Note that this condition is not present in
the vanilla kernel, it got introduced by earlier versions of
voluntary-preempt.

	Ingo
