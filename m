Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263494AbREYCwA>; Thu, 24 May 2001 22:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263500AbREYCvu>; Thu, 24 May 2001 22:51:50 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:734 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S263494AbREYCvl>;
	Thu, 24 May 2001 22:51:41 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105250248.TAA00836@csl.Stanford.EDU>
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
To: mikpe@csd.uu.se (Mikael Pettersson)
Date: Thu, 24 May 2001 19:48:19 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200105242301.BAA05771@harpo.it.uu.se> from "Mikael Pettersson" at May 25, 2001 01:01:48 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> check_nmi_watchdog() is __init and we know exactly when it's called.
> The interesting cases (SMP kernel, since for UP NR_CPUS==1) are:

Ah, nice --- I keep meaning to tell the checker to demote its warning
about NULL bugs or large stack vars in __init routines and/or routines
that have the substring "init" in them ;-)


> IMHO the checker tool should take call paths into consideration
> when trying to detect stack overflow problems. Does it do that?
> (I.e. is it polyvariant or monovariant?)

The var checker is more "really stupid".  It just does a flow
insensitive pass looking for big variables.  I could make it follow
call chains without too much work (other checkers do do this.)

> I could write a patch to make 'tmp' __initdata instead, which would
> silence the checker tool, but I don't really want to do that unless
> someone can convince me that there is a real problem here.

No need.  Once it's marked as an FP the checker won't warn about it
anymore.

Thanks for post-mortem.

