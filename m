Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264520AbRFTR5n>; Wed, 20 Jun 2001 13:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264522AbRFTR5d>; Wed, 20 Jun 2001 13:57:33 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:40465 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264520AbRFTR50>; Wed, 20 Jun 2001 13:57:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: spindown
Date: Wed, 20 Jun 2001 20:00:22 +0200
X-Mailer: KMail [version 1.2]
Cc: Pavel Machek <pavel@suse.cz>, Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106201407450.1376-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33.0106201407450.1376-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Message-Id: <0106202000220B.00439@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 19:32, Rik van Riel wrote:
> On Wed, 20 Jun 2001, Daniel Phillips wrote:
> > BTW, with nominal 100,000 erases you have to write 10 terabytes
> > to your 100 meg flash disk before you'll see it start to
> > degrade.
>
> That assumes you write out full blocks.  If you flush after
> every byte written you'll hit the limit a lot sooner ;)

Yep, so if you are running on a Yopy, try not to sync after each byte.

> Btw, this is also a problem with your patch, when you write
> out buffers all the time your disk will spend more time seeking
> all over the place (moving the disk head away from where we are
> currently reading!) and you'll end up writing the same block
> multiple times ...

It doesn't work that way, it tacks the flush onto the trailing edge of a 
burst of disk activity, or it flushes out an isolated update, say an edit 
save, which would have required the same amount of disk activity, just a few 
seconds off in the future.  Sometimes it does write a few extra sectors when 
disk activity is sporadic, but the impact on total throughput is small enough 
to be hard to measure reliably.  Even so, there is some optimizing that could 
be done - the update could be interleaved a little better with the falling 
edge of a heavy traffic episode.  This would require that the io rate be 
monitored instead of just the queue backlog.  I'mi nterested in tackling that 
eventually - it has applications in other areas than just the early update.

--
Daniel
