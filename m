Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263449AbUJ2SWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbUJ2SWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbUJ2SWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 14:22:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:47782 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263449AbUJ2SSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:18:48 -0400
Date: Fri, 29 Oct 2004 11:18:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: linux-os@analogic.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <20041029151139.GA73646@muc.de>
Message-ID: <Pine.LNX.4.58.0410291114300.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
 <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com>
 <41757478.4090402@drdos.com> <20041020034524.GD10638@michonline.com>
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <20041029151139.GA73646@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Oct 2004, Andi Kleen wrote:
>
> > Richard, Jan, Andi? Or does it already exist somewhere?
> 
> How about just using __attribute__((regparm(1)))  ?  Then the
> problem doesn't appear. 

Yes, we could use regparm for all assembly. Right now "asmlinkage" 
actually _disables_ regparm so that we always have the same calling 
convention for assembly regardless of whether the rest of the kernel is 
compiled with regparm or not, but we could certainly change that 

	#define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))

to use "regparm(3)" instead. I guess it's stable these days, since we use 
it for FASTCALL() and friends too.

> Would be faster too. It should work reliable on all supported compilers.

What's happens if there are more arguments than three? It happens for 
several system calls - does gcc still consider the stack part of the thing 
to be owned by the callee?

		Linus
