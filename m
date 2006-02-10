Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWBJWUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWBJWUj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 17:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWBJWUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 17:20:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35254 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932218AbWBJWUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 17:20:38 -0500
Date: Fri, 10 Feb 2006 17:20:35 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Ram Gupta <ram.gupta5@gmail.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: RSS Limit implementation issue
In-Reply-To: <728201270602100650q22938b88x237b8fb043c82408@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0602101717590.25390@cuia.boston.redhat.com>
References: <728201270602091310r67a3f2dcq4788199f26a69528@mail.gmail.com> 
 <1139526447.6692.7.camel@localhost.localdomain>
 <728201270602100650q22938b88x237b8fb043c82408@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2006, Ram Gupta wrote:

> Also we need to figure out a way for swapper to target pages based on 
> RSS limit.

Indeed.  You do not want an RSS limited process to get stuck
on an idle system, because nothing wants to free its memory.

> One possible disadvantage I can think is that as the swapper 
> swaps out a page based on RSS limit, the process's rss will become 
> within the rss limit & then scheduler will schedule this process again & 
> hence possibly same page might have to be brought in. This may cause 
> increase in swapping. What do you think how much realistic is this 
> scenario?

Thanks to the swap cache, this should not be an issue.

You don't need to actually write the page to disk when removing
the page from the process RSS - you simply add it to the swap
cache, unmap it and move it to the far end of the inactive list,
where kswapd will run into it quickly if the system needs memory
again in the future.

-- 
All Rights Reversed
