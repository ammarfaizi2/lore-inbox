Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUF3FxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUF3FxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 01:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUF3FxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 01:53:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:21932 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266208AbUF3FxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 01:53:01 -0400
Date: Wed, 30 Jun 2004 07:50:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: Do x86 NX and AMD prefetch check cause page fault infinite loop?
Message-ID: <20040630055041.GA16320@elte.hu>
References: <20040630013824.GA24665@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630013824.GA24665@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jamie Lokier <jamie@shareable.org> wrote:

> But... what if the page is not executable?  When NX is enabled on
> 32-bit x86, and all x86-64 kernels, or even the exec-shield patch's
> changes to the USER_CS limit (that limit isn't checked in
> __is_prefetch) - those conditions all allow __is_prefetch() to read a
> prefetch instruction, cause the fault handler to return, and repeat.
> 
> This can only happen when something branches to a page with PROT_EXEC
> _not_ set, on a kernel which honours that, and the target address is a
> prefetch instruction.
> 
> That can happen due to malicious code, a programming error, or
> corruption.
> 
> The behaviour in such cases _should_ be SIGSEGV due to lack of execute
> permission.  However, I think the behaviour will be an infinite loop.
> 
> I haven't tested this as I don't have the hardware for NX, and don't
> want to apply the non-NX exec-shield or PaX patches on a working
> Athlon box.
> 
> Can anyone confirm this is a real bug, or that it isn't and I missed
> the reason why not?

i understand what you mean, but for this to trigger one would have to
trigger the prefetch erratum _and_ then turn off executability in
parallel, right? So the question is, is there a reliable way to trigger
the pagefault situation, and if yes, how do you turn on NX - because
right before the fault the instruction had to be executable.

	Ingo
