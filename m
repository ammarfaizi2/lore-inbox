Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268299AbTBMVRr>; Thu, 13 Feb 2003 16:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268300AbTBMVRr>; Thu, 13 Feb 2003 16:17:47 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:40639 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S268299AbTBMVRq>;
	Thu, 13 Feb 2003 16:17:46 -0500
Message-ID: <3E4C0DC8.3050803@candelatech.com>
Date: Thu, 13 Feb 2003 13:27:36 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: select returning slow on RH 2.4.18-14 (RH 8.0) kernel.
References: <3E4B60A1.2060209@candelatech.com> <1045136340.2313.1.camel@laptop.fenrus.com>
In-Reply-To: <1045136340.2313.1.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2003-02-13 at 10:08, Ben Greear wrote:
> 
>>I've been doing some testing with RH 8.0 on an Ezra 800Mhz
>>machine.
>>
>>Even when lightly loaded select() often returns 3-9 miliseconds slower
>>than the timeout would suggest.  I know select is not guaranteed to
>>return with < 10ms accuracy, but with almost no load, shouldn't it
>>at least return with 1ms accuracy on average?
> 
> no
> the kernel.org kernels will return in multiple-of-10ms quantities due to
> HZ having the value of 100.
> 2.4.18-14 (which is btw obsoleted by several security errata) has a HZ
> value of 512 so will return in shorter quantities, EXCEPT when you
> always try to wait exactly 10ms of course....

For posterity's sake...I think I found a somewhat suitable work around.

I set up the real-time-clock at 1024hz, open /dev/rtc, and then add it's
file descriptor to my select input set when (0 < timeout < 10).

This causes a near busy-spin on slower cpus...but for me at least that
is the lesser of two evils...

If anyone has any cleaner/better/faster/ hacks they feel like sharing,
do let me know!

PS.  Don't use SCHED_RR with this hack..or you can live-lock your system
if it's like mine :)

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


