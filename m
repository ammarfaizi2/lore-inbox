Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbUKBPSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbUKBPSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUKBPOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 10:14:30 -0500
Received: from mx2.elte.hu ([157.181.151.9]:7656 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261250AbUKBPGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 10:06:44 -0500
Date: Tue, 2 Nov 2004 16:06:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Message-ID: <20041102150634.GA24871@elte.hu>
References: <1099227269.1459.45.camel@krustophenia.net> <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu> <20041101135358.GA19718@elte.hu> <20041101140630.GA20448@elte.hu> <1099324040.3337.32.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099324040.3337.32.camel@thomas>
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

> > Thomas, can you confirm that this kernel fixes the irqs-off latencies? 
> > (the priority loop indeed was done with irqs turned off.)
> 
> The latencies are still there. I have the feeling it's worse than 0.6.2.

update to others: Thomas debugged this problem today and found the place
that kept irqs disabled for a long time: it was update_process_times(). 
(which i recently touched to break latencies there - but forgot that the
lock is an irqs-off lock!)

i've uploaded a fixed kernel (-V0.6.8) to:

  http://redhat.com/~mingo/realtime-preempt/

(this kernel also has the module-put-unlock-kernel fix that should solve
the other warning reported by Thomas and Bill.)

	Ingo
