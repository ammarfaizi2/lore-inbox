Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317955AbSGLApg>; Thu, 11 Jul 2002 20:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317954AbSGLApf>; Thu, 11 Jul 2002 20:45:35 -0400
Received: from mail.storm.ca ([209.87.239.66]:58005 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S317955AbSGLApe>;
	Thu, 11 Jul 2002 20:45:34 -0400
Message-ID: <3D2E1A4D.10705EA5@storm.ca>
Date: Thu, 11 Jul 2002 19:52:45 -0400
From: Sandy Harris <pashley@storm.ca>
Organization: Flashman's Dragoons
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Daniel Phillips <phillips@arcor.de>, Jesse Barnes <jbarnes@sgi.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: spinlock assertion macros
References: <Pine.LNX.4.44.0207111131550.15441-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Thu, 11 Jul 2002, Daniel Phillips wrote:
> 
> > I was thinking of something as simple as:
> >
> >    #define spin_assert_locked(LOCK) BUG_ON(!spin_is_locked(LOCK))
> >
> > but in truth I'd be happy regardless of the internal implementation.  A note
> > on names: Linus likes to shout the names of his BUG macros.  I've never been
> > one for shouting, but it's not my kernel, and anyway, I'm happy he now likes
> > asserts.  I bet he'd like it more spelled like this though:
> >
> >    MUST_HOLD(&lock);
> 
> I prefer that form too.

Is it worth adding MUST_NOT_HOLD(&lock) in an attempt to catch potential
deadlocks?

Say that if two or more of locks A, B and C are to be taken, then
they must be taken in that order. You might then have code like:

	MUST_NOT_HOLD(&lock_B) ;
	MUST_NOT_HOLD(&lock_C) ;
	spinlock(&lock_A) ;

I think you need a separate asertion for this !MUST_NOT_HOLD(&lock)
has different semantics.
