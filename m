Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVCVWRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVCVWRZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVCVWQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:16:03 -0500
Received: from ctv-217-147-43-176.init.lt ([217.147.43.176]:48536 "EHLO
	buakaw.homelinux.net") by vger.kernel.org with ESMTP
	id S262165AbVCVWOn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:14:43 -0500
Message-ID: <20050323001439.lwhm92er5cs4s8c8@buakaw.homelinux.net>
Date: Wed, 23 Mar 2005 00:14:39 +0200
From: buakaw@buakaw.homelinux.net
To: linux-kernel@vger.kernel.org
Subject: Re: dst cache overflow
References: <1144.192.168.0.37.1111351868.squirrel@buakaw.homelinux.net>
	<20050321194022.491060c7.akpm@osdl.org>
	<1297.192.168.0.37.1111480783.squirrel@buakaw.homelinux.net>
	<20050322161657.GA18925@linuxace.com>
	<20050322190726.e1jiyi25xws0okss@buakaw.homelinux.net>
	<42408A2C.8060103@cosmosbay.com>
In-Reply-To: <42408A2C.8060103@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Internet Messaging Program (IMP) H3 (4.0.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



grep . /proc/sys/net/ipv4/route/*

/proc/sys/net/ipv4/route/error_burst:5000
/proc/sys/net/ipv4/route/error_cost:1000
grep: /proc/sys/net/ipv4/route/flush: Invalid argument
/proc/sys/net/ipv4/route/gc_elasticity:8
/proc/sys/net/ipv4/route/gc_interval:60
/proc/sys/net/ipv4/route/gc_min_interval:0
/proc/sys/net/ipv4/route/gc_min_interval_ms:500
/proc/sys/net/ipv4/route/gc_thresh:4096
/proc/sys/net/ipv4/route/gc_timeout:300
/proc/sys/net/ipv4/route/max_delay:10
/proc/sys/net/ipv4/route/max_size:65536
/proc/sys/net/ipv4/route/min_adv_mss:256
/proc/sys/net/ipv4/route/min_delay:2
/proc/sys/net/ipv4/route/min_pmtu:552
/proc/sys/net/ipv4/route/mtu_expires:600
/proc/sys/net/ipv4/route/redirect_load:20
/proc/sys/net/ipv4/route/redirect_number:9
/proc/sys/net/ipv4/route/redirect_silence:20480
/proc/sys/net/ipv4/route/secret_interval:600


cat /proc/net/stat/rt_cache

entries  in_hit in_slow_tot in_no_route in_brd in_martian_dst 
in_martian_src out_hit out_slow_tot out_slow_mc  gc_total gc_ignored 
gc_goal_miss
gc_dst_overflow in_hlist_search out_hlist_search
000000b9  02e05549 01fa47b9 00000000 00000000 00016e03 00000022 
00251b22 00083e65 0000fe7e 00000008 00f15fc6 00f064e8 0000ebe8 0000eb57 
08703a77
000087cf
000000b9  00000000 00000000 00000000 00000000 00000000 00000000 
00000000 0001105a 000027ed 00000002 0000018f 00000171 0000000e 00000009 
00000000
00003217





Quoting Eric Dumazet <dada1@cosmosbay.com>:

> buakaw@buakaw.homelinux.net a écrit :
>> I see on 2.6.10/2.6.11.3
>>
>
>
> Hello
>
> Could you give us the results of these commands :
>
> # grep . /proc/sys/net/ipv4/route/*
> # cat /proc/net/stat/rt_cache
>
> Eric Dumazet
>
>> Quoting Phil Oester <kernel@linuxace.com>:
>>
>>> On Tue, Mar 22, 2005 at 10:39:43AM +0200, 
>>> buakaw@buakaw.homelinux.net wrote:
>>>
>>>>
>>>> computer's main job is to be router on small LAN with 10 users and  so
me
>>>> services like qmail, apache, proftpd, shoutcast, squid, and ices on sl
ack
>>>> 10.1. Iptables and tc are used to limit  bandwiwdth and the two bandwi
dthd
>>>>  daemons are running on eth0 interface and all the time the cpu is use
d at
>>>> about 0.4% and additional 12% by ices  when encoding mp3 on demand, an
d
>>>> the proccess ksoftirqd/0 randomally starts to use 100% of 0 cpu in nor
mal
>>>> situation and one time when the ksoftirqd/0 became crazy i noticed dst
>>>> cache overflow messages in syslog but there are more of thies lines in
>>>> logs  about 5 times in 10 days period
>>>
>>>
>>> There was a problem fixed in the handling of fragments which caused dst
>>> cache overflow in the 2.6.11-rc series.  Are you still seeing dst cache
>>> overflow on 2.6.11?
>>>
>>> Phil
>>>
>>
>>
>>
>> ----------------------------------------------------------------
>> This message was sent using IMP, the Internet Messaging Program.
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

