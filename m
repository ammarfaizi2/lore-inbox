Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUCOHzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 02:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUCOHzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 02:55:21 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:61646 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262026AbUCOHzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 02:55:15 -0500
Date: Mon, 15 Mar 2004 08:55:13 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04 (linux-2.6.4)
Message-ID: <20040315075513.GB31818@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314203427.27857fd9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 08:34:27PM -0800, Andrew Morton wrote:
> Herbert Poetzl <herbert@13thfloor.at> wrote:
> > On Sun, Mar 14, 2004 at 08:14:57PM -0800, Andrew Morton wrote:
> > > 
> > > This won't apply any more.  We very recently changed a large 
> > > number of filesystems to not call update_atime() from within 
> > > their readdir functions.
> > > That operation was hoisted up to vfs_readdir().

okay, patches do reflect this change now ...

> > > Also, rather than adding MNT_IS_RDONLY() and having to 
> > > remember to check both the inode and the mount all over 
> > > the kernel it would be better to change IS_RDONLY() to 
> > > take two arguments - the inode and the vfsmnt.  That
> > > way we won't miss places, and unconverted code simpy 
> > > won't compile, thus drawing attention to itself.  
> > > I don't know if this is feasible, but please consider it.

I decided to split this up into five parts, a simple base
patch, a patch doing the noatime stuff, and three patches
for the IS_RDONLY changes ...

bme0.04.1-ro1 ... are the completely resolved ones
bme0.04.1-ro2 ... acl stuff, needs checking for nd
bme0.04.1-ro3 ... unresolved/legacy

currently I do not know where to get the vfsmnt for the
cases in bme0.04.1-ro3, so they use the legacy define
IS_RDONLY_INODE() for their checks ...

I hope this is what you had in mind, but anyways, let me
know how to proceed ...

best,
Herbert

PS: basic functionality has been verified.

http://www.13thfloor.at/patches/patch-2.6.4-20040314_2308-bme0.04.1.diff
http://www.13thfloor.at/patches/patch-2.6.4-20040314_2308-bme0.04.1-atime.diff
http://www.13thfloor.at/patches/patch-2.6.4-20040314_2308-bme0.04.1-ro1.diff
http://www.13thfloor.at/patches/patch-2.6.4-20040314_2308-bme0.04.1-ro2.diff
http://www.13thfloor.at/patches/patch-2.6.4-20040314_2308-bme0.04.1-ro3.diff

