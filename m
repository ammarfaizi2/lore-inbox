Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbUCTRHm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 12:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263481AbUCTRHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 12:07:42 -0500
Received: from ns.suse.de ([195.135.220.2]:21383 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263480AbUCTRHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 12:07:40 -0500
Subject: Re: [PATCH] barrier patch set
From: Chris Mason <mason@suse.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200403201805.26211.bzolnier@elka.pw.edu.pl>
References: <20040319153554.GC2933@suse.de>
	 <200403201723.11906.bzolnier@elka.pw.edu.pl>
	 <1079800362.11062.280.camel@watt.suse.com>
	 <200403201805.26211.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1079802604.11058.292.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 20 Mar 2004 12:10:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-20 at 12:05, Bartlomiej Zolnierkiewicz wrote:
> On Saturday 20 of March 2004 17:32, Chris Mason wrote:
> > On Sat, 2004-03-20 at 11:23, Bartlomiej Zolnierkiewicz wrote:
> > > > > - why are we doing pre-flush?
> > The journaled filesystems need this.  We need to make sure that before
> > we write the commit block for a transaction, all the previous log blocks
> > we're written are safely on media.  Then we also need to make sure the
> > commit block is on media.
> 
> For low-level driver it shouldn't really matter whether sectors to be
> written are the commit block for a transaction or the previous log blocks
> and in the current implementation it does matter.
> 
As Jens said, it depends on how you define barrier ;-)  I define it as
this io will be written after all the previous io and before any later
io.   It was originally written with scsi tags in mind as well, the FS
side was the same for both.

In the end, I'm not that picky though, any reasonable setup that gets
the blocks on media is fine.

-chris


