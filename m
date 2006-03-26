Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWCZMGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWCZMGR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWCZMGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:06:17 -0500
Received: from smtpout.mac.com ([17.250.248.46]:28873 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751292AbWCZMGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:06:16 -0500
Date: Sun, 26 Mar 2006 07:06:05 -0500
From: Kyle Moffett <mrmacman_g4@mac.com>
To: linux-kernel@vger.kernel.org
Cc: nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Message-Id: <20060326070605.130a5a53.mrmacman_g4@mac.com>
In-Reply-To: <20060326065205.d691539c.mrmacman_g4@mac.com>
References: <200603141619.36609.mmazur@kernel.pl>
	<200603231811.26546.mmazur@kernel.pl>
	<DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
	<200603241623.49861.rob@landley.net>
	<878xqzpl8g.fsf@hades.wkstn.nix>
	<D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
	<20060326065205.d691539c.mrmacman_g4@mac.com>
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.13; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2006 06:52:05 -0500 Kyle Moffett <mrmacman_g4@mac.com> wrote:
> 2)  Since most of the headers are currently quite broken with respect to
>     GLIBC and userspace, I won't spend much extra time preserving
>     compatibility with GLIBC, userspace, or non-GCC compilers.

That didn't come out right, but what I meant to say was this:  Since the 
headers in include/linux are quite broken with respect to GLIBC and 
userspace, I won't let so-called "compatibility" code like this get in 
the way:
  #ifndef __GNUC__
  #define DO_SOMETHING(foo) ICKY_MACRO
  #else
  static __inline__ void DO_SOMETHING(int foo)
  {
  	sensible_inline_function();
  }
  #endif

You can see where I take that approach in the patches I sent.

One other thing I would like to point out:  The fd_set code wants to use
__set_bit and __clear_bit from <linux/bitops.h>, but those really should
not be accessible to userspace directly.  I would like to propose moving
that functionality into <__klib/*.h> from which it would be accessible
to both <linux/*.h> and <kabi/*.h>.  I think this would also help with 
the UML header issues by providing those kernel-internal APIs to the 
kernel when run from userspace. (Please correct me if I'm wrong).

I appreciate your comments and corrections, thanks!

Cheers,
Kyle Moffett

