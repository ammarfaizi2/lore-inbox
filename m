Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277202AbRJINcO>; Tue, 9 Oct 2001 09:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277201AbRJINcE>; Tue, 9 Oct 2001 09:32:04 -0400
Received: from zok.SGI.COM ([204.94.215.101]:26588 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S277204AbRJINbz>;
	Tue, 9 Oct 2001 09:31:55 -0400
Date: Tue, 9 Oct 2001 23:31:59 +1000
From: Nathan Scott <nathans@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: ENOATTR and other error enums
Message-ID: <20011009233159.C473872@wobbly.melbourne.sgi.com>
In-Reply-To: <20011009150113.A497835@wobbly.melbourne.sgi.com> <E15qw8x-00041l-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15qw8x-00041l-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Oct 09, 2001 at 01:37:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Alan,

Thanks for the comments.

On Tue, Oct 09, 2001 at 01:37:55PM +0100, Alan Cox wrote:
> > XFS needs both values.  ENOATTR is also required by the ext2
> > extended attributes project (and any other filesystem intending
> > to implement extended attributes in the future).  Both values
> > need to be visible in both kernel and user space, so this patch
> > would be an initial step toward libc support also, hopefully.
> > 
> > In the absence of any cleaner way to do this (?), could we have
> > this patch applied please?  Any/all feedback much appreciated
> 
> Such an update needs to be synchronized with glibc to avoid people
> getting all sorts of odd "unknown" error messages.

Yup, understood.  I was punting that it would need to appear
in the kernel headers first though, so thought I'd test the
water with you guys and try to understand the process for such
a change.

The "unknown error" messages can't really be avoided in all cases
anyway - even when there is a coordinated libc release there will
always be (the vast majority of?) people running new kernels with
older libc versions for awhile ... thats life though, I guess, if
there's no other solution to the problem.

> In general I dn't see why its needed.

For ENOATTR, an error code is needed which doesn't conflict
with any other used in the filesystem, so that a failure to
get/set/... an extended attribute can be distinguished from
other errors related to looking up the pathname initially,
as an example.

> > > EFSCORRUPTED = Filesystem is corrupted
> 
> EIO is normally used for this

Yeah, the semantics here are slightly different, but perhaps we
can get away with this... (Steve?  do you know of any cases in
the code where we need to be able to distinguish the EIO value
from EFSCORRUPTED?  or any other reason why this wouldn't work?
It is the obvious one - I'd imagine there was a reason for not
using it originally).

> As to the string names for errors. They can't sanely go into the kernel
> or kernel headers.

Yes, that wasn't being suggested.

> Remember there are a lot of languages out there

Yup - understood.

thanks.

-- 
Nathan
