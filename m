Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268961AbRHFTjm>; Mon, 6 Aug 2001 15:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268960AbRHFTjc>; Mon, 6 Aug 2001 15:39:32 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:12045 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268959AbRHFTjQ>; Mon, 6 Aug 2001 15:39:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] using writepage to start io
Date: Mon, 6 Aug 2001 21:45:12 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-mm@kvack.org
In-Reply-To: <651080000.997116708@tiny>
In-Reply-To: <651080000.997116708@tiny>
MIME-Version: 1.0
Message-Id: <0108062145120I.00294@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 August 2001 18:51, Chris Mason wrote:
> On Monday, August 06, 2001 06:13:20 PM +0200 Daniel Phillips
>
> <phillips@bonn-fries.net> wrote:
> >> I am saying that it should be possible to have the best buffer
> >> flushed under memory pressure (by kswapd/bdflush) and still get the
> >> old data to disk in time through kupdate.
> >
> > Yes, to phrase this more precisely, after we've submitted all the
> > too-old buffers we then gain the freedom to select which of the
> > younger buffers to flush.
>
> Almost ;-) memory pressure doesn't need to care about how long a
> buffer has been dirty, that's kupdate's job.  kupdate doesn't care if
> the buffer it is writing is a good candidate for freeing, that's taken
> care of elsewhere. The two never need to talk (aside from
> optimizations).

My point is, they should talk, in fact they should be the same function. 
It's never right for bdflush to submit younger buffers when there are 
dirty buffers whose flush time has already passed.

> > I don't see why it makes sense to have both a kupdate and a bdflush
> > thread.
>
> Having two threads is exactly what allows memory pressure to not be
> concerned about how long a buffer has been dirty.

I'm missing something.  How is it impossible for a single thread to act 
this way?

--
Daniel
