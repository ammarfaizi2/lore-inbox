Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270105AbUJTM7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270105AbUJTM7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270045AbUJTM63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:58:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59543 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270082AbUJTK01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:26:27 -0400
Date: Wed, 20 Oct 2004 12:27:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
Message-ID: <20041020102722.GA964@elte.hu>
References: <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <1098229098.26927.40.camel@cmn37.stanford.edu> <1098229166.12223.1153.camel@thomas> <1098248541.12223.1450.camel@thomas> <20041020074049.GA20963@elte.hu> <1098266273.12223.1511.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098266273.12223.1511.camel@thomas>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Yep, it's all the same scheme. Most of the offending code uses
> MUTEX_LOCKED in an init function and plays the down, and up from a
> different context game, which triggers the deadlock/owner verify. Not
> hard to fix, but at some places it takes a bit, until you see the
> intention of the driver hacker. 

the NFS ones seemed to be the least clear ones. I'm glad you converted
those already :-)

> The most surprising one was in driver/base. I did not expect that new
> 2.5/6 code uses those tricks too.

it is not strictly a bug, but that technique was discouraged for years -
completions are cleaner and faster for that purpose anyway. (they were
designed for what in the semaphore case is the slowpath.)

> Fixes for aic7xxx and sym53c8xx_2 attached.

Applied. The sym53c8xx_2 looks good. aic7xxx is good too except for a
minor cleanup issue: i've changed all _sem symbols to be _done symbols.
It's not a semaphore anymore, lets avoid the namespace-rotting effect. 
I've put these into -U8 so anyone hitting aic7xxx or sym53c8xx_2 should
re-download the -U8 patch. (others who have already downloaded it should
not bother.)

	Ingo
