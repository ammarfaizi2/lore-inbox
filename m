Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUC0OZH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 09:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUC0OZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 09:25:07 -0500
Received: from mail.shareable.org ([81.29.64.88]:22162 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261752AbUC0OZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 09:25:02 -0500
Date: Sat, 27 Mar 2004 14:24:59 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Daniel Forrest <forrest@lmcg.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Somewhat OT: gcc, x86, -ffast-math, and Linux
Message-ID: <20040327142459.GF21884@mail.shareable.org>
References: <200403262054.i2QKsV223748@rda07.lmcg.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403262054.i2QKsV223748@rda07.lmcg.wisc.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Forrest wrote:
> What is the -ffast-math option doing?

It enables some optimisations and mathematical transformations which
do not satisfy the properties of IEEE floating point arithmetic.

(Not that GCC's output satisfies those properties without -ffast-math
on x86, but this flag enables much looser semantics).

> How are the excess bits of precision dealt with during context
> switches?

They are preserved - they are part of the floating point context.
If there is any failure to preserve all of that context, it's a kernel bug.

> Shouldn't the same binary with the same inputs produce the same
> output on identical hardware?

Is the hardware *identical*, or are they different x86 CPUs?

Different CPUs give different results for the trigonometric functions.
GCC's manual claims that fsin, fcos and fsqrt instructions are only
used if the -funsafe-math-optimizations flag is also used, if the GCC
version is >= 2.6.1.  However you may find that Glibc's <math.h> ends
up using those instructions when -ffast-math is used alone.

-- Jamie
