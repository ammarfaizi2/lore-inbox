Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSGQWEn>; Wed, 17 Jul 2002 18:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316794AbSGQWEn>; Wed, 17 Jul 2002 18:04:43 -0400
Received: from mail.eskimo.com ([204.122.16.4]:28687 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S316788AbSGQWEm>;
	Wed, 17 Jul 2002 18:04:42 -0400
Date: Wed, 17 Jul 2002 15:07:27 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
Message-ID: <20020717220727.GA3966@eskimo.com>
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <20020717043853.GA31493@eskimo.com> <je65zel8pr.fsf@sykes.suse.de> <20020717164933.GA2136@eskimo.com> <ah4act$1n5$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah4act$1n5$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 05:43:57PM +0000, Linus Torvalds wrote:
> In article <20020717164933.GA2136@eskimo.com>,
> Elladan  <elladan@eskimo.com> wrote:
> >
> >Consider what this says, if a particular OS doesn't pick a standard
> >which the application can port to.  It means that the *only way* to
> >correctly close a file descriptor is like this:
> >
> >int ret;
> >do {
> >	ret = close(fd);
> >} while(ret == -1 && errno != EBADF);
> 
> NO.
> 
> The above is
>  (a) not portable
>  (b) not current practice
> 
> The "not portable" part comes from the fact that (as somebody pointed
> out), a threaded environment in which the kernel _does_ close the FD on
> errors, the FD may have been validly re-used (by the kernel) for some
> other thread, and closing the FD a second time is a BUG.

That somebody was me.  It appears we're in extremely violent agreement
on this issue.  We both agree the code I wrote is crap.  :-)

-J
