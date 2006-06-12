Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWFLRTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWFLRTo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWFLRTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:19:44 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:131 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751305AbWFLRTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:19:43 -0400
Date: Mon, 12 Jun 2006 13:14:34 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: use C code for current_thread_info()
To: Emmanuel Fleury <emmanuel.fleury@labri.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606121317_MC3-1-C23A-4F2D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <448C85B7.1010902@labri.fr>

On Sun, 11 Jun 2006 23:05:59 +0200, Emmanuel Fleury wrote:

> > Looking at the generated code, it seems the compiler just makes dumb
> > choices and tends to recompute current_thread_info() in unlikely code
> > paths even when there is no register pressure.  4.0.2 makes better
> > choices.
>
> What size with gcc 4.1.2 ? (just curiosity)

The 3.3 vs 4.0 comparisons were with two different configs, so only
relative gain/loss with asm vs. C could be compared.

I downloaded gcc 4.1.1 and compared to 4.0.2 with the exact same config,
since I was curious how much better it might be overall.

gcc 4.0.2:
   text	   data	    bss	    dec	    hex	filename
3645212	 555556	 312024	4512792	 44dc18	2.6.17-rc6-nb-C/vmlinux
3647276	 555556	 312024	4514856	 44e428	2.6.17-rc6-nb-asm/vmlinux
  -2064

gcc 4.1.1:
   text	   data	    bss	    dec	    hex	filename
3614686	 520416	 311672	4446774	 43da36	2.6.17-rc6-nb-C/vmlinux
3616942	 520416	 311672	4449030	 43e306	2.6.17-rc6-nb-asm/vmlinux
  -2256

Kernel code starts out ~30K bytes smaller with gcc 4.1 and using C
for current_thread_info() helps even more than with 4.0.  Nice...

Maybe a patch that enables C code for gcc 4.0+ would work, since
on 3.3 the asm code is better?

-- 
Chuck
