Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317440AbSHCE2j>; Sat, 3 Aug 2002 00:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317448AbSHCE2j>; Sat, 3 Aug 2002 00:28:39 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:54966 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S317440AbSHCE2i>;
	Sat, 3 Aug 2002 00:28:38 -0400
Message-ID: <3D4B5CB7.9020503@candelatech.com>
Date: Fri, 02 Aug 2002 21:31:51 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alexandre P. Nunes" <alex@PolesApart.wox.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: some questions using rdtsc in user space
References: <3D4ABCA3.3020402@PolesApart.wox.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you just tried spinning in a tight loop using gettimeofday
to get the time?  It's not exactly efficient, but if you need that
kind (200ns) of precision that is about the only way.  You'll still
be stuck with 1usec precision since that is as good as gettimeofday
can do, but that's a far sight better than 10ms or even 2ms.

Ben

Alexandre P. Nunes wrote:
> Hi,
> 
> Both I and a friend have with an interesting scenario, maybe someone can 
> help us.
> 
> We have to access a device connected to parallel port, which works in 
> the following way: you send a byte to the port, to turn some bits on 
> (reflecting on some pins on the parallel port), which is interpreted by 
> the device as a command. Then you are supposed to sleep about ~200ns 
> (maybe more, just can't be much less), and then you send a byte which is 
> received by the device as  data, pertinent to command.
> 
> We wrote a program which accomplishes this by doing outb() to 
> appropriate address(es), followed by usleep(1), but that  seems to take 
> about 10 ms at average or so, which is far from good for our application.
> 
> I read somewhere that putting the process in real-time priority could 
> lead the average to 2ms, but I had this though that I could solve this 
> by using rdtsc instruction, because as far as I know it won't cause a 
> trap to kernel mode, which maybe expensive, am I right?
> 
> I don't have the need to use real time linux (though I'm considering 
> real-time priority), nor desperate time precision needs, what I don't 
> want is to have huge delays. I cannot relay on the low-latency patches 
> too, if possible  (though I know it could help), because the program 
> will eventually run on standard kernels.
> 
> If using rdtsc is a good way, someone knows how do I do some sort of 
> loop, converting the rdtsc difference (is it in cpu clocks, right?) to 
> nano/microseconds, and if there could be bad behaviour from this (I 
> believe there could be some SMP issues, but for now this is irrelavant 
> for us).
> 
> 
> Thanks!
> 
> 
> Alexandre
> 
> P.S..: carbon-copy me, since I'm not subscribed to the list.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


