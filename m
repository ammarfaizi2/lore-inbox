Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbULIKV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbULIKV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 05:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbULIKV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 05:21:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:6036 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261492AbULIKV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 05:21:57 -0500
Date: Thu, 9 Dec 2004 11:21:55 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: nanosleep resolution, jiffies vs microseconds
In-Reply-To: <1102524468.16986.30.camel@farah.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.53.0412091119520.4189@yvahk01.tjqt.qr>
References: <1102524468.16986.30.camel@farah.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I am looking at trying to improve the latency of nanosleep for short
>sleep times (~1ms).  After reading Martin Schwidefsky's post for cputime
>on s390 (Message-ID:
><20041111171439.GA4900@mschwid3.boeblingen.de.ibm.com>), it seems to me
>that we may be able to accomplish this by storing the expire time in
>microseconds rather than jiffies.  Here is an example for context:
>
>Say we want to sleep for 1ms on i386, we call nanosleep(1000000).
[...]

There was once a busy-wait patch to allow nanosleep have resolution up to 2 ns.
Unfortunately, it was reverted by Linus...

---------------------
PatchSet 3949
Date: 2002/09/26 05:04:43
Author: torvalds
Branch: HEAD
Tag: (none)
Log:
Remove busy-wait for short RT nanosleeps. It's a random special case
and does the wrong thing for higher HZ values anyway.

BKrev: 3d92875bgaJQe6_FSRDwHLDYHwPTgw

Members:
        ChangeSet:1.3949->1.3950
        kernel/timer.c:1.22->1.23


>Unfortunately on i386 a jiffy is slightly less than 1ms (as one might
>expect with HZ = 1000).  So when sys_nanosleep calls
>timespec_to_jiffies, it returns 2.  Now to allow for the corner case
>when my 1ms sleep request gets called at the very tail end of a clock
>period (see ascii diagram below), nanosleep adds 1 to that and calls
>schedule_timeout with 3.  So a 1 ms sleep correctly turns into 3
>jiffies.
>
>If we were to store the expire value in microseconds, this corner case
>would still exist and still span two full tick periods.  However, the
>large majority of the time, nanosleep(1000000) could pause for only 2
>jiffies, instead of 3.  Before I dug to deep into the relevant code I
>wanted to hear some opinions on this approach.
>

Jan Engelhardt
-- 
ENOSPC
