Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281124AbRK3Wai>; Fri, 30 Nov 2001 17:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281072AbRK3Wab>; Fri, 30 Nov 2001 17:30:31 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:64153 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S281083AbRK3WaN>;
	Fri, 30 Nov 2001 17:30:13 -0500
Date: Fri, 30 Nov 2001 14:30:11 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] smarter atime updates
Message-ID: <20011130143011.A20179@netnation.com>
In-Reply-To: <20011130145223.Q15936@lynx.no> <Pine.LNX.4.33.0111301349230.1185-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111301349230.1185-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 01:50:21PM -0800, Linus Torvalds wrote:

> On Fri, 30 Nov 2001, Andreas Dilger wrote:
> >
> > Well, just doing a code check of the update_atime() and UPDATE_ATIME()
> > users, and they are all in readlink(), follow_link(), open_namei(),
> > and various fs _readdir() codes.  None of them (AFAICS) depend on the
> > mark_inode_dirty() as a side-effect.  This means it should be safe.
> 
> More importantly, _if_ somebody depended on the side effects, they'd have
> been thwarted by the "noatime" mount option anyway, so any such bug would
> not be a new bug.

I've always thought filesystems should mount with noatime,nodiratime by
default and only actually update atime if specifically mounted with
"atime", as it's so rarely used.  Out of all of the servers here, none
actually use atime (every file system on _every_ server is mounted
noatime,nodiratime).  It's such a waste and just sounds fundamentally
broken to issue a write because somebody read from a file.

...But there's probably some POSIX standard which would make such a
change illegal.  Blah blah...

(Not to say that atime isn't useful, but in most cases where it might be
useful, it is so easily broken by backup processes, etc., that it really
wants to be a different sort of mechanism.)

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
