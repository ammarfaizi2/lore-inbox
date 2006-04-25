Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWDYKyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWDYKyE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWDYKyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:54:04 -0400
Received: from [212.33.166.172] ([212.33.166.172]:55309 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932195AbWDYKyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:54:03 -0400
From: Al Boldi <a1426z@gawab.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] Direct I/O bio size regression
Date: Tue, 25 Apr 2006 13:45:01 +0300
User-Agent: KMail/1.5
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       David Chinner <dgc@sgi.com>
References: <200604242006.11758.a1426z@gawab.com> <200604242359.14192.a1426z@gawab.com> <444DD54B.7010908@yahoo.com.au>
In-Reply-To: <444DD54B.7010908@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604251345.01785.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Al Boldi wrote:
> > Jens Axboe wrote:
> >>On Mon, Apr 24 2006, Al Boldi wrote:
> >>>On my system max_hw_sectors_kb is fixed at 1024, and max_sectors_kb
> >>>defaults to 512, which leads to terribly fluctuating thruput.
> >>>
> >>>Setting max_sectors_kb = max_hw_sectors_kb makes things even worse.
> >>>
> >>>Tuning max_sectors_kb to ~192 only stabilizes this situation.
> >>
> >>That sounds pretty strange. Do you have a test case?
> >
> > I would think that, if you could get your hands on some hw that defaults
> > to the same values, you may easily see the same problem by doing this:
> >
> > 1. # vmstat 1 (or some other bio mon)
> > 2. < change vt >
> > 3. # cat /dev/hda > /dev/null &
> > 4. # cat /dev/hda > /dev/null
> > Let this second cat run for a sec, then ^C.
> > Depending on your hw specifics the bio should either go up or down by a
> > factor of 2 (on my system 25mb/s-48mb/s).  You may have to repeat step 4
> > a few times to aggravate the situation.
> >
> > Note that this is not specific to cat, but can also be observed during
> > normal random disk access, although not in a controlled manner.
>
> *random* disk access?
>
> What io scheduler are you using? Can you try with as?

Same w/ deadline, as, and cfq.

Thanks!

--
Al

