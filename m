Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269350AbRHCIby>; Fri, 3 Aug 2001 04:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269349AbRHCIbo>; Fri, 3 Aug 2001 04:31:44 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:46833 "EHLO
	dukat.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S269345AbRHCIbe>; Fri, 3 Aug 2001 04:31:34 -0400
Date: Fri, 3 Aug 2001 09:30:57 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010803093057.Y12470@redhat.com>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010801170230.B7053@redhat.com> <20010802110341.B17927@emma1.emma.line.org> <01080219261601.00440@starship> <20010802193750.B12425@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010802193750.B12425@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Thu, Aug 02, 2001 at 07:37:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 02, 2001 at 07:37:50PM +0200, Matthias Andree wrote:

> So this part is covered.
> 
> The other thing is, that Linux is the only known system that does
> asynchronous rename/link/unlink/symlink -- people have claimed it might
> not be the only one, but failed to name systems.

Not true.  There are tons of others.

The issue was that synchronous directory updates are *optional* on
many systems (Linux included), but that Linux's support for that is
really inefficient since it ends up syncing file metadata updates too
(and it's much more efficient to use fsync for that.)

> Still, some people object to a dirsync mount option.

Who?  People who have discussed this in the past have certainly not
objected to my knowledge.  It would clearly help situations like this
(as would a dirsync chattr option.)

> > The prescription for symlinks is, if you want them safely on disk you 
> > have to explicitly fsync the containing directory.
> 
> Yes, and it doesn't matter, since MTAs don't use symlinks (symlinks
> waste inodes on most systems).

Irrelevant.   We're talking about what makes sensible semantics, not
what assumptions any specific application makes.  It makes no sense to
say that dirsync won't affect symlinks just because some existing
applications don't rely on that!

Cheers,
 Stephen
