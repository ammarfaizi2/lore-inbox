Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311583AbSCNLHA>; Thu, 14 Mar 2002 06:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311584AbSCNLGu>; Thu, 14 Mar 2002 06:06:50 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:51984 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S311583AbSCNLGk>; Thu, 14 Mar 2002 06:06:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas 
In-Reply-To: Your message of "14 Mar 2002 09:39:57 BST."
             <p73bsdrsftu.fsf@oldwotan.suse.de> 
Date: Thu, 14 Mar 2002 22:09:52 +1100
Message-Id: <E16lT7I-0003uC-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <p73bsdrsftu.fsf@oldwotan.suse.de> you write:
> Rusty Russell <rusty@rustcorp.com.au> writes:
> 
> > In message <15504.7958.677592.908691@napali.hpl.hp.com> you write:
> > > OK, I see this.  Unfortunately, HIDE_RELOC() causes me problems
> > > because it prevents me from taking the address of a per-CPU variable.
> > > This is useful when you have a per-CPU structure (e.g., cpu_info).
> > > Perhaps there should/could be a version of HIDE_RELOC() that doesn't
> > > dereference the resulting address?
> > 
> > Yep, valid point.  Patch below: please play.
> 
> Please don't do that. I cannot easily take the address of a per CPU 
> variable on x86-64, or rather only with additional overhead. If you need the
> address of one please use a different macro for that.

Sorry, I think one macro to get the address, one to get the contents
is a *horrible* interface.  per_cpu() and per_cpu_ptr() or something?
I think you'll find that per_cpu_ptr would be fairly common, so we're
forced into a bad interface for little gain.  You might be better off
using another method to implement per-cpu areas.

To be honest, it was merely my oversight that the statement expression
didn't allow the address to be taken in the first place, not a
feature.

Sorry,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
