Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWC0Skg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWC0Skg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 13:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWC0Skg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 13:40:36 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:44425 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750827AbWC0Skf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 13:40:35 -0500
Subject: Re: uptime increases during suspend
From: john stultz <johnstul@us.ibm.com>
To: Jonathan Black <vampjon@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060325150238.GA9023@beacon.dhs.org>
References: <20060325150238.GA9023@beacon.dhs.org>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 10:40:20 -0800
Message-Id: <1143484821.2168.16.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-25 at 16:02 +0100, Jonathan Black wrote:
> I'd like to enquire about the following behaviour:
> 
> $ uptime && sudo hibernate && uptime
>  14:18:51 up 1 day, 4:12,  2 users,  load average: 0.58, 3.30, 2.42
>  14:23:46 up 1 day, 4:17,  2 users,  load average: 20.34, 7.74, 3.91
> 
> I.e. the system was suspended to disk for 5 minutes, but the value
> reported by 'uptime' has increased by as much, as if it had actually
> continued running during that time.

Yes, I don't know exactly when it was changed, but jiffies is now
updated when we return from suspend, which causes the uptime to
effectively increase while we are suspended.

[snip]
> The way it is now, one can essentially "cheat": suspend a machine, put
> it in the cupboard for a couple of weeks, resume it and claim a
> respectable uptime, because the uptime value only reflects how long ago
> the system was first booted up, with no regard to how much of that time
> it has actually been running.

Well, anyone can hack their kernel to say whatever uptime they want, so
I'm not to worried about cheating. Are you seeing an actual bug here?


> Would it be possible to get the old behaviour back?

Why exactly do you want this behavior? Maybe a better explanation would
help stir this discussion.

The question about the correct behavior is more relevant with
virtualization as well. Should the OS's uptime increase even when
another OS is running on the cpu? What is the proper interface to export
the OS's cpu time? 

Right now I'm of the opinion that jiffies should be updated, as real
time has past and timer events that are queued should expire. 

However with a good enough reason, we might want to add another counter
that keeps track of how much time we've been suspended as well. 

thanks
-john

