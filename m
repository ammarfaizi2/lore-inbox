Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbUCTQ4z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbUCTQ4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:56:54 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35493 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262309AbUCTQ4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:56:52 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
Date: Sat, 20 Mar 2004 18:05:26 +0100
User-Agent: KMail/1.5.3
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040319153554.GC2933@suse.de> <200403201723.11906.bzolnier@elka.pw.edu.pl> <1079800362.11062.280.camel@watt.suse.com>
In-Reply-To: <1079800362.11062.280.camel@watt.suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403201805.26211.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 of March 2004 17:32, Chris Mason wrote:
> On Sat, 2004-03-20 at 11:23, Bartlomiej Zolnierkiewicz wrote:
> > > > - why are we doing pre-flush?
> > >
> > > To ensure previously written data is on platter first.
> >
> > I know this, I want to know what for you are doing this?
> >
> > Previously written data is already acknowledgment to the upper layers so
> > you can't do much even if you hit error on flush cache.  IMO if error
> > happens we should just check if failed sector is of our ordered write if
> > not well report it and continue.  It's cleaner and can give some (small?)
> > performance gain.
>
> The journaled filesystems need this.  We need to make sure that before
> we write the commit block for a transaction, all the previous log blocks
> we're written are safely on media.  Then we also need to make sure the
> commit block is on media.

For low-level driver it shouldn't really matter whether sectors to be
written are the commit block for a transaction or the previous log blocks
and in the current implementation it does matter.

> We end up with a log blocks, pre-flush, commit block, post-flush cycle,
> which is what gives the proper transaction ordering on disk.

Jens, can you explain how this translates to the block layer?
If "log blocks" is a separate request from "commit block",
we can just do: log blocks, flush, commit block, flush cycle.

> For data blocks we only need the post flush, which is why Jens made
> blkdev_issue_flush skip the pre-flush.

Yes.

Thanks,
Bartlomiej

