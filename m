Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbVCaAsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVCaAsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 19:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVCaAsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 19:48:37 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:52176 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262514AbVCaAsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 19:48:24 -0500
Date: Thu, 31 Mar 2005 10:42:58 +1000
From: Nathan Scott <nathans@sgi.com>
To: David Malone <dwmalone@maths.tcd.ie>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Directory link count wrapping on Linux/XFS/i386?
Message-ID: <20050331004258.GF867@frodo>
References: <200503302043.aa27223@salmon.maths.tcd.ie> <20050330200601.GG1753@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050330200601.GG1753@schnapps.adilger.int>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 01:06:01PM -0700, Andreas Dilger wrote:
> On Mar 30, 2005  20:43 +0100, David Malone wrote:
> > It seems that internally xfs uses a 32 bit field for the link count,
> > and the stat64 syscalls use a 32 bit field. These fields are copied
> > via the vattr structure in xfs_vnode.h, which uses a nlink_t for
> > the link count. However, in the kernel, I think this field is
> > actually of type __kernel_nlink_t which seems to be 16 bits on many
> > platforms.

Yes, use of nlink_t looks wrong there, thanks.  Theres one/two other
uses of it in XFS as well, I'll audit those.

> The correct fix, used for reiserfs (and a patch for ext3 also) is to
> set i_nlink = 1 in case the filesystem count has wrapped.  When nlink==1
> the fts/find code no longer optimizes subdirectory traversal and checks
> each entries filetype to see if it should recurse.

Ah, I see - the INC_DIR_INODE_NLINK/DEC_DIR_INODE_NLINK macros, right.
I'll look into that too, thanks.

cheers.

-- 
Nathan
