Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267128AbTBDJpi>; Tue, 4 Feb 2003 04:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267198AbTBDJpi>; Tue, 4 Feb 2003 04:45:38 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:25219 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S267128AbTBDJpf>; Tue, 4 Feb 2003 04:45:35 -0500
Message-ID: <3E3F8DE6.708@bogonomicon.net>
Date: Tue, 04 Feb 2003 03:54:46 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: vda@port.imtp.ilyichevsk.odessa.ua, root@chaos.analogic.com,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: gcc 2.95 vs 3.21 performance
References: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com> <200302040656.h146uJs10531@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Personal opinion here but I know it is also held by many developers I 
know and work with.  I'd rather have a compiler that produces correct 
and fast code but ran slow than one that produces slow or bad code and 
runs fast.  Remember compilation is done far less often than run time 
execution.  Yes I too noticed a difference when I switched over to 3.2 
but I also noticed some of my code speed up.

>>>People keep extolling the virtues of gcc 3.2 to me, which I'm
>>>reluctant to switch to, since it compiles so much slower. But
>>>it supposedly generates better code, so I thought I'd compile
>>>the kernel with both and compare the results. This is gcc 2.95
>>>and 3.2.1 from debian unstable on a 16-way NUMA-Q. The kernbench
>>>tests still use 2.95 for the compile-time stuff.
>>
>>[SNIPPED tests...]
> 
> 
> What was the size of uncompressed kernel binaries?
> This is a simple (and somewhat inaccurate) measure of compiler
> improvement ;)

While I too like smaller tighter output code, I'd trade it for code that 
runs faster in real world situations.  As an example identifying the 
most likely execution path through a routine and keeping it contiguous 
in memory will do more for average execution speed than optimizing to 
use the smallest number of bytes.  If the compiler could tell which 
blocks of code are for handling exceptions it then can place them ouside 
of the main execution path.  This makes the normal code execution path 
smaller and more compact.  In doing so it also reduces the number of 
memory fetch operations and cache space needed to run the code.  With 
cache misses being 100+ clock cycles and page faults well into the 
millions, keeping that normal execution path short means alot.

>>Don't let this get out, but egcs-2.91.66 compiled FFT code
>>works about 50 percent of the speed of whatever M$ uses for
>>Visual C++ Version 6.0  I was awfully disheartened when I
> 
> Yes. M$ (and some other compilers) beat GCC badly.

But can M$'s compiler produce code for many radically different CPU 
architectures?  Most people only work with gcc on one type of CPU so 
they never think about just how flexible and good GCC really is.  I see 
it often compaired against compilers that are dedicated to a single CPU 
where the development team only has to worry about one CPU type.  GCC's 
development team needs to worry about many different arcitectures.  Some 
are radically different in their fundamental structure.  This really 
complicates the job of producing a compiler that works correctly.

- Bryan



