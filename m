Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269586AbUJLJwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269586AbUJLJwd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 05:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269590AbUJLJwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 05:52:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21378 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269586AbUJLJwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 05:52:31 -0400
Date: Tue, 12 Oct 2004 11:53:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Daniel Walker <dwalker@mvista.com>, "K.R. Foley" <kr@cybsft.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T6
Message-ID: <20041012095339.GA22249@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012094228.GA19751@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012094228.GA19751@elte.hu>
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

> one more warning wrt. PREEMPT_REALTIME: if this option is enabled then
> it is not safe to make interrupts non-threaded via
> /proc/irq/*/*/threaded. If you need to turn an interrupt into a
> high-prio event then its irq thread should be set to RT priority via
> 'chrt'. (-T7 will turn off /proc/irq/*/*/threaded altogether, to make
> sure it's not set accidentally.)

in fact i've re-uploaded a new version of the -T6 patch to disable
direct interrupts under PREEMPT_REALTIME kernels. The only exception is
IRQ1 on PCs (the keyboard irq), which can be useful for debugging
purposes (SysRq, etc.). I turned the keyboard related locks into raw
spinlocks to make this safe.

	Ingo
