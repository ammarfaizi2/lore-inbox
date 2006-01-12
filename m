Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWALJfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWALJfp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWALJfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:35:45 -0500
Received: from relay03.pair.com ([209.68.5.17]:59918 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S932160AbWALJfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:35:44 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: [ck] Bad page state at free_hot_cold_page
Date: Thu, 12 Jan 2006 03:36:02 -0600
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <200601120301.00361.chase.venters@clientec.com> <20060112092406.GA2587@rhlx01.fht-esslingen.de>
In-Reply-To: <20060112092406.GA2587@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601120336.03289.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 03:24, Andreas Mohr wrote:
> AFAIK random page state toggling often happens due to bad RAM.
>
> Care to run memtest86 or similar to confirm this?
> Or also try running an older kernel to verify whether it doesn't happen
> there. But I'm betting on bad RAM :-\

Andreas,
	I've been looking into this problem a little bit more (did some digging to 
try and teach myself a little bit about the page flags). I noticed after 
posting that I had bad page states reported in dmesg for amarokapp (new ones) 
as well. 
	So I got a bit curious and looked to see what bits were stuck on... and I 
started to wonder if it could have something to do with ALSA. (Unfortunately 
I'm quickly reaching the limit of my current understanding of the kernel's 
innards)
	Anyway, I tried a test - made sure both amarokapp and artsd were dead, then 
used rmmod to pluck out every last "snd" module. I put them back in, fired up 
amarok, and went to play a song. It played fine with no noticeable latency, 
so I tried switching to another track. Doing so caused the system to freeze 
for a few seconds and another set of bad page states to go rushing through 
the log.
	I can accept bad memory (though I think it's unlikely on this system because 
I've tested that fairly recently) but the page states, while bad, are 
consistently (not randomly) so.
	I'd reboot right now and test it, but at the moment I'm capable of 
reproducing these page state errors 100% of the time, so if there are any 
sorts of things I can do to debug the thing while it's up I'd like to move 
forward with that before I reboot and lose whatever 'ideal state' got me here 
in the first place.

Thanks,
Chase

> Andreas Mohr
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
