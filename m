Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266363AbUGTXsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266363AbUGTXsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 19:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUGTXsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 19:48:16 -0400
Received: from dns.gardena.net ([213.21.177.18]:60644 "HELO dns.gardena.net")
	by vger.kernel.org with SMTP id S266363AbUGTXsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 19:48:13 -0400
Message-ID: <40FDAF86.10104@gardena.net>
Date: Wed, 21 Jul 2004 01:49:26 +0200
From: Benno Senoner <sbenno@gardena.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] Voluntary Kernel	Preemption Patch
References: <20040712163141.31ef1ad6.akpm@osdl.org>	<1090306769.22521.32.camel@mindpipe> <20040720071136.GA28696@elte.hu>	<200407202011.20558.musical_snake@gmx.de> <1090353405.28175.21.camel@mindpipe>
In-Reply-To: <1090353405.28175.21.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While locking a RT process to a CPU to achieve even lower latencies 
might be useful to some
the general userbase wants good latencies on simple UP, non HT-enabled 
hardware too.
(AMD is gaining marketshare and we cannot simply expect that good 
multimedia performance (aka low latency)
can be achieved only on those SMP/HT boxes where the truth is that 
except in the case of really crappy hardware,
those common UP  machines are actually capable to delives  latencies in 
the range of dozen of usecs.
(taking the RTLinux benchmarks as reference).
Of course Linux != RTLinux and we never expect nor pretend Linux to 
match the response time of RTLinux but
as said earlier latencies at around 1msec should are doable on decent UP 
boxes and this is more than
adequate to run demanding real time audio applications like software 
synthesizers, samples, real time effects etc.
The only hope is that the hard work from Ingo, Andrew and all the others 
gets soon integrated in the mainstream
2.6 kernel so all Linux users can take run demanding multimedia 
applications out of the box without going through
the painful patching,kernel recompiling etc.
Or is this still not realistic at this point ?
 (see the old issue with kernel 2.4,  low latency patches were too 
unclean to make it into the
ufficial kernel tree).

Plus what's very important is that every kernel developer and driver 
developer (even thirdparty, especially those
that do closed source stuff like Nvidia etc) takes into account the 
latency problems that code paths that run for
too long time (or disable IRQs for too long etc) might create.
While I'm not a kernel expert I assume the premptible kernel alleviates 
this problem but I guess it still cannot
completely get rid of low latency-unfriendly routines and drivers.
Perhaps in upcoming Linux kernel/driver programming books this issue 
should be stressed out and
mentioned prominently in order to avoid the eternal:
fixing latencies in kernel x.y.z -> new kernel versions with new 
drivers/changes/enhancements comes out
-> latencies are bad again -> fix latencies in this new kernel version  
.....  ( iterate at infinitum)

cheers,
Benno
http://www.linuxsampler.org


Lee Revell wrote:

>On Tue, 2004-07-20 at 14:11, Ralf Beck wrote:
>  
>
>>>it's an issue for all block IO drivers that do IO completions from IRQ
>>>context and that can do DMA - i.e. every block IO hardware that uses
>>>interrupts. This includes SCSI too. In fact for SCSI it's a norm to have
>>>      
>>>
>>I renew a question i asked earlier.
>>
>>To my understanding, on a SMP or hyperthreading system, disabling of
>>IRQs is always local to one (virtual on HT) cpu.
>>
>>So would it be possible to get ultralow latency by simply hardlock all irqs 
>>and processes to cpu1 and the irq triggering the audiothread (together with 
>>the audiothread) to cpu 2 using the sched_affinity and irq-affinity 
>>capabilites of the kernel?
>>
>>This would be an easy to use lowlatency hardware patch for  linux audio users
>>with SMP/HT systems. Anybody knows?
>>
>>I'm currently thinking about getting a new system and consider a dualsystem if 
>>this worked.
>>    
>>
>
>Should work.  For example, the RTLinux people report excellent results
>on SMP systems by binding all RT threads to one CPU and having the Linux
>part of the system run on the other.  This is just a "softer" version of
>that setup.  Even if there are cases where IRQs are disabled globally,
>it would be an improvement.  I suspect you are not getting much of a
>response because no one has actually tested it with an audio system.
>
>Lee
>
>
>  
>

