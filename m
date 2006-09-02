Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWIBELY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWIBELY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 00:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWIBELY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 00:11:24 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:226 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750775AbWIBELW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 00:11:22 -0400
X-Sasl-enc: hqVafMCs+A8YBBvGrYL47c3Wz8CftkO/n/O8ItoUGQRi 1157170281
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060901195009.187af603.akpm@osdl.org>
References: <20060831102127.8fb9a24b.akpm@osdl.org>
	 <20060830135503.98f57ff3.akpm@osdl.org>
	 <20060830125239.6504d71a.akpm@osdl.org>
	 <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	 <27414.1156970238@warthog.cambridge.redhat.com>
	 <9849.1157018310@warthog.cambridge.redhat.com>
	 <9534.1157116114@warthog.cambridge.redhat.com>
	 <20060901093451.87aa486d.akpm@osdl.org>
	 <1157130044.5632.87.camel@localhost>
	 <20060901195009.187af603.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 02 Sep 2006 12:11:12 +0800
Message-Id: <1157170272.3307.5.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 19:50 -0700, Andrew Morton wrote:
> On Fri, 01 Sep 2006 13:00:44 -0400
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > On Fri, 2006-09-01 at 09:34 -0700, Andrew Morton wrote:
> > 
> > > nfs automounter submounts are still broken in Trond's tree, btw.  Are we stuck?
> > 
> > You mean autofs indirect maps?
> 
> I don't know that that is.
> 
> > I'll see if I can't get my hands on an selinux setup like yours in order
> > to do some debugging. AFAICS, the non-selinux case works fine, though.
> 
> It doesn't appear to be related to selinux.
> 
> On a stock, mostly-up-to-date FC5 installation:
> 
> 	echo 0 > /selinux/enforce
> 	service autofs stop
> 	service nfs stop
> 	service nfs start
> 	service autofs start
> 
> 
> sony:/home/akpm> ls -l /net/bix/usr/src
> total 0
> 
> sony:/home/akpm> showmount -e bix
> Export list for bix:
> /           *
> /usr/src    *
> /mnt/export *
> 
> 
> The automounter will mount bix:/ on /net/bix.  But I am unable to get it to
> mount bix's /usr/src on /net/bix/usr/src.

Is it the same symptom as before or is it that bix:/usr/src is not also
being mounted?

> Without git-nfs applied, /net/bix/usr/src mounts as expected.
> 
> iirc, we decided this is related to the fs-cache infrastructure work which
> went into git-nfs.  I think David can reproduce this?

I'll build the latest mm kernel and try to reproduce it.
>From memory I couldn't reproduce it last time I tried.
Is there anything I need to add to rc5-mm1 for this?

Ian



-- 
VGER BF report: H 0
