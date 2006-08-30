Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750696AbWH3IjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbWH3IjC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 04:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750699AbWH3IjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 04:39:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44228 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750696AbWH3IjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 04:39:00 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060829122851.690e5219.akpm@osdl.org> 
References: <20060829122851.690e5219.akpm@osdl.org>  <20060829112030.a2a8c763.akpm@osdl.org> <20060829175949.32281.21374.stgit@warthog.cambridge.redhat.com> <1082.1156876794@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 1/2] NOMMU: Set BDI capabilities for /dev/mem and /dev/kmem 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 30 Aug 2006 09:38:42 +0100
Message-ID: <19020.1156927122@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Or you could use the approach I suggested, like wot everyone else does.

Ummm...  I don't recall ever coming across a construct like that in the
kernel.  That's not to say there isn't one, but if I did come across it, it
can't have been clear.

I have seen the use #ifdefs to selectively fill in an ops structure.  Take
Ext3 for example:

	struct inode_operations ext3_file_inode_operations = {
		.truncate	= ext3_truncate,
		.setattr	= ext3_setattr,
	#ifdef CONFIG_EXT3_FS_XATTR
		.setxattr	= generic_setxattr,
		.getxattr	= generic_getxattr,
		.listxattr	= ext3_listxattr,
		.removexattr	= generic_removexattr,
	#endif
		.permission	= ext3_permission,
	};

So, no, _not_ everyone else follows your suggestion.  This example makes it
instantly clear to anyone looking at it that those four ops are only used if
Ext3 is configured to use xattrs.  Anything else lacks clarity.

> > Is doing a private mapping of /dev/mem a valid thing to do anyway, even if
> > there is an MMU?
> 
> It would be strange, I guess.  But the important thing is to not change
> behaviour.

Yeah, okay.

David
