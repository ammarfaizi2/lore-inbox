Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314869AbSDVW3r>; Mon, 22 Apr 2002 18:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314873AbSDVW3q>; Mon, 22 Apr 2002 18:29:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9235 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314869AbSDVW3N>; Mon, 22 Apr 2002 18:29:13 -0400
Date: Mon, 22 Apr 2002 15:28:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Andrew Morton <akpm@zip.com.au>, Alexander Viro <viro@math.psu.edu>,
        <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: locking in sync_old_buffers
In-Reply-To: <3CC48D51.3050506@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0204221525190.1235-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Apr 2002, Dave Hansen wrote:
> Andrew Morton wrote:
>  > If you're going to do this, then the BKL should be acquired
>  > in fs/super.c:write_super(), so the per-fs ->write_super
>  > functions do not see changed external locking rules.
>  >
>  > Possibly, fs/inode.c:write_inode() needs the same treatment.
>  > But Doc/filesystems/Locking says that lock_kernel() is not
>  > held across ->write_inode so there should be no need to take
>  > it on the kupdate path.
> That sounds sane.  I was just fishing for information before I go do
> anything drastic.

I would personally avoid doing these kinds of locking changes in 2.4.x
altogether, unless there are really drastic reasons for them (ie real
machines under load at real customer sites that really care).

>  > That's for 2.4.  For 2.5, we'd like sync_old_buffers to just
>  > go away.   Do you have time to test
>  >http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.8/everything.patch.gz
> Absolutely.  What else does it contain that I should watch out for?

Don't use it on a production machine, but since this is in the 2.5.x
future, I'd love to hear about not just lock contention but also about
whether you can see any problems under heavy load.

		Linus

