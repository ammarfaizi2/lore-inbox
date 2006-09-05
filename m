Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbWIEJ5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWIEJ5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 05:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWIEJ5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 05:57:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9139 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965043AbWIEJ5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 05:57:17 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1157421445.5510.13.camel@localhost> 
References: <1157421445.5510.13.camel@localhost>  <20060901195009.187af603.akpm@osdl.org> <20060831102127.8fb9a24b.akpm@osdl.org> <20060830135503.98f57ff3.akpm@osdl.org> <20060830125239.6504d71a.akpm@osdl.org> <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com> <27414.1156970238@warthog.cambridge.redhat.com> <9849.1157018310@warthog.cambridge.redhat.com> <9534.1157116114@warthog.cambridge.redhat.com> <20060901093451.87aa486d.akpm@osdl.org> <1157130044.5632.87.camel@localhost> <28945.1157370732@warthog.cambridge.redhat.com> <1157376295.3240.13.camel@raven.themaw.net> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, steved@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock sharing [try #13] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 05 Sep 2006 10:57:06 +0100
Message-ID: <4012.1157450226@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> Why the hell is it doing a mkdir in the first place?

I think the problems it is solving are these:

 (1) What happens if "/" is _not_ exported?

 (2) What happens if some intermediate directory (say "/usr") is not
     accessible?


In the first case, the automounter just makes "usr" and "usr/src", say, in the
autofs filesystem, and then mounts server:/usr/src on that.

In the second case, the automounter relies on NFS letting it make intervening
directories it couldn't otherwise access to span the gap between "/" and
"src".

David
