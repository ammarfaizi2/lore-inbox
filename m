Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSJJDgX>; Wed, 9 Oct 2002 23:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263232AbSJJDgW>; Wed, 9 Oct 2002 23:36:22 -0400
Received: from auto-matic.ca ([216.209.85.42]:10247 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S263228AbSJJDgV>;
	Wed, 9 Oct 2002 23:36:21 -0400
Date: Wed, 9 Oct 2002 23:40:57 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Robert Love <rml@tech9.net>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on O_STREAMING (goodby read pauses)
Message-ID: <20021010034057.GC8805@mark.mielke.cc>
References: <20021009222349.GA2353@werewolf.able.es> <1034203433.794.152.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034203433.794.152.camel@phantasy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 06:43:52PM -0400, Robert Love wrote:
> On Wed, 2002-10-09 at 18:23, J.A. Magallon wrote:
> > But I did the test with an addition: read a 1Gb file and print an '*'
> > after every 10M. Without O_STREAMING, when memory fills, the 'progress
> > bar' stalls for a few seconds while pages are sent to disk.
> > So the patch also favours a constant sustained rate of read from the
> > disk. Very interesting for things like video edition and so on.
> > I like it ;).
> This is 100% the point of the patch and hopefully the point I proved
> when I first posted it.

I assume the stall is not 'while pages are sent to disk', but rather
until kswapd gets around to freeing enough pages to allow memory to
fill again. The stall is due to the pages being fully analyzed to
determine which ones should go, and which ones shouldn't. O_STREAMING
removes the pages ahead of time, so no analysis is ever required.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

