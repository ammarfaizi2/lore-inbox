Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbUCOEe2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 23:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbUCOEe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 23:34:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:13546 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262250AbUCOEe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 23:34:27 -0500
Date: Sun, 14 Mar 2004 20:34:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04 (linux-2.6.4)
Message-Id: <20040314203427.27857fd9.akpm@osdl.org>
In-Reply-To: <20040315042541.GA31412@MAIL.13thfloor.at>
References: <20040315035506.GB30948@MAIL.13thfloor.at>
	<20040314201457.23fdb96e.akpm@osdl.org>
	<20040315042541.GA31412@MAIL.13thfloor.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> wrote:
>
> On Sun, Mar 14, 2004 at 08:14:57PM -0800, Andrew Morton wrote:
> > Herbert Poetzl <herbert@13thfloor.at> wrote:
> > >
> > >  ; this patch adds some functionality to the --bind
> > >  ; type of vfs mounts.
> > 
> > This won't apply any more.  We very recently changed a large number of
> > filesystems to not call update_atime() from within their readdir functions.
> > That operation was hoisted up to vfs_readdir().
> 
> good decision, very recently probably means in the bk repository,
> is there any link where I could download those changes?

The latest diff against the most-recently-release kernel is always at

	http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/

the topmost link.

> > Also, rather than adding MNT_IS_RDONLY() and having to remember to check
> > both the inode and the mount all over the kernel it would be better to
> > change IS_RDONLY() to take two arguments - the inode and the vfsmnt.  That
> > way we won't miss places, and unconverted code simpy won't compile, thus
> > drawing attention to itself.  I don't know if this is feasible, but please
> > consider it.
> 
> I don't have a problem with that, and it sounds good to me so
> far, so I'll have a look at it, and will update the patch
> accordingly ...

Thanks.
