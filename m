Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280290AbRKEHUg>; Mon, 5 Nov 2001 02:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280291AbRKEHUY>; Mon, 5 Nov 2001 02:20:24 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:8716 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280290AbRKEHTk>; Mon, 5 Nov 2001 02:19:40 -0500
Message-ID: <3BE63C53.135106FC@zip.com.au>
Date: Sun, 04 Nov 2001 23:14:27 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>, <3BE5F5BF.7A249BDF@zip.com.au> <20011104193232.A16679@mikef-linux.matchmail.com> <3BE60B51.968458D3@zip.com.au>,
		<3BE60B51.968458D3@zip.com.au> <20011105080635.D2580@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Sun, Nov 04 2001, Andrew Morton wrote:
> > The meaning of the parameter to elvtune is a complete mystery, and the
> > code is uncommented crud (tautology).  So I just used -r20000 -w20000.
> 
> It's the number of sectors that are allowed to pass a request on the
> queue, because of merges or inserts before that particular request. So
> you want lower than that probably, and you want READ latency to be
> smaller than WRITE latency too. The default I set is 8192/16384 iirc, so
> go lower than this -- -r512 -w1024 or even lower just to check the
> results.

Right, thanks.  With the ialloc.c one-liner I didn't touch
elvtune.  Defaults seem fine.

It should the number of requests which are allowed to pass a
request, not the number of sectors!

Well, you know what I mean:   Make it 

	1 + nr_sectors_in_request / 1000

> > This was based on observing the request queue dynamics.  We frequently
> > fail to merge requests which really should be merged regardless of
> > latency.  Bumping the elvtune settings fixed it all.  But once the
> > fs starts writing data out contiguously it's all academic.
> 
> Interesting, the 2.5 design prevents this since it doesn't account
> merges as a penalty (like a seek). I can do something like that for 2.4
> too, I'll do a patch for you to test.

OK.

-
