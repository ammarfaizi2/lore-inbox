Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261852AbSJJRo4>; Thu, 10 Oct 2002 13:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSJJRo4>; Thu, 10 Oct 2002 13:44:56 -0400
Received: from netrealtor.ca ([216.209.85.42]:39689 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261852AbSJJRoz>;
	Thu, 10 Oct 2002 13:44:55 -0400
Date: Thu, 10 Oct 2002 13:50:43 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021010175043.GA16962@mark.mielke.cc>
References: <1034104637.29468.1483.camel@phantasy> <XFMail.20021009103325.pochini@shiny.it> <20021009170517.GA5608@mark.mielke.cc> <3DA4852B.7CC89C09@denise.shiny.it> <20021009222438.GD5608@mark.mielke.cc> <20021009232002.GC2654@bjl1.asuk.net> <20021010030736.GA8805@mark.mielke.cc> <3DA55C8C.760584EE@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA55C8C.760584EE@aitel.hist.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 12:55:08PM +0200, Helge Hafting wrote:
> Mark Mielke wrote:
> > I might be wrong, but it seems to me that O_STREAMING isn't the answer
> > to everything. The primary benefactors of O_STREAMING would be
> > applications that read very large files that do not fit into RAM, from
> > start to finish.
> It don't have to be a file that don't fit into RAM.  Remember, other
> running apps wants memory and cache too, so the "fair share" of memory
> for _this_ process is much smaller than all of RAM.
> So, O_STREAMING makes sense for all files where we know that we're going
> sequentially and that caching this for long won't help. 
> (Because the contents likely will be pushed out before we need
> them again anyway (DVD case) or we know were going to delete
> the file, or we simply don't want to push anything else
> out even if we could cache this.)

Then perhaps O_STREAMING should be called O_EXTENDEDSTREAMING.

If you overload O_STREAMING to contain all possibile uses for sequential
reads, you end up hurting yourself.

Small files are different beasts from large files. If you want O_STREAMING
to work in all cases, you really want standard mode to work in all cases,
and O_STREAMING is not for you.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

