Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTFJROc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 13:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTFJROc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 13:14:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29579 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263637AbTFJROb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 13:14:31 -0400
Date: Tue, 10 Jun 2003 19:28:11 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE Power Management, try 2
Message-ID: <20030610172811.GI17164@suse.de>
References: <1055262472.705.21.camel@gaston> <Pine.SOL.4.30.0306101832350.24343-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0306101832350.24343-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> On 10 Jun 2003, Benjamin Herrenschmidt wrote:
> 
> > On Tue, 2003-06-10 at 18:15, Jens Axboe wrote:
> > > On Thu, Jun 05 2003, Bartlomiej Zolnierkiewicz wrote:
> > > > Jens, I think generic version of ide_do_drive_cmd() would be useful for
> > > > other block devices, what do you think?
> > >
> > > Something ala this? Completely untested, and I only did scsi_ioctl.c and
> > > ide-io.c. iirc, scsi uses somthing similar that could be adapted too.
> >
> > Hrm... you didn't keep some functionalities I added with the PM
> > patch here... like marking of preempt requests so I can fetch them
> > even when drive is blocked, and ide_head_wait...
> >
> > Ben
> 
> I've looked for users of ide_preempt in drivers/ide/ and I think
> that REQ_PREEMPT can later die if we fix drivers to correctly mark
> sense requests with REQ_SENSE...

Indeed, besides preempt is not really something you can do completely
in the block layer safely. So I'd rather kill that logic.

-- 
Jens Axboe

