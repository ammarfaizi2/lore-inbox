Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbUCOXFW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUCOXFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:05:21 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:39375 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262846AbUCOXEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:04:08 -0500
Date: Tue, 16 Mar 2004 00:04:05 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04.1 3/5
Message-ID: <20040315230405.GA19403@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org> <20040315075814.GE31818@MAIL.13thfloor.at> <20040315141004.7b386661.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315141004.7b386661.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 02:10:04PM -0800, Andrew Morton wrote:
> Herbert Poetzl <herbert@13thfloor.at> wrote:
> >
> > --- linux-2.6.4-20040314_2308/fs/ext2/xattr.c	2004-03-11 03:55:34.000000000 +0100
> > +++ linux-2.6.4-20040314_2308-bme0.04.1/fs/ext2/xattr.c	2004-03-15 06:27:13.000000000 +0100
> > @@ -496,7 +496,7 @@ ext2_xattr_set(struct inode *inode, int 
> >  	ea_idebug(inode, "name=%d.%s, value=%p, value_len=%ld",
> >  		  name_index, name, value, (long)value_len);
> >  
> > -	if (IS_RDONLY(inode))
> > +	if (IS_RDONLY_INODE(inode))
> 
> I do think that if we're going to do this thing it should have 100%
> coverage, and not have little exceptions because the volume of changes got
> too high.
> 
> The number of places where you need IS_RDONLY_INODE() are encouragingly
> small.  It appears that all we need to do to get rid of it is to propagate
> the file* down through the ext2 and ext3 xattr code.  A NULL value will
> need to be permitted because ext2_new_inode doesn't have a file*, and we've
> already performed the check.

I'm not sure we actually want to do this, but I'll
try ... seems to go up all the way to the syscall entry.

> Sure, it's a largeish patch but it is very safe: if it compiles, it works.

agreed.

> Could you please work that with Andreas?

sure, Andreas who?

> IS_RDONLY_INODE() is also used in intermezzo, but that doesn't compile any
> more anyway.

so I do not bother with that, but what about the nfs(d)
stuff? 

TIA,
Herbert

