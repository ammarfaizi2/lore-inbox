Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263415AbUJ2QbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUJ2QbC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 12:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbUJ2Q3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 12:29:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55506 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263386AbUJ2QZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:25:15 -0400
Date: Fri, 29 Oct 2004 18:26:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5.2
Message-ID: <20041029162622.GA8016@elte.hu>
References: <OFDD5E88CA.56DEE781-ON86256F3C.0059C080-86256F3C.0059C0A2@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFDD5E88CA.56DEE781-ON86256F3C.0059C080-86256F3C.0059C0A2@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> The critical section nesting was "unique" and looks like
> 
> | preempt count: 00010005 ]
> | 5-level deep critical section nesting:
> ----------------------------------------
> .. [<c03257cf>] .... _spin_lock+0x1f/0x70
> .....[<c01e217a>] ..   ( <= __up_write+0x26a/0x2a0)
> .. [<c03257cf>] .... _spin_lock+0x1f/0x70
> .....[<c01e1f65>] ..   ( <= __up_write+0x55/0x2a0)
> .. [<c0325817>] .... _spin_lock+0x67/0x70
> .....[<c011b54d>] ..   ( <= task_rq_lock+0x3d/0x70)
> .. [<c03257cf>] .... _spin_lock+0x1f/0x70
> .....[<c0115f47>] ..   ( <= nmi_watchdog_tick+0x127/0x140)
> .. [<c013d5bd>] .... print_traces+0x1d/0x60
> .....[<c0105bec>] ..   ( <= show_regs+0x14c/0x174)

this might as well have been the NMI watchdog interacting. Could you
turn off the NMI watchdog to see whether that stabilizes things?

> The script then exits with preempt count of 3 and an atomic counter
> underflow BUG message. This is followed right after with
> 
> BUG: Unable to handle kernel NULL pointer dereference at virtual address
> 00000
> 020

these are then probably just followup-errors. Will take a look at the
logs.

	Ingo
