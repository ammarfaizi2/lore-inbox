Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTEICLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 22:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbTEICLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 22:11:41 -0400
Received: from ns.suse.de ([213.95.15.193]:62221 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262273AbTEICLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 22:11:40 -0400
Date: Fri, 9 May 2003 04:24:17 +0200
From: Andi Kleen <ak@suse.de>
To: paubert <paubert@iram.es>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andi Kleen <ak@suse.de>, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] Mask mxcsr according to cpu features.
Message-ID: <20030509022417.GB15829@Wotan.suse.de>
References: <20030509004200.A22795@mrt-lx16.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509004200.A22795@mrt-lx16.iram.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 12:42:01AM +0000, paubert wrote:
> 
> [CC'ed to x86_64 and ia64 maintainers because they might have the 
> same issues. For existing x86_64 processors, s/0xffbf/0xffff/ in 
> arch/x86-64/ia32/{fpu32,ptrace32}.c might be sufficient]
> 
> With SSE2, mxcsr bit 6 is defined as controlling whether
> denormals should be treated as zeroes or not. Setting it
> no more causes an exception, but with the current code it 
> would be cleared at every signal return which is a bit harsh.
> 
> The following patch fixes this (2.5, but easily ported to 2.4).

x86-64 does it in a different way. It just handles the 
possible exception on FXRSTOR with an __ex_table handler.
With that all the mxcsr masking can be dropped.

It was already this way for 64bit programs, but the 32bit emulation
still masks. I'm not sure I can change that - in theory it could
break existing programs.

-Andi
