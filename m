Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284776AbRLKBnU>; Mon, 10 Dec 2001 20:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284781AbRLKBnC>; Mon, 10 Dec 2001 20:43:02 -0500
Received: from rj.SGI.COM ([204.94.215.100]:58565 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S284779AbRLKBmk>;
	Mon, 10 Dec 2001 20:42:40 -0500
Date: Tue, 11 Dec 2001 12:41:15 +1100
From: Nathan Scott <nathans@sgi.com>
To: "Stephen C. Tweedie" <sct@redhat.com>,
        Andreas Gruenbacher <ag@bestbits.at>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: [PATCH] Revised extended attributes interface
Message-ID: <20011211124115.E70201@wobbly.melbourne.sgi.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <20011210115209.C1919@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011210115209.C1919@redhat.com>; from sct@redhat.com on Mon, Dec 10, 2001 at 11:52:09AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 11:52:09AM +0000, Stephen C. Tweedie wrote:
> Hi,
> 

hi there Stephen.

> On Sat, Dec 08, 2001 at 03:58:41PM +1100, Nathan Scott wrote:
> > On Fri, Dec 07, 2001 at 08:20:36PM +0000, Stephen C. Tweedie wrote:
> > 
> > > This is looking OK as far as EAs go.  However, there is still no
> > > mention of ACLs specifically, except an oblique reference to
> > > "system.posix_acl_access".  
> > 
> > Yup - there's little mention of ACLs because they are only an
> > optional, higher-level consumer of the API, & so didn't seem
> > appropriate to document here.
> 
> Unfortunately, if there are many filesystems wanting to use posix
> ACLs, then standardising the API is still desirable.
> 

Yes, absolutely.  That is in fact a large driving force behind
this effort to get a common EA and POSIX ACL API, and we are now
for the first time at a point where we have multiple filesystems
(xfs, ext2, and ext3) sharing the same API.  The history went a
bit like this:

- an implementation of POSIX ACLs was written for ext2 and ext3
by Andreas;
- an implementation of POSIX ACLs was ported for XFS (at the time,
Andreas' implementation didn't allow us to use our pre-existing
on-disk format from IRIX)
- Andreas made attempt #1 to get a system call interface agreed on
over a year ago now.  He incorporated several peoples suggestions,
but eventually the discussion got sidetracked, died and nothing
further happened;
- We were all _really_ hoping for something to come out of that,
so we could then "standardise" on the various APIs involved;

- [time passes, much pain is felt by lots of users - the patches
have to continually track new kernels where the syscall table
changes frequently break the user/kernel interface, affecting
an increasing number of userspace applications]

- After about a year of this, Andi gives us a kick in the pants,
we contact Andreas and make a renewed effort at producing an API
that we all can share.
- Several iterations later, we have an initial implementation
(which is not filesystem-specific for the first-time)
- We made attempt #2 to get system call and VFS interfaces agreed
on by posting to Linus, Al, various lists.  We incorporate all
the suggestions that we think make sense, and push out several
iterations of the patches out.
- We are all _really_ hoping for something to come out of this,
so that we can "standardise" on the various APIs involved;

- ...?


> > We have implemented POSIX ACLs above this interface - 
> 
> But the ACL encoding is still hobbled: ...

I have been on the acl-devel mailing list for a long time now,
and while these features all sound like good ideas or interesting
projects, I have never seen anyone post a patch or request any
specific changes to Andreas' ACL encoding in that time.

It seems to me that the relatively simple implementation which
Andreas has done is a good starting point (it has been used in
production for a long time now).

His POSIX ACL encoding has a version field in it, so if/when some
people step forward to implement these features you've described,
and if they require changes to the format, then there should be no
reason they can't do it cleanly and in a filesystem-independent
manner, right?  And if you do have reasons, its high time you sent
Andreas some patches! ;-)

Seriously though, from an XFS point of view, Andreas' current
implementation is simple and meets all of our needs, he does a
really good job of maintaining the code and is very responsive
on the acl-devel list and to questions from us XFS folk, so we
are quite happy to use his as the initial filesystem-independent
implementation of POSIX ACLs for Linux.

cheers.

-- 
Nathan
