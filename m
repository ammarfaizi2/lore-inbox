Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280281AbRKEHP0>; Mon, 5 Nov 2001 02:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280286AbRKEHPR>; Mon, 5 Nov 2001 02:15:17 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:41715
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280281AbRKEHO6>; Mon, 5 Nov 2001 02:14:58 -0500
Date: Sun, 4 Nov 2001 23:14:47 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <20011104231447.A17938@mikef-linux.matchmail.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>, <3BE5F5BF.7A249BDF@zip.com.au> <20011104193232.A16679@mikef-linux.matchmail.com> <3BE60B51.968458D3@zip.com.au> <20011105080635.D2580@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011105080635.D2580@suse.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 08:06:35AM +0100, Jens Axboe wrote:
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
>

Does the elevator do better with powers of two?

> > This was based on observing the request queue dynamics.  We frequently
> > fail to merge requests which really should be merged regardless of
> > latency.  Bumping the elvtune settings fixed it all.  But once the
> > fs starts writing data out contiguously it's all academic.
> 
> Interesting, the 2.5 design prevents this since it doesn't account
> merges as a penalty (like a seek). I can do something like that for 2.4
> too, I'll do a patch for you to test.
> 

I'd be very interested in this patch.  Can you post it pubically?

> -- 
> Jens Axboe
> 

Mike
