Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbULIJGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbULIJGy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 04:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbULIJGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 04:06:53 -0500
Received: from mx1.elte.hu ([157.181.1.137]:41166 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261495AbULIJGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 04:06:43 -0500
Date: Thu, 9 Dec 2004 10:06:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041209090616.GB14516@elte.hu>
References: <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <1102526018.25841.308.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102526018.25841.308.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Ingo,
> 
> I found a race condition in slab.c, but I'm still trying to figure out
> exactly how it's playing out.  This has to do with dynamic loading and
> unloading of caches. I have a small test case that simulates the
> problem at http://home.stny.rr.com/rostedt/tests/sillycaches.tgz

good catch! When i converted slab.c to RT i mistakenly thought that SLAB
flushing (draining) is only an SMP optimization (which i thus generously
disabled), but i forgot about module unloading. This could indeed
explain some of the unresolved bugs in the -RT patchset.

	Ingo
