Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbSKIBKN>; Fri, 8 Nov 2002 20:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263899AbSKIBKN>; Fri, 8 Nov 2002 20:10:13 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:51878 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S263837AbSKIBKM>; Fri, 8 Nov 2002 20:10:12 -0500
Date: Fri, 8 Nov 2002 17:02:13 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: The return of the return of crunch time (2.5 merge candidate list 1.6)
Message-ID: <20021108220213.GC16051@pimlott.net>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <200210251557.55202.landley@trommello.org.suse.lists.linux.kernel> <p7365vptz49.fsf@oldwotan.suse.de> <20021026190906.GA20571@pimlott.net> <20021027080125.A14145@wotan.suse.de> <20021027152038.GA26297@pimlott.net> <20021028053004.C2558@wotan.suse.de> <20020115174416.GC2015@zaurus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115174416.GC2015@zaurus>
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 12:44:28PM -0500, Pavel Machek wrote:
> > The point of my patchkit is to allow the file systems
> > who support better resolution to handle it properly. Other filesystems
> > are not worse than before when they flush inodes (and better off when
> > they keep everything in ram for your build because then they will enjoy 
> > full time resolution) 
> 
> What about always rounding down even when inode is
> in memory? That is both simple and consistent.

I assume you mean, for filesystems that don't support high
resolution.  That is what I think should be done as well.  People
have gotten along with second resolution all these years, so it's no
great tragedy to make them continue; plus, it seems like the common
filesystems will support high resolution soon anyway.

Paul Eggert listed lots of programs that could be broken if
timestamps jump around.  They could all implement heuristic
work-arounds, but that would be 1) a miracle and 2) a waste of
effort.

The only issue (as far as I can tell) is knowing when to round.
Hard-coding a list of filesystems seems reasonable (though even that
could be wrong if I load a newer filesystem module).  Ideally,
though, you would add a simple hook into the filesystem that asks it
to round the timestamp for you.  This would also accommodate
filesystems that don't store seconds or nanoseconds, but some other
resolution.

Andrew
