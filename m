Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTDXGnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 02:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTDXGnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 02:43:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3534 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261706AbTDXGnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 02:43:11 -0400
Date: Thu, 24 Apr 2003 08:55:01 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andrew Morton <akpm@digeo.com>, Andries Brouwer <aebr@win.tue.nl>,
       alan@lxorguk.ukuu.org.uk, andre@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (0/4)
Message-ID: <20030424065501.GB8775@suse.de>
References: <20030423162041.1b7ee5b3.akpm@digeo.com> <Pine.SOL.4.30.0304240142580.22047-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0304240142580.22047-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24 2003, Bartlomiej Zolnierkiewicz wrote:
> > If all the rework against bio_map_user() and friends is needed for other
> > reasons then fine.  But it doesn't seem to be needed for the IDE taskfile
> > ioctl.
> 
> Rework of bio_map_user() and co. is minimal and not needed but otherwise
> I will have to duplicate same code in 4 places. bio_map_user() now does
> allocated bio checking and grabs extra reference to bio which all users of
> old bio_map_user() have to do anyway (and they will probably forgot to).

The bio_map_user() changes look perfectly fine, I'd like to commit those
separately.

>From the performance point of view, I agree that the whole thing is
rather silly (I mean, who cares?). But the non-allocating nature of
HDIO_DRIVE_TASK is a step in the right direction.

-- 
Jens Axboe

