Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261649AbTCKWjG>; Tue, 11 Mar 2003 17:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261652AbTCKWjG>; Tue, 11 Mar 2003 17:39:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:17550 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261649AbTCKWjF>;
	Tue, 11 Mar 2003 17:39:05 -0500
Date: Tue, 11 Mar 2003 14:44:48 -0800
From: Andrew Morton <akpm@digeo.com>
To: george anzinger <george@mvista.com>
Cc: torvalds@transmeta.com, felipe_alfaro@linuxmail.org, cobra@compuserve.com,
       linux-kernel@vger.kernel.org
Subject: Re: Runaway cron task on 2.5.63/4 bk?
Message-Id: <20030311144448.4d9ee416.akpm@digeo.com>
In-Reply-To: <3E6DB852.5060603@mvista.com>
References: <Pine.LNX.4.44.0303101529040.20597-100000@home.transmeta.com>
	<3E6DB852.5060603@mvista.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Mar 2003 22:49:41.0695 (UTC) FILETIME=[80C77CF0:01C2E820]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> wrote:
>
> Ok, here is what I have.  I changed nano sleep to use a local 64-bit 
> value for the target expire time in jiffies.  As much as MAX-INT/2-1 
> will be put in the timer at any one time. It loops till the target 
> time is met or exceeded.  The changes affect (clock)nanosleep only and 
> not timers (they still error out for large values).
> 
> Issues:  The conversion of timespec to jiffies_64 is most easily done 
> by the asm mpy instruction, which results in the required 64 bit 
> result, but C doesn't want to do this sort of thing.

gcc will generate 64bit * 64bit multiplies without resorting to
any library code and you can probably do the division with do_div().


