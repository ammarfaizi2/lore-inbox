Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWHPNUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWHPNUq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 09:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWHPNUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 09:20:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14486 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750791AbWHPNUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 09:20:46 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1155733108.22077.8.camel@raven.themaw.net> 
References: <1155733108.22077.8.camel@raven.themaw.net>  <30157.1155722439@warthog.cambridge.redhat.com> <29660.1155720852@warthog.cambridge.redhat.com> <20060815114912.d8fa1512.akpm@osdl.org> <20060815104813.7e3a0f98.akpm@osdl.org> <20060815065035.648be867.akpm@osdl.org> <20060814143110.f62bfb01.akpm@osdl.org> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <10791.1155580339@warthog.cambridge.redhat.com> <918.1155635513@warthog.cambridge.redhat.com> <29717.1155662998@warthog.cambridge.redhat.com> <6241.1155666920@warthog.cambridge.redhat.com> <6237.1155731027@warthog.cambridge.redhat.com> 
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 16 Aug 2006 14:20:23 +0100
Message-ID: <19055.1155734423@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> > The negative dentry wouldn't normally be a problem, even though it's
> > attached to its parent directory... except for the small matter that it's
> > subsequently listed in a directory read operation.
> 
> Surely this dentry should also be unhashed at some point.
> Wouldn't that be a sensible result of the failed operation?

Why?  The lookup op succeeded, so obviously there wasn't anything there,
right?

Note that nfs_lookup_revalidate() doesn't cause the dentry to be revalidated
because the mtime on the parent directory hasn't changed.

I'm considering having nfs_readdir_lookup() mark a negative dentry it
encounters as named in a directory listing for explicit revalidation, but I
can't call nfs_mark_for_revalidate() since I don't have an inode.

I think I'll need to add a dentry flag for this purpose.

David
