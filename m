Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268453AbTGIRNk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 13:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268454AbTGIRNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 13:13:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:41693 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S268453AbTGIRNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 13:13:11 -0400
Date: Wed, 9 Jul 2003 14:24:43 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Christoph Hellwig <hch@infradead.org>, marcelo@connectiva.com.br,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: ->direct_IO API change in current 2.4 BK
In-Reply-To: <20030709100336.H4482@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.55L.0307091421070.26373@freak.distro.conectiva>
References: <20030709133109.A23587@infradead.org> <20030709100336.H4482@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Jul 2003, Andreas Dilger wrote:

> On Jul 09, 2003  13:31 +0100, Christoph Hellwig wrote:
> > I just got a nice XFS oops due to the direct_IO API change in
> > 2.4.  Guys, this is a STABLE series and APIs are supposed to be exactly
> > that, _STABLE_.  If you really think O_DIRECT on NFS is soo important
> > please add a ->direct_IO2 for NFS like the reiserfs read_inode2 hack.
>
> I would have to agree with that sentiment - we shouldn't change the
> API in an "almost compatible" way, although I would have hoped that
> compile warnings and/or module symbol versioning would have avoided
> a crash.
>
> > But what's the use of it anyway?  AFAIK it's mostly for whoracle setups
> > that have their data on netapps but that needs a certified vendor kernel
> > not mainline..
>
> Actually, it is useful for Lustre to do this, because it allows us to have
> a file handle (which, naturally, holds per-file data) at the time the IO is
> sent over the wire, instead of the "anonymous" writes that happen now.
> This helps us with readahead on the server and other minor improvements.

Fine, I agree. Trond, I'll have to revert your direct IO patches because
they break the _stable_ API, indeed.

Please come up with another solution for the problem (->direct_IO2 ? its
ugly, but...).
