Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266318AbUFPVk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266318AbUFPVk0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUFPVk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:40:26 -0400
Received: from zero.aec.at ([193.170.194.10]:52741 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266318AbUFPVkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:40:23 -0400
To: eliot@cincom.com
cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: PROBLEM: 2.6 kernels on x86 do not preserve FPU flags across
 context switches
References: <27Pmy-sO-25@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 16 Jun 2004 23:40:18 +0200
In-Reply-To: <27Pmy-sO-25@gated-at.bofh.it> (eliot@cincom.com's message of
 "Wed, 16 Jun 2004 22:40:10 +0200")
Message-ID: <m3hdtbyyf1.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


eliot@cincom.com writes:

> 	I am the team lead and chief VM developer for a Smaltalk
> 	implementation based on a JIT execution engine.  Our customers
> 	have been seeing rare incorrect floating-point results in
> 	intensive fp applications on 2.6 kernels using various x86
> 	compatible processors.  These problems do not occur on
> 	previous kernel versons.  We recently had occasion to
> 	reimplement our fp primitives to avoid severe performance
> 	problems on Xeon processors that were traced to Xeon's
> 	relatively slow implementation of fnclex and fstsw.  The older

Funny, Linux just added fnclex to a critical path on popular request.
But I guess it will need to be removed again, we already discussed
that. 


> I don't know whether any action on your part is appropriate.  The
> use of the FPU status flags is presumably rare on linux (I believe
> that neither gcc nor glibc make use of them).  But "exotic"
> execution machinery such as runtimes for dynamic or functional
> languages (language implementations that may not use IEEE arithmetic
> and instead flag Infs and NaNs as an error) may fall foul of this
> issue.  Since previous versions of the kernel on x86 apparently do
> preserve the FPU status flags perhaps its simple to preserve the old
> behaviour.  At the very least let me suggest you document the
> limitation.

This sounds like a serious kernel bug that should be fixed if
true. Can you perhaps create a simple demo program that shows the
problem and post it?

On what CPUs does the failure occur? Linux uses different paths
depending on if the CPU supports SSE or not.

Does your program receive signals? Could it be related to them?

-Andi

