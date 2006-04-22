Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWDVT1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWDVT1F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWDVT0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:26:37 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45243 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751067AbWDVTZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:25:59 -0400
Subject: Re: [PATCH] 'make headers_install' kbuild target.
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060422142043.GD5010@stusta.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org>
	 <20060422093328.GM19754@stusta.de>
	 <1145707384.16166.181.camel@shinybook.infradead.org>
	 <20060422141410.GA25926@mars.ravnborg.org>
	 <20060422142043.GD5010@stusta.de>
Content-Type: text/plain
Date: Sat, 22 Apr 2006 15:35:07 +0100
Message-Id: <1145716507.11909.282.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 16:20 +0200, Adrian Bunk wrote:
> > Thats bacause the kabi subdir is broken by design.
> > Any approach that does not take into account the existing userbase is
> > broken by design and should be avoided.
> > The only sensible solution is to move out the kernel internal headers
> > from include/* to somewhere else.
> > And then slowly but steady let include/linux and include/asm-* be the
> > KABI.
> >...

The 'make headers_export' stage also works just as well as the above,
and it gives us something more concrete to work on, where we can _see_
the bits which are needlessly exported and start to clean them up.

> What exactly is the problem with creating the userspace ABI in 
> include/kabi/ and letting distributions do an
>   cd /usr/include && ln -s kabi/* .
> ?
> 
> Or with creating the userspace ABI in include/kabi/ and letting 
> distributions install the subdirs of include/kabi/ directly under 
> /usr/include?

The problem is that Linus is unlikely to accept a trivial cleanup patch
which, for example, removes the contents of linux/auxvec.h and creates
kabi/auxvec.h. He'll argue, as he did last year, that it's moving stuff
around for the sake of it.

On the other hand, he _would_ be likely to accept patches which split
existing files into two _within_ the include/linux directory. And that's
the important part of the task; it doesn't _matter_ where the files are
put, because we can deal with that in the 'export' stage, and we can
trivially move them around later anyway once we do have a consensus.

We're doing it this way because we want to get on with the real work
without getting bogged down in a discussion with Linus about the
pointless details. Unfortunately we're getting bogged down in a
discussion about the pointless details anyway.

If you can get the trivial patches to move stuff into kabi/ merged,
that's _FINE_. Go wild. If you can't, then it's still useful to do the
same cleanups but keep all the resulting files in the same directories.

The 'headers_export' make target is still useful in the meantime,
because it produces the set of headers which we expect people to put
into /usr/include, and which we can do sanity checks on.

-- 
dwmw2

