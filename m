Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269737AbRHDBDc>; Fri, 3 Aug 2001 21:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269733AbRHDBDW>; Fri, 3 Aug 2001 21:03:22 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:36881 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269737AbRHDBDM>; Fri, 3 Aug 2001 21:03:12 -0400
Message-ID: <3B6B4B21.B68F4F87@zip.com.au>
Date: Fri, 03 Aug 2001 18:08:49 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic 
 change patch)
In-Reply-To: <01080315090600.01827@starship> <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu> <9keqr6$egl$1@penguin.transmeta.com>,
		<9keqr6$egl$1@penguin.transmeta.com> <20010804100143.A17774@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Fri, Aug 03, 2001 at 06:34:14PM +0000, Linus Torvalds wrote:
> 
>         fsync(int fd)
>         {
>                 dentry = fdget(fd);
>                 do_fsync(dentry);
>                 for (;;) {
>                         tmp = dentry;
>                         dentry = dentry->d_parent;
>                         if (dentry == tmp)
>                                 break;
>                         do_fdatasync(dentry);
>                 }
>         }
> 
> I really like this idea. Can people please try out the attached patch?

Ow.  You just crippled ext3.

I don't think an ext2 problem (which I don't think is a problem
at all) should be "fixed" at the VFS layer when other filesystems
are perfectly happy without it, no?

This whole thread, talking about "linux this" and "linux that"
is off-base.  It's ext2 we're talking about.  This MTA requirement
is a highly unusual and specialised thing - I don't see why the
general-purpose ext2 should bear the burden of supporting it when
other filesystems such as reiserfs (I think?) and ext3 support it
naturally and better than ext2 ever will.

-
