Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269056AbUIHPPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269056AbUIHPPo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 11:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269066AbUIHPPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 11:15:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35016 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269056AbUIHPPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 11:15:32 -0400
Message-ID: <413F2317.4050401@sgi.com>
Date: Wed, 08 Sep 2004 10:19:51 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       piggin@cyberone.com.au, mbligh@aracnet.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <20040907212051.GC3492@logos.cnet>
In-Reply-To: <20040907212051.GC3492@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti wrote:

> Ray, I see the additional swapouts increase the dd performance for your particular testcase:
> 
> on 2.6.6:
>         Total I/O   Avg Swap   min    max     pg cache    min    max
>        ----------- --------- ------- ------  --------- ------- -------
>    0   242.47 MB/s      0 MB (     0,     0)   3195 MB (  3138,  3266)
>   20   256.06 MB/s      0 MB (     0,     0)   3170 MB (  3074,  3234)
>   40   267.29 MB/s      0 MB (     0,     0)   3189 MB (  3137,  3234)
>   60   289.43 MB/s    666 MB (    72,  1680)   3847 MB (  3296,  4817)		<---------- 
> 
> So for this one testcase it is being beneficial. 
> 

True enough, but the general trend is that increasing swapping decreases data 
rate.  This is even more true for the real applications that we are modelling 
with this simple benchmark.  In thosec cases, the user has a lot of mapped 
data that they then write out using buffered I/O.  If the mapped data gets 
swapped out, then it may have to be swapped back in to be written out to the 
file system.  It would be faster to keep the mapped data from being swapped 
out at all provided that there is enough page cache space to keep the devices 
running at full speed.

(And yes, we've suggested that they mmap() the data files -- but sometimes 
this is an ISV's code that it causing the problem and we can't necessarily get 
them to update their codes to use the API's we want.)

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

