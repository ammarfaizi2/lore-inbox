Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbUJ0QaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbUJ0QaA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbUJ0Q31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:29:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:15499 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262497AbUJ0Q2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:28:20 -0400
Date: Wed, 27 Oct 2004 09:28:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zachary Amsden <zach@vmware.com>
cc: linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: [PATCH] Remove some divide instructions
In-Reply-To: <417FC982.7070602@vmware.com>
Message-ID: <Pine.LNX.4.58.0410270926240.28839@ppc970.osdl.org>
References: <417FC982.7070602@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Oct 2004, Zachary Amsden wrote:
>
> I noticed several 64-bit divides for HZ/USER_HZ, and also the fact that 
> HZ == USER_HZ on many architectures (or if you play with scaling it ;).  
> Since do_div is macroized to optimized assembler on many platforms, we 
> emit long divides for divide by one.  This could be extended further to 
> recognize other power of two divides, but I don't think the complexity 
> of the macros would be justified.  I also didn't feel it was worthwhile 
> to optimize this for non-constant divides; if you feel otherwise, please 
> extend.

Can you test out the trivial extension, which is to allow any power-of-two
constant, and just leave it as a divide in those cases (and let the
compiler turn it into a 64-bit shift)?

It's very easy to test for powers of two: !((x) & ((x)-1)) does it for 
everything but zero, and zero in this case is an error anyway.

		Linus
