Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318792AbSHLTk1>; Mon, 12 Aug 2002 15:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318798AbSHLTk1>; Mon, 12 Aug 2002 15:40:27 -0400
Received: from mons.uio.no ([129.240.130.14]:17554 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S318792AbSHLTk1>;
	Mon, 12 Aug 2002 15:40:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15704.4092.969062.891558@charged.uio.no>
Date: Mon, 12 Aug 2002 21:43:56 +0200
To: Andrew Morton <akpm@zip.com.au>
Cc: Simon Kirby <sim@netnation.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <3D57594B.C56A1932@zip.com.au>
References: <20020811031705.GA13878@netnation.com>
	<Pine.LNX.4.44.0208111121510.9930-100000@home.transmeta.com>
	<3D572B4C.90F4AF3C@zip.com.au>
	<20020812062039.GA29420@netnation.com>
	<3D57594B.C56A1932@zip.com.au>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@zip.com.au> writes:

     > Simon Kirby wrote:
    >>
    >> On Sun, Aug 11, 2002 at 08:28:12PM -0700, Andrew Morton wrote:
    >>
    >> > So I'd appreciate it if Simon could invetigate a little
    >> > further with the test app I posted.  Something is up, and it
    >> > may not be just an NFS thing.  But note that nfs_readpage
    >> > will go synchronous if rsize is less than PAGE_CACHE_SIZE, so
    >> > it has to be set up right.
    >>
    >> You're right -- my NFS page size is set to 2048.  I can't
    >> remember if I did this because I was trying to work around huge
    >> read-ahead or because I was trying to work around the bursts of
    >> high latency from my Terayon cable modem (which idles at a slow
    >> line speed and "falls forward" to higher speeds once it detects
    >> traffic, but with a delay, causing awful latency at the expense
    >> of "better noise immunity").  Anyway, I will test this
    >> tomorrow.  I recall that 1024 byte-sized blocks were too small
    >> because the latency of the cable modem would cause it to not
    >> have high enough throughput, so I settled with 2048.

     > OK, thanks.

Sorry if somebody already covered this (I'm still a bit jetlagged so I
may have missed part of the argument) but if the read is synchronous,
why should we care about doing readahead at all?

Wasn't the 2.4.x code designed so that you first scheduled the read
for the page you are interested in, and only if the page was not
immediately made available would you then schedule some readahead?

Cheers,
  Trond
