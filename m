Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbUDPUfR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbUDPUex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:34:53 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:35846 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263782AbUDPUeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:34:21 -0400
Date: Fri, 16 Apr 2004 21:34:17 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Timothy Miller <miller@techsource.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb broken
In-Reply-To: <40800213.8010106@techsource.com>
Message-ID: <Pine.LNX.4.44.0404162134060.9917-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the fix.


On Fri, 16 Apr 2004, Timothy Miller wrote:

> 
> Andrew Morton asked me to repost the patch for the Radeon FB off-by-one 
> bug.  I'll see about making a proper patch when I get home, but if you 
> want to fix it quicker, I'll just tell you what to change.
> 
> 
> In the druvers/video/radeonfb.c, there is a function called 
> fbcon_radeon_bmove.  In there, you'll see this code:
> 
> 	if (srcy < dsty) {
>                  srcy += height;
>                  dsty += height;
>          } else
>                  dp_cntl |= DST_Y_TOP_TO_BOTTOM;
> 
>          if (srcx < dstx) {
>                  srcx += width;
>                  dstx += width;
>          } else
>                  dp_cntl |= DST_X_LEFT_TO_RIGHT;
> 
> 
> Those adds need to be reduced by one.  The code should look like this:
> 
> 
> 	if (srcy < dsty) {
>                  srcy += height - 1;
>                  dsty += height - 1;
>          } else
>                  dp_cntl |= DST_Y_TOP_TO_BOTTOM;
> 
>          if (srcx < dstx) {
>                  srcx += width - 1;
>                  dstx += width - 1;
>          } else
>                  dp_cntl |= DST_X_LEFT_TO_RIGHT;
> 
> 
> 
> This bug is in the mainline kernel, and since I have direct experience 
> programming for the Radeon, I knew how to fix it, but I also noticed 
> that the Red Hat kernel "2.4.18-27.7.x" has the proper fix in it.
> 
> 
> Whenever I download a new 2.4 kernel for gentoo, I have to manually make 
> that fix.  I'm also disappointed that acceleration for Radeon has 
> disappeared completely from 2.6.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

