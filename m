Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbWHFDwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWHFDwF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 23:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWHFDwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 23:52:04 -0400
Received: from ozlabs.org ([203.10.76.45]:693 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751513AbWHFDwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 23:52:03 -0400
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dmitry.torokhov@gmail.com
In-Reply-To: <20060806031643.GA43490@muc.de>
References: <1154771262.28257.38.camel@localhost.localdomain>
	 <20060806023824.GA41762@muc.de>
	 <1154832963.29151.21.camel@localhost.localdomain>
	 <20060806031643.GA43490@muc.de>
Content-Type: text/plain
Date: Sun, 06 Aug 2006 13:52:01 +1000
Message-Id: <1154836321.29151.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-06 at 05:16 +0200, Andi Kleen wrote:
> > 	Please reconsider.  This isn't about being pretty, it's about not
> > having hidden side-effects,
> 
> I wouldn't call it hidden, it's well defined in the architecture.

Sorry Andi, I'm not talking about the asm, which is fine.  I'm talking
about the function-style macro which alters its arguments directly.
It's very bad form.

	int a, b;
	rdtsc(a, b);

> > and having typechecking.
> 
> The existing code will already reject any non integer and I don't
> see a particular need to be more strict than that.

Um?

	u64 c;
	int a,b;

	rdtsc(&a, &b);
	rdtscl(c);

These macros are badly named and don't check for bad usage.  Sure, less
than 1% of uses is wrong at the moment, but I'm volunteering to fix them
because I think it sets a bad example and sets us up for more bugs.

I feel fairly strongly about this, but I'll drop the x86_64 changes.

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

