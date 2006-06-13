Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932760AbWFMBzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbWFMBzR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 21:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbWFMBzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 21:55:17 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:7346 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932760AbWFMBzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 21:55:16 -0400
Date: Mon, 12 Jun 2006 21:50:17 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: use C code for current_thread_info()
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Emmanuel Fleury <emmanuel.fleury@labri.fr>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200606122152_MC3-1-C240-D8AE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060612184833.GA29177@rhlx01.fht-esslingen.de>

On Mon, 12 Jun 2006 20:48:33 +0200, Andreas Mohr wrote:

> > Kernel code starts out ~30K bytes smaller with gcc 4.1 and using C
> > for current_thread_info() helps even more than with 4.0.  Nice...
> 
> Especially since current_thread_info() often has an AGI stall (read:
> severe pipeline stall) since it often cannot properly intermingle
> with nearby opcodes due to lack of suitable ones, e.g. at a
> function prologue.
> mov    $0xffffe000,%eax
> and    %esp,%eax
> are fundamentally incompatible due to having to wait for the address
> generation before the "and" can be executed.
> This shows up during profiling quite noticeably (IIRC 8 hits vs. 1 to 2
> hits on other places), which really hurts since this function is used
> basically *everywhere*.

Hmmm.  The compiler does it this way:

  mov    %esp,%eax
  and    $0xffffe000,%eax

which could be faster because esp can be moved to eax while the mask
is being fetched.

-- 
Chuck

