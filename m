Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbUC2Iro (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUC2Irn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:47:43 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44700 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262754AbUC2Irj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:47:39 -0500
To: Daniel Forrest <forrest@lmcg.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Somewhat OT: gcc, x86, -ffast-math, and Linux
References: <200403262054.i2QKsV223748@rda07.lmcg.wisc.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Mar 2004 01:47:19 -0700
In-Reply-To: <200403262054.i2QKsV223748@rda07.lmcg.wisc.edu>
Message-ID: <m1d66wghuw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Forrest <forrest@lmcg.wisc.edu> writes:

> I've tried Googling for an answer on this, but have come up empty and
> I think it likely that someone here probably knows the answer...
> 
> We are testing and breaking in 6 racks of compute nodes, each rack
> containing 30 1U boxes, each box containing 2 x 2.8GHz Xeon CPUs.
> Each rack contains identical hardware (single purchase) with the
> exception that one rack has double the memory per node.  The 6 racks
> are located in six different labs across our campus.  It is available
> to me only as a "black box" queueing system.

Testing and breaking in hardware with only black box remote access
sounds crippling.  Hopefully you can work with someone to fix problems
as they occur.
 
> I am running one of our applications that has been compiled using gcc
> with the -ffast-math option.  I am finding that the identical program
> using the same input data files is producing different results on
> different machines.  However, the differences are all less than the
> precision of a single-precision floating point number.  By this I mean
> that if the results (which are written to 15 digits of precision) are
> only compared to 7 digits then the results are the same.  Also, most
> of the time the 15 digit values are the same.

How errors propagate depend on the specifics of what computation
you are doing.
 
> My question is this: Why aren't the results always the same?  

Most likely memory errors.  Do the machines have ECC memory?  Is anything
reporting the ECC memory errors as the occur?

> What is the -ffast-math option doing?  How are the excess bits of precision
> dealt with during context switches?  Shouldn't the same binary with
> the same inputs produce the same output on identical hardware?

Yes.  Baring I/O related variables.

> I have run the same test with the program compiled without -ffast-math
> enabled and the results are always identical.

This may simply be a case where you are not hitting the hardware as
hard.  Or possibly compiler/optimizer bugs.

Or possibly you never ran your job on the faulty hardware?

> Any insight would be appreciated.

I don't have any except that universities are usually cheap and go
with the lowest bidder on hardware.

In general tracking this kind of problem comes down to applying
the scientific method.  And carefully looking at and controlling
the variables until a root cause is found.

Eric

