Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbWIEERq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWIEERq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 00:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbWIEERq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 00:17:46 -0400
Received: from pat.uio.no ([129.240.10.4]:54525 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965146AbWIEERp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 00:17:45 -0400
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1157429474.3915.14.camel@raven.themaw.net>
References: <1157376295.3240.13.camel@raven.themaw.net>
	 <20060901195009.187af603.akpm@osdl.org>
	 <20060831102127.8fb9a24b.akpm@osdl.org>
	 <20060830135503.98f57ff3.akpm@osdl.org>
	 <20060830125239.6504d71a.akpm@osdl.org>
	 <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	 <27414.1156970238@warthog.cambridge.redhat.com>
	 <9849.1157018310@warthog.cambridge.redhat.com>
	 <9534.1157116114@warthog.cambridge.redhat.com>
	 <20060901093451.87aa486d.akpm@osdl.org>
	 <1157130044.5632.87.camel@localhost>
	 <28945.1157370732@warthog.cambridge.redhat.com>
	 <32013.1157377601@warthog.cambridge.redhat.com>
	 <1157429474.3915.14.camel@raven.themaw.net>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 00:17:29 -0400
Message-Id: <1157429849.32412.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.066, required 12,
	autolearn=disabled, AWL 1.93, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 12:11 +0800, Ian Kent wrote:
> On Mon, 2006-09-04 at 14:46 +0100, David Howells wrote:
> > Ian Kent <raven@themaw.net> wrote:
> > 
> > > This is the point I'm trying to make.
> > > I'm able to reproduce this with exports that don't have "nohide".
> > > The mkdir used to return EEXIST, possibly before getting to the EACCES
> > > test. It appears to be a change in semantic behavior and I can't see
> > > where it is coming from. autofs expects an EEXIST but not an EACCES and
> > > so doesn't perform the mount. I could ignore the EACCES but that would
> > > be cheating.
> > 
> > Here's something you can try:  Look in fs/nfs/dir.c.  Find nfs_lookup().  In
> > there, find the following lines:
> > 
> > 	/* If we're doing an exclusive create, optimize away the lookup */
> > 	if (nfs_is_exclusive_create(dir, nd))
> > 		goto no_entry;
> > 
> > Comment that bit out and see what the effect it.
> 
> Yes.
> 
> Commenting this out results in the expected behavior.
> No doubt this is because the following NFS lookup to the server returns
> EEXIST which is then returned to userspace.

It also breaks open(O_EXCL). Removing that is unacceptable.

