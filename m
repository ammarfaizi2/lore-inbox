Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTHZSjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 14:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbTHZSjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 14:39:17 -0400
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:31202 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id S262115AbTHZSjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 14:39:13 -0400
Date: Tue, 26 Aug 2003 11:50:44 -0400
From: Arvind Sankar <arvinds@MIT.EDU>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vesafb mtrr setup question
Message-ID: <20030826155044.GA27105@m66-080-18.mit.edu>
References: <20030825194304.GA14893@m66-080-17.mit.edu> <1061912542.20846.50.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061912542.20846.50.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 04:42:23PM +0100, Alan Cox wrote:
> On Llu, 2003-08-25 at 20:43, Arvind Sankar wrote:
> > In the first place, the power of two computation computes the largest
> > power of 2 that is _smaller_ than video_size, so it looks like an
> > off-by-1 bug.
> 
> Not a bug - we don't know what lives above it so we can't extend the
> mtrr safely
> 
Ah. On a side not, could you drop a quick hint as to how
screen_info.lfb_size is obtained?

In older (or just different?) versions of vesafb, the video_size was
actually computed by multiplying xres, yres, and the bpp.

> > >         /* Try and find a power of two to add */
> > >         while (temp_size && mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB, 1)==-EINVAL) {
> > >                 temp_size >>= 1;
> > >         }
> > > }
> > 
> > Secondly, what's the point of requesting a smaller write-combining
> > segment that won't cover all the video memory being used?
> 
> Generally we don't use all the videoram. Its a heuristic rather than
> perfection. You might want to play with improvements
> 

I thought the yres_virtual was computed based on how much video_ram was
being used, so all of it _is_ being used, for scrollback?

-- arvind
