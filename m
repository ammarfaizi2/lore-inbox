Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319203AbSHUUs5>; Wed, 21 Aug 2002 16:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319212AbSHUUs5>; Wed, 21 Aug 2002 16:48:57 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:3052 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S319203AbSHUUs4>;
	Wed, 21 Aug 2002 16:48:56 -0400
Message-ID: <3D63FDAD.6000009@acm.org>
Date: Wed, 21 Aug 2002 15:53:01 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry Butler <larry_butler@hp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] IPMI driver for Linux
References: <200208211441.40195.larry_butler@hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tie into the highres timer code for short sleeps.  It does require 
that you have highres timers installed in your kernel and enabled. 
 Otherwise you are right, it is very slow.

Since I had access to highres timers, that was a lot easier than hooking 
into and configuring the timer interrupt, and a lot more portable, too.

If you want to post your code or modify mine to add the timer interrupt 
support, that would be great.

-Corey

Larry Butler wrote:

>Corey,
>
>I've been working on a driver too because the busy waits in the drivers that 
>are out there can hold a CPU for too long.  I've measured as much as 120ms.
>
>First I tried sleeping in the driver until the very next jiffy.  I found that 
>my driver became unreliable under high CPU load because the scheduling delays 
>were too long.  I even managed wedge the BMC on one of my test systems in a 
>way I can't seem to fix. :)
>
>What I finally settled on was using the timer interrupt.  This seems to work 
>well both in terms of being nice to the rest of the system (I register a 
>shared irq handler only while I need it) and being reliable even under high 
>load.   So, just consider it a suggestion.  I'd like to see your driver 
>included too.  It's certainly more complete than mine.  You must have access 
>to more documentation than I do.
>
>Larry
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>



