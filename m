Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbWFTLps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWFTLps (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWFTLps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:45:48 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:33962 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965016AbWFTLpr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:45:47 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Steven Whitehouse <steve@chygwyn.com>
Subject: Re: [RFC] [PATCH 1/8] inode_diet: Replace inode.u.generic_ip with inode.i_private
Date: Tue, 20 Jun 2006 13:45:45 +0200
User-Agent: KMail/1.9.1
Cc: Theodore Tso <tytso@thunk.org>, linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153108.418349000@candygram.thunk.org> <1150796596.3856.1333.camel@quoit.chygwyn.com>
In-Reply-To: <1150796596.3856.1333.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606201345.45332.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 June 2006 11:43, Steven Whitehouse wrote:
> As a further suggestion, I wonder do we really need i_private at all?
> Since we have sb->s_op->alloc_inode and inode->i_sb->s_op->destroy_inode
> if all filesystems did something along the following lines:
> 
> struct myfs_inode {
>         struct inode i_inode;
>         ...
> };
> 
> #define MYFS_I(inode) container_of((inode), struct myfs_inode, i_inode)
> 
> then it would seem that i_private is redundant. If there is a file
> system which does genuinely need a pointer here (if indeed such a
> filesystem does exist, I haven't actually checked that) then a pointer
> can just be added as the one single other member of (in my example)
> struct myfs_inode.
> 
That would mean that all file systems need to implement ->alloc_inode,
which in turn need slab caches that eat consume memory even when
the file system is not mounted.

Something as simple as nfsctl or devpts should not need that.

	Arnd <><
