Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVDFG1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVDFG1c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 02:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVDFG1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 02:27:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48044 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262119AbVDFG1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 02:27:30 -0400
Date: Wed, 6 Apr 2005 08:27:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 5/5] sched: consolidate sbe sbf
Message-ID: <20050406062723.GC5973@elte.hu>
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au> <425323A1.5030603@yahoo.com.au> <42532427.3030100@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42532427.3030100@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> 5/5
> 
> Any ideas about what to do with schedstats?
> Do we really need balance on exec and fork as seperate
> statistics?

> Consolidate balance-on-exec with balance-on-fork. This is made easy
> by the sched-domains RCU patches.
> 
> As well as the general goodness of code reduction, this allows
> the runqueues to be unlocked during balance-on-fork.
> 
> schedstats is a problem. Maybe just have balance-on-event instead
> of distinguishing fork and exec?
> 
> Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

looks good.

 Acked-by: Ingo Molnar <mingo@elte.hu>

while the code is now consolidated, i think we still need the separate 
fork/exec stats for schedstat. We have 3 conceptual ways to start off a 
new context: fork(), pthread_create() and execve(), and applications use 
them in different patterns. We have different flags and tuning 
parameters for two of them (which might have to become 3, i'm not 
entirely convinced we'll be able to ignore the 'process vs. thread' 
condition in wake_up_new_task(), STREAM is a really bad example in that 
sense), so we need 2 (or 3) separate stats.

	Ingo
