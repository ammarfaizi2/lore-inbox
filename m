Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbUKCIiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbUKCIiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 03:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbUKCIiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 03:38:10 -0500
Received: from mx1.elte.hu ([157.181.1.137]:26345 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261480AbUKCIiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 03:38:03 -0500
Date: Wed, 3 Nov 2004 09:39:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Message-ID: <20041103083900.GA27211@elte.hu>
References: <OF9F489E60.B8B3EA93-ON86256F40.007C1401-86256F40.007C1430@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9F489E60.B8B3EA93-ON86256F40.007C1401-86256F40.007C1430@raytheon.com>
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

> The crash sequence was...
> 
>  - boot to single user (uneventful)
>  - telnet 5 (uneventful)
>  - X and top tests (uneventful)
>  - network test started (and did not finish)
>  - 2343 usec latency dumped
>  - 55962 usec latency dumped
>  - 74229 usec latency dumped
>  - 83374 usec latency dumped
>  - deadlock

yeah, this is yet another networking deadlock, nicely detected and
logged. Since the deadlock locks up ksoftirqd, timer handling (also
driven by ksoftirqd) wont work - i think this explains the followup
symptoms you got.

	Ingo
