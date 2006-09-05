Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWIEKhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWIEKhs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 06:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWIEKhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 06:37:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57291 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751305AbWIEKhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 06:37:47 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1157451611.4133.22.camel@raven.themaw.net> 
References: <1157451611.4133.22.camel@raven.themaw.net>  <1157436412.3915.26.camel@raven.themaw.net> <20060901195009.187af603.akpm@osdl.org> <20060831102127.8fb9a24b.akpm@osdl.org> <20060830135503.98f57ff3.akpm@osdl.org> <20060830125239.6504d71a.akpm@osdl.org> <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com> <27414.1156970238@warthog.cambridge.redhat.com> <9849.1157018310@warthog.cambridge.redhat.com> <9534.1157116114@warthog.cambridge.redhat.com> <20060901093451.87aa486d.akpm@osdl.org> <1157130044.5632.87.camel@localhost> <28945.1157370732@warthog.cambridge.redhat.com> <1157376295.3240.13.camel@raven.themaw.net> <1157421445.5510.13.camel@localhost> <1157424937.3002.4.camel@raven.themaw.net> <1157428241.5510.72.camel@localhost> <1157429030.3915.8.camel@raven.themaw.net> <1157432039.32412.37.camel@localhost> <3698.1157449249@warthog.cambridge.redhat.com> 
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, steved@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock sharing [try #13] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 05 Sep 2006 11:37:36 +0100
Message-ID: <4987.1157452656@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> > As long as you don't rely on stat...mkdir working.  That can go wrong if the
> > dentry gets booted from the dcache by memory pressure in the "...".
> 
> I'm not clear on your point here.

I was wondering if you were going to rely on stat() forcing the dentry to be
correctly initialised before you did mkdir(), but it seems not.

> If I stat a path and it exists then all is good and I'm done.
> If I stat a path and I get something other than ENOENT then all is bad
> and I return fail.
> Otherwise I can just attempt to create the directory and fail if all is
> bad with that.

Okay, I suppose.  But that still doesn't seem to deal with the case of creating
a directory on the client that then overlays a symlink on the server that you
can't yet access.

You may also get ENOENT because you stat a symlink, though you'll get EEXIST
from mkdir, even if there's nothing at the far end.

David
