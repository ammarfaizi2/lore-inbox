Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWIBCul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWIBCul (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 22:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWIBCul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 22:50:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27846 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750741AbWIBCuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 22:50:40 -0400
Date: Fri, 1 Sep 2006 19:50:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
       Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
 sharing [try #13]
Message-Id: <20060901195009.187af603.akpm@osdl.org>
In-Reply-To: <1157130044.5632.87.camel@localhost>
References: <20060831102127.8fb9a24b.akpm@osdl.org>
	<20060830135503.98f57ff3.akpm@osdl.org>
	<20060830125239.6504d71a.akpm@osdl.org>
	<20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	<27414.1156970238@warthog.cambridge.redhat.com>
	<9849.1157018310@warthog.cambridge.redhat.com>
	<9534.1157116114@warthog.cambridge.redhat.com>
	<20060901093451.87aa486d.akpm@osdl.org>
	<1157130044.5632.87.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Sep 2006 13:00:44 -0400
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> On Fri, 2006-09-01 at 09:34 -0700, Andrew Morton wrote:
> 
> > nfs automounter submounts are still broken in Trond's tree, btw.  Are we stuck?
> 
> You mean autofs indirect maps?

I don't know that that is.

> I'll see if I can't get my hands on an selinux setup like yours in order
> to do some debugging. AFAICS, the non-selinux case works fine, though.

It doesn't appear to be related to selinux.

On a stock, mostly-up-to-date FC5 installation:

	echo 0 > /selinux/enforce
	service autofs stop
	service nfs stop
	service nfs start
	service autofs start


sony:/home/akpm> ls -l /net/bix/usr/src
total 0

sony:/home/akpm> showmount -e bix
Export list for bix:
/           *
/usr/src    *
/mnt/export *


The automounter will mount bix:/ on /net/bix.  But I am unable to get it to
mount bix's /usr/src on /net/bix/usr/src.

On bix we have

bix:/home/akpm> mount
/dev/sda2 on / type ext3 (rw,noatime)
/dev/sdb1 on /usr/src type ext3 (rw,noatime)
...


Without git-nfs applied, /net/bix/usr/src mounts as expected.

iirc, we decided this is related to the fs-cache infrastructure work which
went into git-nfs.  I think David can reproduce this?

-- 
VGER BF report: H 1.91513e-14
