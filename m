Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269354AbRHCIuy>; Fri, 3 Aug 2001 04:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269355AbRHCIup>; Fri, 3 Aug 2001 04:50:45 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:38392 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S269354AbRHCIuf>;
	Fri, 3 Aug 2001 04:50:35 -0400
Date: Fri, 3 Aug 2001 10:50:30 +0200
From: David Weinehall <tao@acc.umu.se>
To: Daniel Phillips <phillips@bonn-fries.net>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010803105029.I6387@khan.acc.umu.se>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010801170230.B7053@redhat.com> <20010802110341.B17927@emma1.emma.line.org> <01080219261601.00440@starship> <20010802193750.B12425@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010802193750.B12425@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Thu, Aug 02, 2001 at 07:37:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 07:37:50PM +0200, Matthias Andree wrote:
> On Thu, 02 Aug 2001, Daniel Phillips wrote:
> 
> [file name must be flushed on fsync()]
> > I don't know why it is hard or inefficient to implement this at the VFS 
> > level, though I'm sure there is a reason or this thread wouldn't 
> > exist.  Stephen, perhaps you could explain for the record why sys_fsync 
> > can't just walk the chain of dentry parent links doing fdatasync?  Does 
> > this create VFS or Ext3 locking problems?  Or maybe it repeats work 
> > that Ext3 is already supposed to have done?
> 
> Well, the course was that I asked whether ext3 would do synchronous
> directory updates, and some people jumped in and said that one should
> fsync() the parent directory, however, since we figure from SUS, that's
> invalid.
> 
> After some forth and back, we finally figured that at least ext2 is
> implementing fsync() improperly.
> 
> So this part is covered.

Yup, and this should be fixed imho.

> The other thing is, that Linux is the only known system that does
> asynchronous rename/link/unlink/symlink -- people have claimed it might
> not be the only one, but failed to name systems.

And this is a feature, not a bug.

> So we need to assume that Linux is the only system that does
> asynchronous rename/link/unlink/symlink, however a directory fsync() is
> believed to be rather expensive.

A directory fsync() might be expensive on non-Linux filesystems...

> Still, some people object to a dirsync mount option. But this has been
> the actual reason for the thread - MTA authors are refusing to pamper
> Linux and use chattr +S instead which gives unnecessary (premature) sync
> operations on write() - but MTAs know how to fsync().

So what you mean is that MTA authors refuse to pamper Linux through use
of fsync of the directory, but can accept to "pamper" Linux through use
of chattr +S?! This seem ridiculous.  It seems equally ridiculous to
demand that Linux should pamper for MTA authors that can't implement
fsync on the directory instead of writing BSD-specific code.

[snip]

To me this seems mostly like a way of saying "Hey, we've finally found
a way to make Linux look really bad compared to BSD-systems; let's
complain instead of writing alternative code that suits Linux systems
better than this code does." A lot like all the discussions on threads,
ueally.

Then again, I'm probably just extra grouchy today because it rained when
I rode my bike to work.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
