Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVIVXbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVIVXbj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 19:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVIVXbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 19:31:39 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:8580 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751181AbVIVXbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 19:31:38 -0400
Message-ID: <43333EBA.5030506@nortel.com>
Date: Thu, 22 Sep 2005 17:31:06 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0509201247190.3743@scrub.home> <1127342485.24044.600.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509221816030.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0509221816030.3728@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2005 23:31:19.0952 (UTC) FILETIME=[BC5FC100:01C5BFCD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

> This no answer at all, you only repeat what you already said above. :(
> Care to share your knowledge?

Ingo already gave an example.  "a busy network server can easily have 
millions of timers pending. I once had to increase a server's 16 million 
tw timer sysctl limit ..."

> I don't say that 64bit math is evil, I just question that it's required - 
> small, but important difference.

<snip>

> It's not just high resolution aware, it makes all calculation in high 
> resolution _unconditionally_, which makes it high resolution all the way.

<snip>

> What unprovable claims? What would change in the basic principles, if you 
> would do them with 32bit ms values instead of 64bit ns values? The basic 
> math should be the same and should demonstrate the basic principles 
> equally well and since the current timer code has only ms (at HZ=1000) 
> precision the behaviour should be the same as well.

I see two assumptions that lead to the API using nanoseconds:

1) it is desireable to have a human-time-unit timer API, so that people 
can specify timeouts in easily-understood units
2) eventually we will use sub-ms resolution timers, so it makes sense to 
just jump to nanoseconds as our base timing unit

Are these reasonable starting points, or is there disagreement on these?

Maybe it would make sense to have the API be in nanoseconds and 
internally use 32bit ms for now, and only change to 64bit nanos when we 
actually move to sub-ms resolution timers.

Chris
