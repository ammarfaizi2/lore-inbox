Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbUCTUIU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 15:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263530AbUCTUIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 15:08:20 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:65473 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263528AbUCTUIR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 15:08:17 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
Date: Sat, 20 Mar 2004 21:16:57 +0100
User-Agent: KMail/1.5.3
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040319153554.GC2933@suse.de> <200403201805.26211.bzolnier@elka.pw.edu.pl> <1079802604.11058.292.camel@watt.suse.com>
In-Reply-To: <1079802604.11058.292.camel@watt.suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403202116.57949.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 of March 2004 18:10, Chris Mason wrote:
> On Sat, 2004-03-20 at 12:05, Bartlomiej Zolnierkiewicz wrote:
> > On Saturday 20 of March 2004 17:32, Chris Mason wrote:
> > > On Sat, 2004-03-20 at 11:23, Bartlomiej Zolnierkiewicz wrote:
> > > > > > - why are we doing pre-flush?
> > >
> > > The journaled filesystems need this.  We need to make sure that before
> > > we write the commit block for a transaction, all the previous log
> > > blocks we're written are safely on media.  Then we also need to make
> > > sure the commit block is on media.
> >
> > For low-level driver it shouldn't really matter whether sectors to be
> > written are the commit block for a transaction or the previous log blocks
> > and in the current implementation it does matter.
>
> As Jens said, it depends on how you define barrier ;-)  I define it as
> this io will be written after all the previous io and before any later
> io.   It was originally written with scsi tags in mind as well, the FS
> side was the same for both.

Yes, thanks for explaining this.

I took a quick look at fs/jbd/ and now I think I understand the way barriers
currently work.  I assume that SCSI handles barriers by ordered tags, right?

> In the end, I'm not that picky though, any reasonable setup that gets
> the blocks on media is fine.

Yep.

Regards,
Bartlomiej

