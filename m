Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263113AbSIPVoQ>; Mon, 16 Sep 2002 17:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263118AbSIPVoQ>; Mon, 16 Sep 2002 17:44:16 -0400
Received: from dsl-213-023-040-192.arcor-ip.net ([213.23.40.192]:60298 "EHLO
	starship") by vger.kernel.org with ESMTP id <S263113AbSIPVoO>;
	Mon, 16 Sep 2002 17:44:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] Raceless module interface
Date: Mon, 16 Sep 2002 23:48:41 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209161756540.28515-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0209161756540.28515-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17r3jV-0005en-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 23:36, Roman Zippel wrote:
> > > > I disagree with pushing the count into the filesystem structure: it
> > > > changes nothing except hide the fact that you're only keeping
> > > > reference counts for the sake of the module.  Filesystems are low
> > > > performance impact, but other subsystems really don't want that atomic
> > > > inc and dec for every access.
> > >
> > > As I already said before, it doesn't has to be an atomic reference count.
> >
> > Please explain?  It has to be atomic for all the interesting cases
> > (sure, fs mounting might be protected by a lock, but other things aren't).
> 
> Let me explain it in a larger context. You and Daniel are making it really
> more complex than necessary. Only the module itself can really answer the
> question whether it's safe to unload or not.

Excuse me, Roman, but that's the central thesis of my [rfc].  If I didn't
express it concisely enough to make that obvious, I apologize.

> So all the module code
> needs to do is some general module management and ask the module somehow,
> whether it's safe to unload, when the user requests it. The easiest way
> for modules to check for this is to use counters, it's very simple and
> covers the majority of modules.

Err, check.  In the [rfc].

> The few modules that don't want/can't use counters can use whatever they
> want and they usually know better how to synchronize with the part of the
> kernel where they installed their hooks into, without disturbing too much
> other parts of the kernel.

Check.  In the [rfc].

> I really don't like the synchronize calls as general mechanism, either
> they have to to do too much and possibly disturb other parts without good
> reason

Check.  In the [rfc].

> or modules have to take care of it (e.g. don't call somehow
> schedule() without extra protection). This makes the whole synchronize
> mechanism very fragile, which I'd prefer to keep it in the modules which
> really need it, where it can be better controlled.

Yuppers.  Are there any points at all we disagree on?

-- 
Daniel
