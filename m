Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbTDWXuo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264327AbTDWXun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:50:43 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:15051 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264325AbTDWXue
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:50:34 -0400
Date: Thu, 24 Apr 2003 02:02:15 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrew Morton <akpm@digeo.com>
cc: Andries Brouwer <aebr@win.tue.nl>, <alan@lxorguk.ukuu.org.uk>,
       <andre@linux-ide.org>, <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (0/4)
In-Reply-To: <20030423162041.1b7ee5b3.akpm@digeo.com>
Message-ID: <Pine.SOL.4.30.0304240142580.22047-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Apr 2003, Andrew Morton wrote:

> Andries Brouwer <aebr@win.tue.nl> wrote:
> >
> > On Wed, Apr 23, 2003 at 03:35:00PM -0700, Andrew Morton wrote:
> >
> > > What is special about the IDE ioctl approach?
> >
> > Usually one wants to use the standard commands for I/O.
> > But if the purpose is to talk to the drive (set password,
> > set native max, eject, change ZIP drive from big floppy
> > mode to removable disk mode, etc. etc.) then one needs
> > a means to execute IDE commands "by hand".
>
> Yes, but none of these are performance-critical and they don't involve
> large amnounts of data.  A copy is OK.

low-level benchmarking is somehow performance critical :-)

note that direct-IO here is _only_ bonus, main goal is to
use the same code for _all_ ioctl and fs generated IDE IO
(remember that all fs IDE IO is rq->bio based)

and this is work-in-progress...

> If all the rework against bio_map_user() and friends is needed for other
> reasons then fine.  But it doesn't seem to be needed for the IDE taskfile
> ioctl.

Rework of bio_map_user() and co. is minimal and not needed but otherwise
I will have to duplicate same code in 4 places. bio_map_user() now does
allocated bio checking and grabs extra reference to bio which all users of
old bio_map_user() have to do anyway (and they will probably forgot to).



