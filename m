Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUEWRRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUEWRRV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 13:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUEWRRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 13:17:21 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:5812 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262020AbUEWRRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 13:17:18 -0400
From: Lorenzo Allegrucci <l_allegrucci@despammed.com>
Organization: -ENOENT
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.6-mm5 oops mounting ext3 or reiserfs with -o barrier
Date: Sun, 23 May 2004 19:17:52 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200405222107.55505.l_allegrucci@despammed.com> <200405231843.56591.l_allegrucci@despammed.com> <20040523165634.GS1952@suse.de>
In-Reply-To: <20040523165634.GS1952@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405231917.52517.l_allegrucci@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 May 2004 18:56, Jens Axboe wrote:

> > Untar, read, copy and remove the OpenOffice tarball, each test
> > run with cold cache (mount/umount cycle).
>
> I understand that, I just don't see how you can call it a regression.
> It's a given that barrier will be slower.

I'm sorry, I didn't know :)

I read from www.kerneltrap.org:

Request barriers, also known as write barriers, provide a mechanism for 
guaranteeing the order of disk I/O operations without actually waiting for 
the data to be written to disk. Specifically, a request barrier guarantees 
that any data queued up prior to the the barrier will be written to disk 
before data queued up after the barrier. Without a request barrier, the block 
layer can reorder how data is written to disk for maximum performance. The 
problem with this being most notably with journaling filesystems which 
require that their metadata be updated prior to actually updating data, 
allowing true crash recovery. Without request barriers, a journaling 
filesystem has to wait for the metadata change to be written to disk before 
it can proceed with actually updating the filesystem. Hence, the addition of 
request barriers provides a performance boost for journaled filesystems. In 
-mm5, request barriers are enabled by default for reiserfs and ext3.

> > > but yes of course -o barrier=1 is going to
> > > be slower than default + write back caching. What you should compare is
> > > without barrier support and hdparm -W0 /dev/hdX, if -o barrier=1 with
> > > caching on is slower then that's a regression :-)
> >
> > hdparm -W0 /dev/hda
> >
> > ext3 (-o barrier=0)
> > untar		read		copy		remove
> > 1m55.190s	0m27.633s	2m19.072s	0m21.348s
> > 0m7.081s	0m1.189s	0m0.724s	0m0.083s
> > 0m6.502s	0m3.244s	0m9.715s	0m1.633s
> >
> > ext3 (-o barrier=1)
> > untar		read		copy		remove
> > 1m55.358s	0m23.831s	2m16.674s	0m21.508s
> > 0m7.153s	0m1.200s	0m0.748s	0m0.087s
> > 0m6.775s	0m3.358s	0m9.985s	0m1.781s
> >
> >
> > haparm -W1 /dev/hda
> >
> > ext3 (-o barrier=0)
> > untar		read		copy		remove
> > 0m55.405s	0m26.230s	1m28.765s	0m20.766s
> > 0m7.195s	0m1.199s	0m0.773s	0m0.081s
> > 0m6.502s	0m3.359s	0m9.672s	0m1.868s
> >
> > ext3 (-o barrier=1)
> > untar		read		copy		remove
> > 0m52.117s	0m28.502s	1m51.153s	0m25.561s
> > 0m7.231s	0m1.209s	0m0.738s	0m0.071s
> > 0m6.117s	0m3.191s	0m9.347s	0m1.635s
>
> Your results look a bit over the map, how many runs are your averaging
> for each one?

Just one run, no averaging.
Yes, it's not a scientific approach, but I have not enough time
and this is my production machine :)
By experience I can say that numbers between each run are quite
stable and reproducible.

-- 
Lorenzo
