Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310395AbSCAIiY>; Fri, 1 Mar 2002 03:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310406AbSCAIgc>; Fri, 1 Mar 2002 03:36:32 -0500
Received: from [195.163.186.27] ([195.163.186.27]:38066 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S310401AbSCAIeX>;
	Fri, 1 Mar 2002 03:34:23 -0500
Date: Fri, 1 Mar 2002 10:34:20 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Tim Peeler <timpeeler@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: BUG _llseek kernel 2.4.17
Message-ID: <20020301103420.S23151@mea-ext.zmailer.org>
In-Reply-To: <20020301080327.GA18948@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020301080327.GA18948@comcast.net>; from timpeeler@comcast.net on Fri, Mar 01, 2002 at 03:03:27AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 03:03:27AM -0500, Tim Peeler wrote:
> There is a bug in _llseek (at least that's where I believe it to be)
   Nope.

> in kernel 2.4.17.   I'm using ext3 on an ia32 system.  While pondering
> max file sizes allowed on an ext3 system, I used 'dd' to create a
> fairly large file (8 gigs).  I decided to append to it, so I ran another
> dd to add another 200 megs to it. In telling dd where to seek to before
> appending to the file, i inadvertantly added an extra 0 telling it to
> seek to about 80 _Gigs_, not 8:

   Yes ?  Ever heard of sparse files ?
That is, space is never allocated for the intermediate data blocks,
nor to most of the intermediate metadata indices.

When read, those intermediate blocks will always show blocks filled
with zeros, but as long as you don't actually write them, they won't
consume space.

> I didn't notice what had happended until I checked the size of the file,
> and saw that it was 80 Gigs.   Since my disk is only 9 Gigs, this threw
> me off.  I tried dd several more times including:

  Sure, I have done maximum-file-offset testing on a 200 MB partition,
no problem at all.  (Seek to curpos + 1M, write a few bytes, repeat)
What "du -ak " reported on the file was few hundred kilobytes.  It gives
space consumed by the user data, and the metadata for the indices.

...
> After this careful consideration of the problem in question and
> the apparent area of failure, it seems that fstat is doing its job
> right, just that _llseek setting the position is the culprit.

  Nope.

> Tim

/Matti Aarnio
