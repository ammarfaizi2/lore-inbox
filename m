Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265495AbRF1DFM>; Wed, 27 Jun 2001 23:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265503AbRF1DEx>; Wed, 27 Jun 2001 23:04:53 -0400
Received: from alumnus.caltech.edu ([131.215.50.236]:8165 "EHLO
	alumnus.caltech.edu") by vger.kernel.org with ESMTP
	id <S265494AbRF1DEn>; Wed, 27 Jun 2001 23:04:43 -0400
Date: Wed, 27 Jun 2001 20:04:41 -0700 (PDT)
From: "Daniel R. Kegel" <dank@alumni.caltech.edu>
Message-Id: <200106280304.UAA07087@alumnus.caltech.edu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>, x@xman.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Smith <x@xman.org> wrote:

> Jamie Lokier <lk@tantalophile.demon.co.uk> wrote:
> > Btw, this functionality is already available using sigaction().  Just
> > search for a signal whose handler is SIG_DFL.  If you then block that
> > signal before changing, checking the result, and unblocking the signal,
> > you can avoid race conditions too.  (This is what my programs do).
> 
> It's more than whether a signal is blocked or not, unfortunately. Lots of 
> applications will invoke sigwaitinfo() on whatever the current signal mask 
> is, which means you can't rely on sigaction to solve your problems. :-(

As Chris points out, allocating a signal by the scheme Jamie
describes is neccessary but not sufficient.  The problem Chris
ran into is that he allocated a signal fair and square, only to find
the application picking it up via sigwaitinfo()!
Yes, this is a bug in the application -- but it's interesting that this
bug only shows up when you try to integrate a new, well-behaved, library 
into the app.  It's a fragile part of the Unix API.  sigopen() is
a way for libraries to defend themselves against misuse of sigwaitinfo()
by big applications over which you have no control.

So sigopen() is a technological fix to a social problem, I guess.
- Dan
