Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269357AbUI3RMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269357AbUI3RMi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 13:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269359AbUI3RMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 13:12:37 -0400
Received: from zeus.kernel.org ([204.152.189.113]:63736 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269357AbUI3RM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 13:12:28 -0400
Message-ID: <415C3F44.2080206@sgi.com>
Date: Thu, 30 Sep 2004 12:15:48 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
References: <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <20040907212051.GC3492@logos.cnet> <413F1518.7050608@sgi.com> <20040908165412.GB4284@logos.cnet> <413F5EE7.6050705@sgi.com> <20040908193036.GH4284@logos.cnet> <413FC8AC.7030707@sgi.com> <20040909030916.GR3106@holomorphy.com> <4158C45B.8090409@sgi.com> <4158DC27.9010603@yahoo.com.au> <415A0378.9030007@cyberone.com.au>
In-Reply-To: <415A0378.9030007@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> Nick Piggin wrote:
> 
>>
>> Thanks Ray. From looking over your old results, it appears that 
>> -kswapdfix
>> probably has the nicest swappiness ramp, which is probably to be 
>> expected,
>> as the problem that is being fixed did exist in all other kernels you 
>> tested,
>> but the later ones just had other aggrivating changes.
>>
>> The swappiness=60 weirdness might just be some obscure interaction 
>> with the
>> workload. If that is the case, it is probably not too important, 
>> however it
>> could be due to a possible oversight in my patch....
>>
> 
> Here is a patch on top of the last one - if you can give it a test
> some time, that would be great.
> 
> Thanks
> Nick
> 
> 

Hi Nick,

Here are the results for the kswapd2 patch, along with the previous version 
and the original 2.6.9-rc1-mm3 test.  It pretty much looks like a wash between
the kswapd and kswapd2 patches.

Kernel Version 2.6.9-rc1-mm3:
         Total I/O   Avg Swap   min    max     pg cache    min    max
        ----------- --------- ------- ------  --------- ------- -------
    0   274.80 MB/s  10511 MB (  5644, 14492)  13293 MB (  8596, 17156)
   20   267.02 MB/s  12624 MB (  5578, 16287)  15298 MB (  8468, 18889)
   40   267.66 MB/s  13541 MB (  6619, 17461)  16199 MB (  9393, 20044)
   60   233.73 MB/s  18094 MB ( 16550, 19676)  20629 MB ( 19103, 22192)
   80   213.64 MB/s  20950 MB ( 15844, 22977)  23450 MB ( 18496, 25440)
  100   164.58 MB/s  26004 MB ( 26004, 26004)  28410 MB ( 28327, 28455)


Kernel Version 2.6.9-rc1-mm3-kdb-kswapdfix:
         Total I/O   Avg Swap   min    max     pg cache    min    max
        ----------- --------- ------- ------  --------- ------- -------
    0   279.97 MB/s     89 MB (    12,   265)   3062 MB (  2947,  3267)
   20   283.55 MB/s    161 MB (    15,   372)   3190 MB (  3011,  3427)
   40   282.32 MB/s    204 MB (     6,   407)   3187 MB (  2995,  3331)
   60   279.42 MB/s     72 MB (    15,   171)   3091 MB (  3027,  3155)
   80   283.34 MB/s    920 MB (   144,  3028)   3904 MB (  3106,  5957)
  100   160.55 MB/s  26008 MB ( 26007, 26008)  28473 MB ( 28455, 28487)

Kernel Version 2.6.9-rc1-mm3-kdb-kswapdfix2:
         Total I/O   Avg Swap   min    max     pg cache    min    max
        ----------- --------- ------- ------  --------- ------- -------
    0   282.71 MB/s    247 MB (     8,   691)   3248 MB (  2995,  3636)
   20   281.96 MB/s    127 MB (     3,   300)   3097 MB (  2931,  3283)
   40   282.24 MB/s    252 MB (    16,   417)   3270 MB (  3059,  3475)
   60   281.27 MB/s    404 MB (   106,  1070)   3414 MB (  3139,  4068)
   80   281.30 MB/s    494 MB (   204,   662)   3485 MB (  3187,  3635)
  100   160.35 MB/s  26003 MB ( 26003, 26003)  28477 MB ( 28407, 28519)

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

