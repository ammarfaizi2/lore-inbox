Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbUCUJna (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 04:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbUCUJna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 04:43:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21165 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263601AbUCUJn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 04:43:28 -0500
Date: Sun, 21 Mar 2004 10:43:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Chris Mason <mason@suse.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040321094324.GC1627@suse.de>
References: <20040319153554.GC2933@suse.de> <200403201805.26211.bzolnier@elka.pw.edu.pl> <1079802604.11058.292.camel@watt.suse.com> <200403202116.57949.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403202116.57949.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20 2004, Bartlomiej Zolnierkiewicz wrote:
> On Saturday 20 of March 2004 18:10, Chris Mason wrote:
> > On Sat, 2004-03-20 at 12:05, Bartlomiej Zolnierkiewicz wrote:
> > > On Saturday 20 of March 2004 17:32, Chris Mason wrote:
> > > > On Sat, 2004-03-20 at 11:23, Bartlomiej Zolnierkiewicz wrote:
> > > > > > > - why are we doing pre-flush?
> > > >
> > > > The journaled filesystems need this.  We need to make sure that before
> > > > we write the commit block for a transaction, all the previous log
> > > > blocks we're written are safely on media.  Then we also need to make
> > > > sure the commit block is on media.
> > >
> > > For low-level driver it shouldn't really matter whether sectors to be
> > > written are the commit block for a transaction or the previous log blocks
> > > and in the current implementation it does matter.
> >
> > As Jens said, it depends on how you define barrier ;-)  I define it as
> > this io will be written after all the previous io and before any later
> > io.   It was originally written with scsi tags in mind as well, the FS
> > side was the same for both.
> 
> Yes, thanks for explaining this.
> 
> I took a quick look at fs/jbd/ and now I think I understand the way barriers
> currently work.  I assume that SCSI handles barriers by ordered tags, right?

That's the idea, yes. Needs some SCSI error handling work though, to
always ensure correct ordering.

-- 
Jens Axboe

