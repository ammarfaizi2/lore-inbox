Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVCGNBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVCGNBG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 08:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVCGNBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 08:01:05 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53791
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261152AbVCGNAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 08:00:49 -0500
Date: Mon, 7 Mar 2005 14:00:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/5] setup_per_zone_lowmem_reserve() oops fix
Message-ID: <20050307130043.GP8880@opteron.random>
References: <200503042117.j24LHGrx017967@shell0.pdx.osdl.net> <422C0C5D.3060404@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422C0C5D.3060404@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 07:10:05PM +1100, Nick Piggin wrote:
> akpm@osdl.org wrote:
> >If you do 'echo 0 0 > /proc/sys/vm/lowmem_reserve_ratio' the kernel gets a
> >divide-by-zero.
> >
> >Prevent that, and fiddle with some whitespace too.
> >
> >Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> Can we instead have a patch that makes the value zero turn off the
> lowmem reserve entirely if it is set to zero?
> 
> Just now I was just testing, and found no easy way to do this other
> than to make the value large enough that the reserve is insignificant.
> 
> So the loop would be something like:
> 
>  			for (idx = j-1; idx >= 0; idx--) {
> 				struct zone *lower_zone;
> 				lower_zone = pgdat->node_zones + idx;
> 
> 				lower_zone->lowmem_reserve[j] = 0;
> 				if (sysctl_lowmem_reserve_ratio[idx] > 0)
> 					lower_zone->lowmem_reserve[j] = 
> 					present_pages /
> 						sysctl_lowmem_reserve_ratio[idx];
> 
> 				present_pages += lower_zone->present_pages;
> 			}

Looks good to me. I noticed the divide by zero myself once, and I
also considered changing it so that zero disables it. Could you send a
full patch to Andrew? Thanks.
