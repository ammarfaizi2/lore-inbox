Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270948AbTGQU4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271038AbTGQU4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:56:11 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:59572 "HELO
	develer.com") by vger.kernel.org with SMTP id S270948AbTGQU4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:56:07 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: george anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: do_div64 generic
Date: Thu, 17 Jul 2003 23:10:48 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, torvalds@osdl.org
References: <3F1360F4.2040602@mvista.com> <3F149747.3090107@mvista.com> <200307162033.34242.bernie@develer.com>
In-Reply-To: <200307162033.34242.bernie@develer.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307172310.48918.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 July 2003 20:33, Bernardo Innocenti wrote:

> > > Bernardo, can you do the patch please?
>
>  I would be glad to do it once the discussion has settled, whatever
> the final decision will be. Just don't make me do it twice, please ;-)

So far nobody have commented and the problem is still unaddressed.
What shall I do? As far as I can tell, our options are:

1) add surrogates of div_long_long_rem() in asm-generic/div64.h and in
   all other archs that have their own optimized versions of do_div().
   I already have a patch for this, but it has been tested only on i386
   and m68knommu.

2) replace all uses of div_long_long_rem() (I see onlt 4 of them in
   2.6.0-test1) with do_div(). This is slightly less efficient, but
   easier to maintain in the long term.

I shall note that I _hate_ fixing compiler problems in the kernel. The
real fix I'm dreaming involves adding specialized patterns in GCC to
generate an optimal instruction sequence for all these cases.

Of course we should realize that we need to support older versions of
GCC and, even if we didn't, we can't wait for the next GCC release :-)

So, if we're going to live with do_div(), I think we could as well
have a set of macros for the most frequent cases. I've just spotted
another candidate in kernel/posix-timers.c: mpy_l_X_l_ll().

This is not a third option for fixing our immediate problem: it's
just an idea for future improvement.

Andrew, George, please comment.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


