Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSC1SO0>; Thu, 28 Mar 2002 13:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313204AbSC1SOR>; Thu, 28 Mar 2002 13:14:17 -0500
Received: from quark.didntduck.org ([216.43.55.190]:33805 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S313202AbSC1SOC>; Thu, 28 Mar 2002 13:14:02 -0500
Message-ID: <3CA35D5F.2144AFE6@didntduck.org>
Date: Thu, 28 Mar 2002 13:13:51 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <3CA2C68E.5B8C4176@zip.com.au> <3CA31BF6.7030609@didntduck.org> <3CA3529E.80E70428@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Brian Gerst wrote:
> >
> > Andrew Morton wrote:
> > > In 2.5.7 there is a thinko in the allocation and initialisation
> > > of the fs-private superblock for ext2.  It's passing the wrong type
> > > to the sizeof operator (which of course gives the wrong size)
> > > when allocating and clearing the memory.
> > >
> > > Lesson for the day: this is one of the reasons why this idiom:
> > >
> > >       some_type *p;
> > >
> > >       p = malloc(sizeof(*p));
> > >       ...
> > >       memset(p, 0, sizeof(*p));
> > >
> > > is preferable to
> > >
> > >       some_type *p;
> > >
> > >       p = malloc(sizeof(some_type));
> > >       ...
> > >       memset(p, 0, sizeof(some_type));
> > >
> > > I checked the other filesystems.  They're OK (but idiomatically
> > > impure).  I've added a couple of defensive memsets where
> > > they were missing.
> >
> > I'm not sure I follow you here.  Compiling this code (gcc 2.96):
> >
> > int foo1(void) { return sizeof(struct ext2_sb_info); }
> > int foo2(struct ext2_sb_info *sbi) { return sizeof(*sbi); }
> 
> The current code is using sizeof(ext2_super_block) for
> something which is of type ext2_sb_info.
> 
> The stylistic change tends to provide insulation from the
> above bug.

Doh.  Point taken.

--

				Brian Gerst
