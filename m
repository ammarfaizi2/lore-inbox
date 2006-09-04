Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWIDNrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWIDNrB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWIDNrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:47:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60825 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964939AbWIDNq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:46:58 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1157376295.3240.13.camel@raven.themaw.net> 
References: <1157376295.3240.13.camel@raven.themaw.net>  <20060901195009.187af603.akpm@osdl.org> <20060831102127.8fb9a24b.akpm@osdl.org> <20060830135503.98f57ff3.akpm@osdl.org> <20060830125239.6504d71a.akpm@osdl.org> <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com> <27414.1156970238@warthog.cambridge.redhat.com> <9849.1157018310@warthog.cambridge.redhat.com> <9534.1157116114@warthog.cambridge.redhat.com> <20060901093451.87aa486d.akpm@osdl.org> <1157130044.5632.87.camel@localhost> <28945.1157370732@warthog.cambridge.redhat.com> 
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@osdl.org,
       steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock sharing [try #13] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 04 Sep 2006 14:46:41 +0100
Message-ID: <32013.1157377601@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> This is the point I'm trying to make.
> I'm able to reproduce this with exports that don't have "nohide".
> The mkdir used to return EEXIST, possibly before getting to the EACCES
> test. It appears to be a change in semantic behavior and I can't see
> where it is coming from. autofs expects an EEXIST but not an EACCES and
> so doesn't perform the mount. I could ignore the EACCES but that would
> be cheating.

Here's something you can try:  Look in fs/nfs/dir.c.  Find nfs_lookup().  In
there, find the following lines:

	/* If we're doing an exclusive create, optimize away the lookup */
	if (nfs_is_exclusive_create(dir, nd))
		goto no_entry;

Comment that bit out and see what the effect it.

David
