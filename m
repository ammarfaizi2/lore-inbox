Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbUEWQnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUEWQnY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 12:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUEWQnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 12:43:24 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:403 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S263166AbUEWQnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 12:43:21 -0400
From: Lorenzo Allegrucci <l_allegrucci@despammed.com>
Organization: -ENOENT
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.6-mm5 oops mounting ext3 or reiserfs with -o barrier
Date: Sun, 23 May 2004 18:43:56 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200405222107.55505.l_allegrucci@despammed.com> <200405231732.15600.l_allegrucci@despammed.com> <20040523154524.GR1952@suse.de>
In-Reply-To: <20040523154524.GR1952@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405231843.56591.l_allegrucci@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 May 2004 17:45, Jens Axboe wrote:
> On Sun, May 23 2004, Lorenzo Allegrucci wrote:
> > On Sunday 23 May 2004 12:03, Jens Axboe wrote:
> > > Here's a rolled up updated version that tries to get async notification
> > > of missing barrier support working as well. reiser currently doesn't
> > > cope with that correctly (fails mount), ext3 seems to but gets stuck.
> > > Andrew has that fixed already, I think :-)
> > >
> > > Lorenzo, can you test this on top of 2.6.6-mm5?
> >
> > Problem fixed, but there is some performance regression
> >
> > ext3 (default)
> > untar		read		copy		remove
> > 0m53.861s	0m24.942s	1m30.164s	0m20.664s
> > 0m7.132s	0m1.191s	0m0.766s	0m0.076s
> > 0m5.807s	0m3.345s	0m9.996s	0m1.719s
> >
> > ext3 (-o barrier=1)
> > untar		read		copy		remove
> > 0m52.117s	0m28.502s	1m51.153s	0m25.561s
> > 0m7.231s	0m1.209s	0m0.738s	0m0.071s
> > 0m6.117s	0m3.191s	0m9.347s	0m1.635s
>
> Not sure what you mean here

Untar, read, copy and remove the OpenOffice tarball, each test
run with cold cache (mount/umount cycle).

> but yes of course -o barrier=1 is going to 
> be slower than default + write back caching. What you should compare is
> without barrier support and hdparm -W0 /dev/hdX, if -o barrier=1 with
> caching on is slower then that's a regression :-)

hdparm -W0 /dev/hda

ext3 (-o barrier=0)
untar		read		copy		remove
1m55.190s	0m27.633s	2m19.072s	0m21.348s
0m7.081s	0m1.189s	0m0.724s	0m0.083s
0m6.502s	0m3.244s	0m9.715s	0m1.633s

ext3 (-o barrier=1)
untar		read		copy		remove
1m55.358s	0m23.831s	2m16.674s	0m21.508s
0m7.153s	0m1.200s	0m0.748s	0m0.087s
0m6.775s	0m3.358s	0m9.985s	0m1.781s


haparm -W1 /dev/hda

ext3 (-o barrier=0)
untar		read		copy		remove
0m55.405s	0m26.230s	1m28.765s	0m20.766s
0m7.195s	0m1.199s	0m0.773s	0m0.081s
0m6.502s	0m3.359s	0m9.672s	0m1.868s

ext3 (-o barrier=1)
untar		read		copy		remove
0m52.117s	0m28.502s	1m51.153s	0m25.561s
0m7.231s	0m1.209s	0m0.738s	0m0.071s
0m6.117s	0m3.191s	0m9.347s	0m1.635s

-- 
Lorenzo
