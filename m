Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbSKSXNH>; Tue, 19 Nov 2002 18:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267580AbSKSXNH>; Tue, 19 Nov 2002 18:13:07 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:52361 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267581AbSKSXNG>;
	Tue, 19 Nov 2002 18:13:06 -0500
Message-ID: <3DDAC71A.9040507@colorfullife.com>
Date: Wed, 20 Nov 2002 00:19:54 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Dave Richards <drichard@largo.com>, linux-kernel@vger.kernel.org
Subject: Re: Off List Message - Kernel Problem - Respond To Me
References: <1037742240.31569.9.camel@oa3> <20021119220751.GX11776@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>On Tue, Nov 19, 2002 at 04:44:00PM -0500, Dave Richards wrote:
>  
>
>>Nov 19 14:09:41 desktop_a kernel: ldt allocation failed
>>We get this error over and over again and no additional users can log
>>into the server.
>>I'm not on the linux-kernel list, but if anyone has insight into this
>>issue, please drop me a line.  If you know a way to fix this in the 2.4
>>kernel too, or can verify that we have to wait for 2.5/2.6 we need to
>>know that too.
>>    
>>
>
>IIRC this has been hit in threaded benchmarks before; ISTR a fix for LDT
>OOM going around, probably manfred's stuff which is in 2.5 and 2.4-ac.
>  
>
Correct, the patch is in 2.4-ac, and I'll send it to Marcelo for 2.4.21.

How many concurrent processes are running? Each thread that is linked 
against libpthread consumes 64 kB vmalloc space, and on SMP you have 
around 96 MB vmalloc space. I'd expect OOM at 1500 threads.

With the fix applied, no vmalloc space is needed for libpthread.
--
    Manfred

