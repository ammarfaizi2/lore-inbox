Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRC3Tsh>; Fri, 30 Mar 2001 14:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRC3Ts1>; Fri, 30 Mar 2001 14:48:27 -0500
Received: from zeus.kernel.org ([209.10.41.242]:14798 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129524AbRC3TsV>;
	Fri, 30 Mar 2001 14:48:21 -0500
Date: Fri, 30 Mar 2001 12:33:24 -0600 (CST)
From: Josh Grebe <squash@primary.net>
To: Ed Tomlinson <tomlins@cam.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vmtime and vm balancing
In-Reply-To: <01032711561000.01000@oscar>
Message-ID: <Pine.LNX.4.32.0103301229410.864-100000@scarface.primary.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I installed this patch onto one of my pop3/imap servers in my farm, and it
crashed pretty hard today. I didn't get any crash data though, another
admin rebooted it. This was after approx. 24 hours uptime. My service log
shows load went absolutely through the roof, as high as 214, but memory
never got above 88%. I will give it another try on Monday, I don't want
any weekend issues to come up.

Josh

---
Josh Grebe
Senior Unix Systems Administrator
Primary Network, an MPower Company
http://www.primary.net

On Tue, 27 Mar 2001, Ed Tomlinson wrote:

> Hi,
>
> The following patch introduces the idea of vmtime.  vmtime is time as the
> vm percieves it.  Its advanced by memory pressure, which in the end, works
> out to be the page allocation & reclaim rate.  With this figure I attempt to solve
> two problems.
>
> First I slow down the background page scanning to the rate we are allocating
> pages.  This means that an idle machine will not end up with all page ages
> equal nearly as quickly.  It should also help prevent cases where kswapd
> eats too much cpu.  The other effect should be to prevent or reduce some
> swap out spikes.
>
> Second, I add some slab cache pressure.  Without the patch the icache and
> dcache will get shrunk in under extreme cases.  From comments on mm
> list (and personal experience) the slab cache can grow and end up causing
> paging when it would make more sense to just shrink it.  This also has
> oom implications since the size of the slab cache, and the possible space
> we can free from it, are not accounted for in the oom test.  In any case
> the patch should help keep this storage under control.  Are there any other
> parts of the slab cache we should think about shrinking?
>
> This has survived the night on my box with printk(s) in the if(s) to verify
> its actually working.  It should apply to pre8 and ac25/ac26.   The vmscan.c
> change made by ac26 should not hurt this patch but may make it age
> pages a bit more aggressivily.
>
> We need to find out if this helps.  Reports on what effect this has would
> be very welcome.  Rik has looked at the patch and wants to see some
> feedback...
>
> Comments on style or bugs very welcome.
>
[patch removed]

