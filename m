Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132382AbRAJSrm>; Wed, 10 Jan 2001 13:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132918AbRAJSrd>; Wed, 10 Jan 2001 13:47:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28682 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132382AbRAJSrY>;
	Wed, 10 Jan 2001 13:47:24 -0500
Date: Wed, 10 Jan 2001 18:47:09 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Daniel Phillips <phillips@innominate.de>
Cc: Mark Hindley <mh15@st-andrews.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 kernel paging error
Message-ID: <20010110184709.F21944@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <l03130302b681de2fd7a0@[138.251.135.28]> <3A5C93E9.A96EF8AE@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A5C93E9.A96EF8AE@innominate.de>; from phillips@innominate.de on Wed, Jan 10, 2001 at 05:55:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 05:55:05PM +0100, Daniel Phillips wrote:
> Mark Hindley wrote:
> > I am running 2.4.0 final. I got the following failed paging request which
> > produced a complete freeze.
> > 
> > As you can see it was precipitated by cron starting to run some
> > housekeeping stuff overnight.
> > 
> > Has anyone else had prblems?
> 
> It looks real.  It was executing this line of clear_inode in fs/inode.c:
> 
> 380         if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->clear_inode)
>                                                                      ^^^^^^^^^^^^^
>                                            and it blew up here ----->

> Unable to handle kernel paging request at virtual address c4870840

I'm pretty sure this is a vmalloc/module address, which would mean ->s_op
points to a module that has been unloaded.  This sounds consistent with the
"cron starting to run some housekeeping stuff" above.

Mark, which file systems are you using ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
