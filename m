Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272948AbUKAS7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272948AbUKAS7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274639AbUKASxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 13:53:37 -0500
Received: from mx1.elte.hu ([157.181.1.137]:62618 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S288038AbUKASmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 13:42:06 -0500
Date: Mon, 1 Nov 2004 19:43:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: tglx@linutronix.de, Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101184304.GA32009@elte.hu>
References: <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu> <20041101135358.GA19718@elte.hu> <20041101140630.GA20448@elte.hu> <1099324040.3337.32.camel@thomas> <1099331723.3647.32.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099331723.3647.32.camel@krustophenia.net>
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

> This was my conclusion as well.  I have a patch sitting around to add
> this to the emu10k1 ALSA driver, it's quite useful.  It would be nice
> if there were a facility in the kernel to easily identify missed
> interrupts like this or (even better) unbalanced irq disable/enable -
> AFAICT userspace alone cannot reliably distinguish lost interrupts
> from scheduling problems (though you can get a lot of hints).  Paul
> mentioned trying to debug the unbalanced irq disable in his talk at
> ZKM 2003, and said it's hard because the hardware will enable/disable
> interrupts on its own and he could not identify all those places. 
> Ingo, is there an easy way to trace this like we do for unbalanced
> preempt count?

i wrote a cli/sti latency tracer a couple of years ago so it's possible.
Note that an irqs-off condition is near impossible to 'leak' into
userspace code though, since the x86 iret path restores flags to the
previous value. Worst-case the irqs-off condition may leak into
kernelspace, and that can still cause bad effects. X startup/shutdown
can disable interrupts for a long time, was that excluded from your
testing?

	Ingo
