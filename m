Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbUKRIvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbUKRIvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 03:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUKRIvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 03:51:22 -0500
Received: from mx2.elte.hu ([157.181.151.9]:46724 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262676AbUKRIvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 03:51:20 -0500
Date: Thu, 18 Nov 2004 10:52:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: cliff white <cliffw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5 - badness in enable_irg, BUG
Message-ID: <20041118095253.GA16054@elte.hu>
References: <20041115093759.721ac964.cliffw@osdl.org> <20041117210219.43a36302.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117210219.43a36302.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> > BUG: using smp_processor_id() in preemptible [00000001] code: mkdir/11768
> > caller is munmap_notify+0x7b/0x90 [oprofile]
> >  [<c020a465>] smp_processor_id+0xb5/0xc0
> >  [<f8912a4b>] munmap_notify+0x7b/0x90 [oprofile]
> >  [<f8912a4b>] munmap_notify+0x7b/0x90 [oprofile]
> >  [<c012b55d>] notifier_call_chain+0x2d/0x50
> >  [<c011dd93>] profile_munmap+0x33/0x50
> >  [<c01536f7>] sys_munmap+0x27/0x80
> >  [<c01046d3>] syscall_call+0x7/0xb
> 
> ho hum, I guess we should suppress these oprofile warnings somehow.
> 
> Ingo, is there an smp_processor_id() variant which bypasses the warning?

yeah, just use _smp_processor_id() for the checking-less variant.

> btw, this:

> is insane.   Any chance of simplifying it all?

since usually there are lots of arch-level false positives it didnt seem
prudent to enable the warning unconditionally for every arch. So an arch
can enable it right now by changing its smp_processor_id definition to
__smp_processor_id - and the #ifdefs will do their job to adapt. Once
most architectures have this enabled (right now only x86 and x64 have
it) we could simplify it down by making it unconditional but right now i
dont think it's a good idea.

	Ingo
