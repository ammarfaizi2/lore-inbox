Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265329AbSJXGVU>; Thu, 24 Oct 2002 02:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265330AbSJXGVU>; Thu, 24 Oct 2002 02:21:20 -0400
Received: from zok.sgi.com ([204.94.215.101]:54659 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S265329AbSJXGVT>;
	Thu, 24 Oct 2002 02:21:19 -0400
Date: Thu, 24 Oct 2002 16:26:02 +1000
From: Nathan Scott <nathans@sgi.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Russell Coker <russell@coker.com.au>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021024062602.GD937@frodo>
References: <20021023173635.A15896@infradead.org> <Pine.GSO.4.33.0210231241300.7042-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0210231241300.7042-100000@raven>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Oct 23, 2002 at 12:51:08PM -0400, Stephen Smalley wrote:
> > Why are you limited to a single fs?  xfs and jfs have xattr support
> > out of the box (in 2.4 only jfs is actually in the mainline tree, though)
> 
> Most of our users (and we) happen to use ext[23], so there isn't any point
> in migrating SELinux to using EAs until EA implementations are merged into
> those filesystems.  Also, the EA API lacks support for creating files with
> specified security attributes (as opposed to creating and then calling
> setxattr to change the attributes, possibly after someone has already
> obtained access to the file), so it isn't ideal for our purposes anyway.

This is not a shortcoming of the xattr interfaces, they do what
they were designed to do.  I think the only interfaces suited to
setting up things in the way you've described are create, mkdir,
mknod, and co.  It isn't clear to me how sys_security helps in
this situation? -- it would also seem to be non-atomic wrt the
inode creation syscalls, in the same way the xattr calls are.

The ACL code has to address a similar problem to the one you've
described - if a directory has a default ACL set on it, then new
children must be created with that ACL.  This is implemented by
giving filesystems knowledge of the semantics of this attribute,
and having them create the ACL along with the inode if need be.

cheers.

-- 
Nathan
