Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132906AbRDEOgi>; Thu, 5 Apr 2001 10:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132908AbRDEOg3>; Thu, 5 Apr 2001 10:36:29 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:54793 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132906AbRDEOgT>;
	Thu, 5 Apr 2001 10:36:19 -0400
Date: Thu, 5 Apr 2001 10:35:00 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
To: Joseph Carter <knghtbrd@debian.org>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: asm/unistd.h
In-Reply-To: <20010405072628.C22001@debian.org>
Message-ID: <Pine.LNX.4.30.0104051031210.13496-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001, Joseph Carter wrote:

> On Thu, Apr 05, 2001 at 09:06:20AM -0400, Bart Trojanowski wrote:
> > So you ask: "why not just use a { ... } to define a macro".  I don't
> > remember the case for this but I know it's there.  It has to do with a
> > complicated if/else structure where a simple {} breaks.
>
> This doesn't follow in my mind.  I can't think of a case where a { ... }
> would fail, but a do { ... } while (0) would succeed.  The former would
> also save a few keystrokes.

Tim Waugh already stated this one:

#define foo(x) { do_something(x) }

if( condition )
  foo(x);
else
  foo(y);

would produce

if( condition )
  { do_something(x) };
else
  { do_something(y) };

note the semi-colon at the end of {.*}.

This is bad because it forces you to use the foo macro knowing it's a
macro and not a function.

So you say I will use it like this:

if( condition )
  foo(x)
else
  foo(y)

That's just great for this case, but now imagine that on some other
architecture doing foo(x) takes many many lines with recursion and all.
You don't want that to be in a macro so you make a function.  And you get
many many compiler errors on thsi new platform.

Cheers,
Bart.

-- 
	WebSig: http://www.jukie.net/~bart/sig/


