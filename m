Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268286AbUIWF3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268286AbUIWF3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 01:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268289AbUIWF3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 01:29:20 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:35002 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S268286AbUIWF3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 01:29:07 -0400
Subject: Re: [RFC][PATCH] inotify 0.9.2
From: Ray Lee <ray-lk@madrabbit.org>
To: Robert Love <rml@novell.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Edgar Toernig <froese@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1095916247.2454.188.camel@localhost>
References: <1095652572.23128.2.camel@vertex>
	 <1095744091.2454.56.camel@localhost>
	 <20040921173404.0b8795c9.froese@gmx.de>
	 <41504C21.3090506@nortelnetworks.com>  <1095820046.22558.4.camel@vertex>
	 <1095904012.11637.81.camel@orca.madrabbit.org>
	 <1095910956.9652.2.camel@vertex>
	 <1095915177.4101.63.camel@orca.madrabbit.org>
	 <1095916247.2454.188.camel@localhost>
Content-Type: text/plain
Organization: http://madrabbit.org/
Message-Id: <1095917344.4101.89.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 22:29:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I still might be talking crazy talk, but...

On Wed, 2004-09-22 at 22:10, Robert Love wrote:
> The comment is just a warning, though, to explain the dreary theoretical
> side of the world.  Pragmatism demands that we just use
> INOTIFY_FILENAME_MAX, which is a more reasonable 256.

Why bother being pragmatic when we can be correct? It's not much more
code to just do it right, and allow up to PATH_MAX filenames to be
passed to userspace.

As an alternate argument, an `ls -1 | wc` on a randomly picked directory
of my filesystem reveals an average filename length of just under 11
characters. We can save some memory (and a lot of syscalls!) by packing
in events more tightly than the 256 character statically sized
rendition.

So, correct *and* efficient. Again, what am I missing here?

> > BTW:
> > <pedantic>
> > +	unsigned long		bitmask[MAX_INOTIFY_DEV_WATCHERS/BITS_PER_LONG];
> > 
> > would be more correct if written
> > 
> >   unsigned long bitmask[(MAX_INOTIFY_DEV_WATCHERS + BITS_PER_LONG - 1) / BITS_PER_LONG];
> > 
> > </pedantic>
> 
> Indeed!  Although we define MAX_INOTIFY_DEV_WATCHERS right above and it
> is a power of two.

Sure, it's a multiple of BITS_PER_LONG right *now*, but what about in
the future? It only adds compile time overhead. Regardless, it's why I
wrote my comment as 'more correct.' I won't lose any sleep over that
change not going in, but there's no reason to encourage bad coding
habits.

> Oh, dude, inotify is a godsend.

Amen. So let's get it nailed, so that this corner of the problem space
can be considered done, and we can all move on to building bigger and
better things on top of it.

Ray

