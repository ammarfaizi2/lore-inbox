Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVAXWYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVAXWYs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVAXWYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:24:37 -0500
Received: from hera.kernel.org ([209.128.68.125]:30379 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261679AbVAXWQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:16:54 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH 1/12] random pt4: Create new rol32/ror32 bitops
Date: Mon, 24 Jan 2005 22:16:35 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <ct3s43$ree$1@terminus.zytor.com>
References: <200501230247_MC3-1-93FA-7A4E@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1106604995 28111 127.0.0.1 (24 Jan 2005 22:16:35 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 24 Jan 2005 22:16:35 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200501230247_MC3-1-93FA-7A4E@compuserve.com>
By author:    Chuck Ebbert <76306.1226@compuserve.com>
In newsgroup: linux.dev.kernel
>
> On Sat, 22 Jan 2005 at 20:13:24 -0800 Matt Mackall wrote:
> 
> > So I think tweaks for x86 at least are unnecessary. 
> 
>  So the compiler looks for that specific sequence of instructions:
> 
>         (a << b) | (a >> (sizeof(a) * 8 - b)
> 
> and recognizes that it means rotation?  Wow.
> 

You know, there is a LOT of instructions like that.  x86 has a single
instruction to do:

	a = b + (c << 3) + 3600;

(Assuming a, b and c are in eax, ebx, and ecx, respecively, the
instruction is "leal 3600(%ebx,%ecx,3),%eax".)

The C compiler really needs to recognize these kinds of idioms, not
just in the source, but that occur natually as a result of code
generation and optimizations.  The compiler lingo for this is
"peephole optimization."

	-hpa
