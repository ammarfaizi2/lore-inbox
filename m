Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbTCJTkx>; Mon, 10 Mar 2003 14:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261467AbTCJTkx>; Mon, 10 Mar 2003 14:40:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62993 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261460AbTCJTkw>; Mon, 10 Mar 2003 14:40:52 -0500
Date: Mon, 10 Mar 2003 11:49:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: Andrew Morton <akpm@digeo.com>, <cobra@compuserve.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Runaway cron task on 2.5.63/4 bk?
In-Reply-To: <3E6CEA91.9060603@mvista.com>
Message-ID: <Pine.LNX.4.44.0303101147200.2542-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Mar 2003, george anzinger wrote:
> 
> Lets consider this one on its own merits.  What SHOULD sleep do when 
> asked to sleep for MAX_INT number of jiffies or more, i.e. when 
> jiffies overflows?  My notion, above, it that it is clearly an error. 

My suggestion (in order of preference):
 - sleep the max amount, and then restart as if a signal had happened
 - sleep the max amount (old behaviour)
 - consider it an error (new behaviour)

In this case the error case actually helped find the other unrelated bug, 
so in this case the error actually _helped_ us. However, that was only 
"help" from a kernel perspective, from a user perspective I definitely 
think that it makes no sense to have "sleep(largenum)" return -EINVAL.

And in the end it's the user that matters.

		Linus

