Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbTCBVbB>; Sun, 2 Mar 2003 16:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbTCBVbB>; Sun, 2 Mar 2003 16:31:01 -0500
Received: from almesberger.net ([63.105.73.239]:32016 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S261295AbTCBVa7>; Sun, 2 Mar 2003 16:30:59 -0500
Date: Sun, 2 Mar 2003 18:41:14 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Norbert Kiesel <nkiesel@tbdnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Multiple & vs. && and | vs. || bugs in 2.4.20
Message-ID: <20030302184114.Q2791@almesberger.net>
References: <20030302121425.GA27040@defiant> <3E6247F7.8060301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E6247F7.8060301@redhat.com>; from drepper@redhat.com on Sun, Mar 02, 2003 at 10:05:43AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> > -	if (!urb->status & !acm->throttle)  {
> > +	if (!urb->status && !acm->throttle)  {
[...]
> Have you really looked at detail at all these cases?  The problem is
> that you have made the code less efficient on some platforms.  The use
> of && requires shortcut evaluation.  I.e., the compiler is forced to not

While I agree with your observation in general, this is actually
something the compiler should be able to figure out by itself:

 - there's only a side-effect if acm is NULL
 - in ACM_READY, we've already tested acm for NULL, and subsequently
   de-referenced it
 - acm is a local variable, and not aliased, so the dbg() can't
   change it

So, given the negations, || and | are equivalent in this case, and
whether a jump, conditional execution, a bit operation, or something
else yields better code is compiler, machine, and context specific.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
