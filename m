Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbUKDQ3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbUKDQ3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 11:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUKDQ3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 11:29:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:30608 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262283AbUKDQ3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 11:29:15 -0500
Date: Thu, 4 Nov 2004 17:30:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041104163012.GA3498@elte.hu>
References: <OF5DB3F102.6D3B4834-ON86256F42.00598BFD@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF5DB3F102.6D3B4834-ON86256F42.00598BFD@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> >what priority does events/0 and events/1 have? keventd handles part of
> >the mouse/keyboard workload.
> The default priorities and not RT.
> 
> ps -eo pid,pri,rtprio,cmd
> ...
>   6  34    -  [events/0]
>   7  34    -  [events/1]
> ...
> I can set those as well but then I'd probably have to follow with
> the X server and everything else in the chain. The starvation problem
> ripples across the system.

X should be scheduled on the other CPU just fine. Only per-CPU kernel
threads (which are affine to their particular CPU) are affected by this
problem - ordinary tasks not. I.e. the system threads that have /0 and
/1 in their name. In theory you should not even need to chrt the hardirq
threads, those should schedule fine too.

	Ingo
