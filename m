Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269345AbTCDJu3>; Tue, 4 Mar 2003 04:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269349AbTCDJu3>; Tue, 4 Mar 2003 04:50:29 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:21978 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S269345AbTCDJu2>; Tue, 4 Mar 2003 04:50:28 -0500
Date: Tue, 04 Mar 2003 23:00:46 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Con Kolivas <kernel@kolivas.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: xmms (audio) skipping in 2.5 (not 2.4)
Message-ID: <84002989.1046818846@[192.168.0.1]>
In-Reply-To: <200303041915.43743.kernel@kolivas.org>
References: <103200000.1046755559@[10.10.2.4]>
 	<200303041828.10130.kernel@kolivas.org> <107450000.1046764086@[10.10.2.4]>
 <200303041915.43743.kernel@kolivas.org>
X-Mailer: Mulberry/3.0.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per chance, do you have an NVidia graphics card and Maestro 3 or USB audio? 
If so, you're possibly getting DMA starvation.  There are games you can 
play with the PCI latency timers to help with this, but I cannot recall the 
details; searching around for Dell Inspiron laptop audio issues might find 
them.  I just replaced the machine I saw this on, so I can't help anymore.

Andrew

--On Tuesday, 4 March 2003 7:15 p.m. +1100 Con Kolivas <kernel@kolivas.org> 
wrote:

> On Tue, 4 Mar 2003 06:48 pm, Martin J. Bligh wrote:
>> >> >> So ... is there any easy way I can diagnose this? Does anyone else
>> >> >> have a similar problem?
>> >> >
>> >> > Most of us who have worked with an O(1) scheduler based kernel have
>> >> > found this  at various times. See the previous discussion with akpm
>> >> > about the interactivity estimator. Akpm found that decreasing the
>> >> > maximum timeslice duration would blunt the effect of the
>> >> > interactivity estimator giving preference to the "wrong" task. In
>> >> > 2.4.20-ck4 I avoid this problem with the  "desktop tuning" of
>> >> > making the max timeslice==min timeslice. Try an -mm  kernel with
>> >> > the scheduler tunables patch and try playing with the max
>> >> > timeslice. Most have found that <=25 will usually stop these skips.
>> >> > The  default max timeslice of 300ms is just too long for the
>> >> > desktop and interactivity estimator.
>> >>
>> >> Heh, cool. I have the same patch in my tree too, fixed it without
>> >> rebooting even ;-) Still a *tiny* bit of skipping, but infinitely
>> >> better than it was.
>> >
>> > Try decreasing prio_bonus_ratio to 15 as well
>>
>> Doesn't seem to make much difference, actually.
>> But "waggle scrollbar a bit" isn't very scientific .. ;-)
>> Does contest (or anything else) measure this kind of thing more
>> precisely?
>
> Last time I tried to do a whole swag of tunables it was showing
> differences  but I was plagued by memory leaks ruining the data. I'll try
> again in the  near future. Also Bill Davidsen's trivial response
> benchmark may show  something too.
>
> Con
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>


