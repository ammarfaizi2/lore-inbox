Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293288AbSCXOGh>; Sun, 24 Mar 2002 09:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293314AbSCXOG2>; Sun, 24 Mar 2002 09:06:28 -0500
Received: from mout0.freenet.de ([194.97.50.131]:31196 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S293288AbSCXOGR>;
	Sun, 24 Mar 2002 09:06:17 -0500
Message-ID: <3C9DDDEE.3000401@athlon.maya.org>
Date: Sun, 24 Mar 2002 15:08:46 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020323
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
In-Reply-To: <Pine.LNX.4.44L.0203241029000.18660-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Sun, 24 Mar 2002, andreas wrote:
> 
> 
>>I've got a basic question:
>>Would it be possible to kill only the process which consumes the most
>>memory in the last delta t?
> 
> 
>>rsync is an actual example for the problem, I wrote. This could be any
>>other process, eating up the memory. Then, the kernel kills wildly some
>>processes until the right process is killed - and the machine is
>>probably unavailable meanwhile.
> 
> 
> The problem is that 'rsync' might as well have been 'scientific
> calculation that ran for 3 days'.
> 
> One 'solution' could be to let the OOM killer ignore CPU usage
> of less than say 1 hour, but it'll always be heuristics that
> can go wrong in some scenario.

In that particular case, rsync eats up the memory within seconds. Not 
only 5 MB's but hundreds of MB's. Wouldn't it be possible to detect such 
behaviour and kill such processes, if they consume all the memory very 
fast (I mean RAM and SWAP-space), that is, if no more virtual memory is 
left, or let's say e.g., if 99% percent of virtual memory are used?

Processes, that consume memory during a long term run cannot be detected 
with this heuristic.

Maybe, it would be possible to sort all known processes by there memory 
usage and combine it with the speed of their memoryrequests.
If memory gets low, and there is a process, which suddenly requests a 
lot of memory, this process get's killed, even if there is another 
process, which has three times more memory allocated then the "fast 
growing" process. If all processes are growing nearly equal and memory 
gets low, the process with the most memory usage get's killed - because 
with this process, the kernel achieves the target (to get free memspace) 
best.

Advantage of combining consumption-speed and memory usage per process 
would be, that processes could be filtered, which are obviously broken. 
If the behaviour of the process is correct, than the machine hasn't 
enough memory. But this is a problem, which cannot be handled by the kernel.



Regards,
Andreas Hartmann

