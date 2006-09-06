Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWIFJwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWIFJwQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 05:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWIFJwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 05:52:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61638 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750753AbWIFJwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 05:52:14 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1157518718.3066.22.camel@raven.themaw.net> 
References: <1157518718.3066.22.camel@raven.themaw.net>  <1157458817.4133.29.camel@raven.themaw.net> <1157451611.4133.22.camel@raven.themaw.net> <1157436412.3915.26.camel@raven.themaw.net> <20060901195009.187af603.akpm@osdl.org> <20060831102127.8fb9a24b.akpm@osdl.org> <20060830135503.98f57ff3.akpm@osdl.org> <20060830125239.6504d71a.akpm@osdl.org> <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com> <27414.1156970238@warthog.cambridge.redhat.com> <9849.1157018310@warthog.cambridge.redhat.com> <9534.1157116114@warthog.cambridge.redhat.com> <20060901093451.87aa486d.akpm@osdl.org> <1157130044.5632.87.camel@localhost> <28945.1157370732@warthog.cambridge.redhat.com> <1157376295.3240.13.camel@raven.themaw.net> <1157421445.5510.13.camel@localhost> <1157424937.3002.4.camel@raven.themaw.net> <1157428241.5510.72.camel@localhost> <1157429030.3915.8.camel@raven.themaw.net> <1157432039.32412.37.camel@localhost> <3698.1157449249@warthog.cambridge.redhat.com> <4987.1157452656@war!
 thog.cambridge.redhat.com> <11346.1157463522@warthog.cambridge.redhat.com> 
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, steved@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock sharing [try #13] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 06 Sep 2006 10:51:46 +0100
Message-ID: <8912.1157536306@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> > Not if you've already caused the NFS filesystem to create a "dummy" dentry
> > that's a directory because you couldn't see that what that name
> > corresponds to on the server is actually a symlink.
> 
> Shouldn't stat tell me if this is a symlink?

You may not be able to find out from the server what it is you're trying to
deal with because you may not have permission to do so, or because whatever it
is may not be exported.  The first may be the trickiest to deal with because
the MOUNT service for NFS2 and NFS3 can jump you over bits of the path you
can't otherwise access.

The problem actually comes when the conditions on the server change; perhaps an
intermediate directory is made accessible on the server and suddenly the client
can see inside of it.  It may then find out that what it had assumed to be
directories, and what it had set dummy directory dentries up for, aren't.

David
