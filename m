Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280307AbRKEH0g>; Mon, 5 Nov 2001 02:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280306AbRKEH01>; Mon, 5 Nov 2001 02:26:27 -0500
Received: from 117.ppp1-1.hob.worldonline.dk ([212.54.84.117]:18304 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S280305AbRKEH0R>; Mon, 5 Nov 2001 02:26:17 -0500
Date: Mon, 5 Nov 2001 08:26:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <20011105082602.I2580@suse.de>
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>, <3BE5F5BF.7A249BDF@zip.com.au> <20011104193232.A16679@mikef-linux.matchmail.com> <3BE60B51.968458D3@zip.com.au>, <3BE60B51.968458D3@zip.com.au> <20011105080635.D2580@suse.de> <3BE63C53.135106FC@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE63C53.135106FC@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04 2001, Andrew Morton wrote:
> Jens Axboe wrote:
> > 
> > On Sun, Nov 04 2001, Andrew Morton wrote:
> > > The meaning of the parameter to elvtune is a complete mystery, and the
> > > code is uncommented crud (tautology).  So I just used -r20000 -w20000.
> > 
> > It's the number of sectors that are allowed to pass a request on the
> > queue, because of merges or inserts before that particular request. So
> > you want lower than that probably, and you want READ latency to be
> > smaller than WRITE latency too. The default I set is 8192/16384 iirc, so
> > go lower than this -- -r512 -w1024 or even lower just to check the
> > results.
> 
> Right, thanks.  With the ialloc.c one-liner I didn't touch
> elvtune.  Defaults seem fine.
> 
> It should the number of requests which are allowed to pass a
> request, not the number of sectors!
> 
> Well, you know what I mean:   Make it 
> 
> 	1 + nr_sectors_in_request / 1000

That has been tried, performance and latency wasn't good. But yes that
is what we are really looking to account, the number of seeks.
Approximately.

-- 
Jens Axboe

