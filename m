Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWDXVBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWDXVBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWDXVBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:01:10 -0400
Received: from [212.33.162.202] ([212.33.162.202]:25101 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751198AbWDXVBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:01:09 -0400
From: Al Boldi <a1426z@gawab.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Direct I/O bio size regression
Date: Mon, 24 Apr 2006 23:59:13 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, David Chinner <dgc@sgi.com>
References: <200604242006.11758.a1426z@gawab.com> <20060424194910.GK29724@suse.de>
In-Reply-To: <20060424194910.GK29724@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604242359.14192.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Apr 24 2006, Al Boldi wrote:
> > On my system max_hw_sectors_kb is fixed at 1024, and max_sectors_kb
> > defaults to 512, which leads to terribly fluctuating thruput.
> >
> > Setting max_sectors_kb = max_hw_sectors_kb makes things even worse.
> >
> > Tuning max_sectors_kb to ~192 only stabilizes this situation.
>
> That sounds pretty strange. Do you have a test case?

I would think that, if you could get your hands on some hw that defaults to 
the same values, you may easily see the same problem by doing this:

1. # vmstat 1 (or some other bio mon)
2. < change vt >
3. # cat /dev/hda > /dev/null &
4. # cat /dev/hda > /dev/null
Let this second cat run for a sec, then ^C.
Depending on your hw specifics the bio should either go up or down by a 
factor of 2 (on my system 25mb/s-48mb/s).  You may have to repeat step 4 a 
few times to aggravate the situation.

Note that this is not specific to cat, but can also be observed during normal 
random disk access, although not in a controlled manner.

Setting max_sectors_kb to ~192 seems to inhibit this problem.

Thanks!

--
Al





