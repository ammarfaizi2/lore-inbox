Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbTEAJHj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 05:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbTEAJHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 05:07:39 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:10512 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261181AbTEAJHi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 05:07:38 -0400
Date: Thu, 1 May 2003 11:19:44 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Daniel Phillips <dphillips@sistina.com>
Cc: Willy Tarreau <willy@w.ods.org>, Linus Torvalds <torvalds@transmeta.com>,
       Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-ID: <20030501091944.GA15827@alpha.home.local>
References: <Pine.LNX.4.44.0304300709300.7157-100000@home.transmeta.com> <200304302115.33424.dphillips@sistina.com> <20030430205921.GB7356@alpha.home.local> <200305010302.14927.dphillips@sistina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305010302.14927.dphillips@sistina.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 03:02:14AM +0200, Daniel Phillips wrote:
> On Wednesday 30 April 2003 22:59, Willy Tarreau wrote:
> > I must acknowledge that your simple code was not easy to beat ! You can try
> > this one on your PIII, I could only test it on an athlon mobile and a P4.
> > With gcc 2.95.3, it gives me a boost of about 25%, because it seems as gcc
> > cannot optimize shifts efficiently. On 3.2.3, however, it's between 0 and
> > 5% depending on optimization/CPU.
> 
> Was something ifdef'd incorrectly?  Otherwise, there is something the PIII 
> hates about that code.  I got 107 seconds on the PIII, vs 53 seconds for my 
> posted code at O3, and virtually no difference at O2.  (gcc 3.2.3)

No, it was correct. It simply means that some CPUs prefer bit shifting while
others prefer comparisons and sometimes jumps, that mostly depends on the
ALU and the branch prediction unit, it seems. That shows us that if we include
such code in the kernel, it has to be arch-specific, so we may end up coding
it in assembler, keeping your code as the default one when no asm has been coded
for a given arch. BTW, has someone benchmarked BSF/BSR on x86 ? It should be
faster, it it's also possible that a poor microcode implements it with a one
bit/cycle algo, which will result in one instruction not being as fast as your
code.

Cheers,
Willy

