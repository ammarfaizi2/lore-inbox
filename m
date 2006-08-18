Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWHRJJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWHRJJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWHRJJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:09:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3798 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750795AbWHRJJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:09:33 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3930.1155816809@warthog.cambridge.redhat.com> 
References: <3930.1155816809@warthog.cambridge.redhat.com>  <20060817004219.44c45bbd.akpm@osdl.org> <1155743399.5683.13.camel@localhost> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <5910.1155741329@warthog.cambridge.redhat.com> <13319.1155744959@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com,
       Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's list 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 18 Aug 2006 10:09:21 +0100
Message-ID: <626.1155892161@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > VFS: Busy inodes after unmount of 0:15. Self-destruct in 5 seconds.  Have a
> > nice day...
> 
> Sigh.
> 
> Guess what?  I don't see that...

I wonder...  I think I forgot to turn SELinux enforcing back on when testing
it.  Now that I do that, I see:

	BUG: Dentry c5294c08{i=0,n=mnt} still in use (1) [unmount of nfs 0:14]
	------------[ cut here ]------------
	kernel BUG at fs/dcache.c:611!

I think Ian's right, I think I've forgotten a dput(), though why you see the
busy inodes message and not the above bug, I'm not sure.

David
