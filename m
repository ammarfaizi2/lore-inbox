Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbSJPUez>; Wed, 16 Oct 2002 16:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbSJPUey>; Wed, 16 Oct 2002 16:34:54 -0400
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:48951
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S261391AbSJPUew>; Wed, 16 Oct 2002 16:34:52 -0400
Message-ID: <3DADD064.8010707@rackable.com>
Date: Wed, 16 Oct 2002 13:47:32 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mcuss@cdlsystems.com
CC: jamesclv@us.ibm.com, root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel reports 4 CPUS instead of 2...
References: <Pine.LNX.3.95.1021016135105.150A-100000@chaos.analogic.com> <200210161228.58897.jamesclv@us.ibm.com> <0d3901c2754c$7bf17060$2c0e10ac@frinkiac7>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2002 20:40:48.0975 (UTC) FILETIME=[4F688DF0:01C27554]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Cuss wrote:

>Speaking of performance.... :)
>
>Has anyone done any testing on a dual CPU configuration like this?  I've
>been testing this box with both the RedHat 8 Stock Kernel (2.4.18.something)
>and 2.4.19 from kernel.org.  Currently, I can't make the thing perform
>anywhere near as fast as my Dual PIII 1 Ghz box (running 2.4.7 for the last
>325 days...) .  I've been compiling the same block of code on both the
>machines and comparing the times.  The PIII box is around 7 s, while the new
>Xeon Box is 13 or 14s...
>
>My thinking was that since the CPUs are much faster, and the FSB is faster,
>and the disk controller is faster, that the computer would be faster.
>
>The hardware is obviously faster, I'm sure its just something I've done
>wrong in the kernel configuration...  If anyone has any advice or words of
>wisdom, I'd really appreciate them...
>  
>

   Try shutting off hyperthreading in the bios.  Keep in mind 
hyperthreading is net loss if you are running a single nonthreaded app. 
 Also you might want to check if there aren't io speed issues.  

  A good way to see the effects positive effects of hyperthreading is a 
kernel compile.  A "make -j 4 bzImage" should be much much faster on the 
Xeon system with hyperthreading than a P3.

>
>Mark
>
>----- Original Message -----
>From: "James Cleverdon" <jamesclv@us.ibm.com>
>To: <root@chaos.analogic.com>; "Samuel Flory" <sflory@rackable.com>
>Cc: "Mark Cuss" <mcuss@cdlsystems.com>; <linux-kernel@vger.kernel.org>
>Sent: Wednesday, October 16, 2002 1:28 PM
>Subject: Re: Kernel reports 4 CPUS instead of 2...
>
>
>  
>
>>On Wednesday 16 October 2002 10:54 am, Richard B. Johnson wrote:
>>    
>>
>>>On Wed, 16 Oct 2002, Samuel Flory wrote:
>>>      
>>>
>>>>>On Wed, 16 Oct 2002, Mark Cuss wrote:
>>>>>
>>>>>This is the correct behavior. If you don't like this, you can
>>>>>swap motherboards with me ;) Otherwise, grin and bear it!
>>>>>          
>>>>>
>>>>  Wouldn't it be easier just to turn off the hypertreading or jackson
>>>>tech option in the bios ;-)
>>>>        
>>>>
>>>Why would you ever want to turn it off?  You paid for a CPU with
>>>two execution units and you want to disable one?  This makes
>>>no sense unless you are using Windows/2000/Professional, which
>>>will trash your disks and all their files if you have two
>>>or more CPUs (true).
>>>      
>>>
>>No, you're thinking of IBM's Power4 chip, which really does have two CPU
>>    
>>
>cores
>  
>
>>on one chip, sharing only the L2 cache.
>>
>>The P4 hyperthreading shares just about all CPU resources between the two
>>threads of execution.  There are only separate registers, local APIC, and
>>some other minor logic for each "CPU" to call its own.  All execution
>>    
>>
>units
>  
>
>>are demand shared between them.  (The new "pause" opcode, rep nop, allows
>>    
>>
>one
>  
>
>>half to yield resources to the other half.)
>>
>>That's why typical job mixes only get around 20% improvement.  Even
>>    
>>
>optimized
>  
>
>>benchmarks, which run only integer code on one side and floating point on
>>    
>>
>the
>  
>
>>other only get around a 40% boost.  The P4 just doesn't have all that many
>>execution units to go around.  Future chips will probably do better.
>>
>>    
>>
>>>Cheers,
>>>Dick Johnson
>>>Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
>>>The US military has given us many words, FUBAR, SNAFU, now ENRON.
>>>Yes, top management were graduates of West Point and Annapolis.
>>>      
>>>
>>--
>>James Cleverdon
>>IBM xSeries Linux Solutions
>>{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>
>
>
>  
>



