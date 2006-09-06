Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWIFK2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWIFK2K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 06:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWIFK2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 06:28:10 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50569 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750787AbWIFK2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 06:28:08 -0400
X-Sasl-enc: G6GU376SKh1CvC+tyESl4SVRWPgIkdcJPORjtRkkEG6t 1157538485
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Ian Kent <raven@themaw.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1157460472.5621.3.camel@localhost>
References: <1157421445.5510.13.camel@localhost>
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
	 <1157376295.3240.13.camel@raven.themaw.net>
	 <4012.1157450226@warthog.cambridge.redhat.com>
	 <1157460472.5621.3.camel@localhost>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 18:27:58 +0800
Message-Id: <1157538478.4050.0.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 08:47 -0400, Trond Myklebust wrote:
> On Tue, 2006-09-05 at 10:57 +0100, David Howells wrote:
> > Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > 
> > > Why the hell is it doing a mkdir in the first place?
> > 
> > I think the problems it is solving are these:
> > 
> >  (1) What happens if "/" is _not_ exported?
> > 
> >  (2) What happens if some intermediate directory (say "/usr") is not
> >      accessible?
> > 
> > 
> > In the first case, the automounter just makes "usr" and "usr/src", say, in the
> > autofs filesystem, and then mounts server:/usr/src on that.
> 
> That is fine. As long as it is doing so in the _autofs_ filesystem. A
> call to 'stat()' should suffice to tell if this is the case.
> 
> > In the second case, the automounter relies on NFS letting it make intervening
> > directories it couldn't otherwise access to span the gap between "/" and
> > "src".
> 
> If the directory isn't accessible, then autofs shouldn't be trying to
> override that. It certainly shouldn't be doing so by trying to create
> the directory.
> 

In the case above the directory is in the autofs filesystem and so needs
to be created.

Ian


