Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314613AbSEFRvA>; Mon, 6 May 2002 13:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314635AbSEFRvA>; Mon, 6 May 2002 13:51:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60935 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314613AbSEFRu6>;
	Mon, 6 May 2002 13:50:58 -0400
Date: Mon, 6 May 2002 19:50:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Erik Andersen <andersen@codepoet.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "Andre M. Hedrick" <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ for 2.4.19-pre8
Message-ID: <20020506175037.GD1481@suse.de>
In-Reply-To: <20020506134535.GC18817@suse.de> <20020506174101.GB24013@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06 2002, Erik Andersen wrote:
> On Mon May 06, 2002 at 03:45:35PM +0200, Jens Axboe wrote:
> > People who were (rightfully so) afraid to test 2.5 can now play with ide
> > tagged queueing in 2.4. Works great here.
> 
> What sort of behavior changes should I expect to see?  Faster?
> Less CPU utilization?  Are there limited set of controllers and/

I find CPU utilization to be about the same, sometimes a bit more with
TCQ (seems to be due to excessive spinning waiting for BUSY_STAT to
clear after outputting a command (WIN_READMA_QUEUED etc). This will be
the subject of some more investigation.

Streamed reads or writes of 512 byte units is slower with TCQ, by
as much as 20% or so. Approaching 4kb transfers and TCQ catches up, 4kb
and up they are equally fast.

Random reads are somewhat faster, this is the case that we expect to be
faster. Random writes run at the same speed, but that's merely due to
write caching in the non-tcq case. Random access reads show up to 30%
improvement.

> or drives on which this works?

See the configure help entry for known good drives. All controllers
should work, I've tested:

- PIIX4 (various revisions)
- Promise pdc202xx
- AMD 768

others should work as well.

-- 
Jens Axboe

