Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312604AbSDFRCD>; Sat, 6 Apr 2002 12:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312606AbSDFRCC>; Sat, 6 Apr 2002 12:02:02 -0500
Received: from bitmover.com ([192.132.92.2]:4564 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S312604AbSDFRCB>;
	Sat, 6 Apr 2002 12:02:01 -0500
Date: Sat, 6 Apr 2002 09:01:57 -0800
From: Larry McVoy <lm@bitmover.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Larry McVoy <lm@bitmover.com>, reiserfs-dev@namesys.com,
        linux-kernel@vger.kernel.org, flx <flx@namesys.com>
Subject: Re: ReiserFS Bug Fixes 3 of 6 (Please apply all 6)
Message-ID: <20020406090157.A12017@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Hans Reiser <reiser@namesys.com>, Larry McVoy <lm@bitmover.com>,
	reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org,
	flx <flx@namesys.com>
In-Reply-To: <200204052027.g35KRc002869@bitshadow.namesys.com> <Pine.LNX.4.33.0204051347500.1746-100000@penguin.transmeta.com> <20020405171001.C6087@work.bitmover.com> <3CAEE365.4020301@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2002 at 04:00:37PM +0400, Hans Reiser wrote:
> I am confused, the bk patches look like they have normal patches at the 
> top of them.  

If you just want to send him regular patches, use bk export -tpatch.
That's sort of a lame way to go if you are using BK on both ends,
you're going to end up merging your changes with your changes when
you pull from Linus' tree.  There are lots of reasons why this isn't
a good idea.

> We were planning on setting up a clone for non-Namesys users outside our 
> firewall, but we need for Linus's access to be just as secure as ours. 

bk help url, then look at 

       bk://<user>@<host>
	Connects to <host> using ssh, assumes that bkd is  the
	login shell.  The home directory of <user> must be the
	root of the repository.

then you can make a login shell that looks like

	#!/bin/sh
	exec bk bkd -xcd 

and you have an ssh based login which can only look at data in that
directory.  This is how the write path on bkbits.net works.

> Another model you might consider, one which would probably make you more 
> money, make us happier, and better avoid "freeloaders", would be to make 
> bitkeeper free for use with free software only.  This would be rather 
> similar to what I use for reiserfs, which is free for use with free 
> operating systems only, and available for a fee for all others.  It 
> allows you to "do unto others as they would do unto you" (The Reiser 
> Rule ;-) ).

We are dealing with various commercial organizations who play games
with the checkin comments so that they can use BK for free and not give
up any information.  Technically, it's a violation of the license if
they do that, but proving that they are doing it just isn't worth it.
What I'm tempted to do is to figure out a reasonable way to force free
uses to make their changes publically available.  More like sourceforge,
if you use their service, anyone can get at your source.  The problem
is that we can't force all the changes out into the open immediately,
people may have good reasons to hide (security changes, for example),
along with bad reasons (they're freeloaders).

Allowing free use of BK with free software only doesn't solve anything.
We have lots of people doing that and still hiding their changes
behind empty (or "fixed") checkin comments.  It's only the commercial
organizations who are a problem.  I'd really like to force those changes
out in the open if they aren't going to pay.  The whole point of the
openlogging stuff was to get people to work out in the open.

I've thought a bit about some sort of answer which addresses this and
I'm curious to see what people would think if the rule were that your
changes had to show up on a public server within a given time period
(a month? 2 months? 3 months?).  In other words, factor in a reasonable
ability to work in privacy but make it be limited enough that it only
works for truly free software.

My definition of free software is anything where the source is publically
available.  It's sometimes called "Open Source".  Open source software
where you can't get at the source is lame.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
