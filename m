Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314483AbSE0IT0>; Mon, 27 May 2002 04:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314486AbSE0ITZ>; Mon, 27 May 2002 04:19:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18183 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314483AbSE0ITY>;
	Mon, 27 May 2002 04:19:24 -0400
Message-ID: <3CF1ECD1.A1BB2CF1@zip.com.au>
Date: Mon, 27 May 2002 01:22:41 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: William Lee Irwin III <wli@holomorphy.com>,
        Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org,
        "chen, xiangping" <chen_xiangping@emc.com>
Subject: Re: Poor read performance when sequential write presents
In-Reply-To: <3CED4843.2783B568@zip.com.au> <XFMail.20020524105942.pochini@shiny.it> <3CEE0758.27110CAD@zip.com.au> <20020524094606.GH14918@holomorphy.com> <3CEE1035.1E67E1B8@zip.com.au> <20020527080632.GC17674@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> ...
> > But in 2.5, head-activeness went away and as far as I know, IDE and SCSI are
> > treated the same.  Odd.
> 
> It didn't really go away, it just gets handled automatically now.
> elv_next_request() marks the request as started, in which case the i/o
> scheduler won't consider it for merging etc. SCSI removes the request
> directly after it has been marked started, while IDE leaves it on the
> queue until it completes. For IDE TCQ, the behaviour is the same as with
> SCSI.

It won't consider the active request at the head of the queue for 
merging (making the request larger).  But it _could_ consider the
request when making decisions about insertion (adding a new request
at the head of the queue because it's close-on-disk to the active
one).   Does it do that?

-
