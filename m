Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbVINWBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVINWBA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbVINWBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:01:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14353 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965007AbVINWA7 (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:00:59 -0400
Date: Wed, 14 Sep 2005 23:00:49 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
Message-ID: <20050914230049.F30746@flint.arm.linux.org.uk>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
	Dipankar Sarma <dipankar@in.ibm.com>
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au> <Pine.LNX.4.61.0509141814220.3743@scrub.home> <43285374.3020806@yahoo.com.au> <Pine.LNX.4.61.0509141906040.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0509141906040.3728@scrub.home>; from zippel@linux-m68k.org on Wed, Sep 14, 2005 at 07:18:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 07:18:31PM +0200, Roman Zippel wrote:
> On Thu, 15 Sep 2005, Nick Piggin wrote:
> > Or here is possible pseudo code for an architecture with ll/sc
> > instructions:
> > 
> >   do {
> >     tmp = load_locked(v);
> >     if (!tmp)
> >       break;
> >     tmp++;
> >   } while (!store_cond(v, tmp));
> > 
> >   return tmp;
> > 
> > As opposed to using the cmpxchg version, which would have more
> > loads and conditional branches, AFAIKS.
> 
> I'd prefer to generalize this construct, than polluting atomic.h with all 
> kinds of esoteric atomic operations.
> So you would get:
> 
> 	do {
> 		old = atomic_load_locked(v);
> 		if (!old)
> 			break;
> 		new = old + 1;
> 	} while (!atomic_store_lock(v, old, new));

How do you propose architectures which don't have locked loads implement
this, where the only atomic instruction is an unconditional atomic swap
between memory and CPU register?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
