Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbUAPFXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbUAPFWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:22:49 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:55764 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265246AbUAPFWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:22:41 -0500
Message-ID: <4007751C.9090702@kriminell.com>
Date: Fri, 16 Jan 2004 06:22:36 +0100
From: marcel cotta <marcel@kriminell.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: kernel BUG at mm/swapfile.c:806
References: <400751B1.40608@kriminell.com>	<20040115203419.76332f6a.akpm@osdl.org>	<40076B62.9000108@kriminell.com> <20040115204302.2909af64.akpm@osdl.org>
In-Reply-To: <20040115204302.2909af64.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> marcel cotta <marcel@kriminell.com> wrote:
> 
>>Andrew Morton wrote:
>>
>>>marcel cotta <marcel@kriminell.com> wrote:
>>>
>>>
>>>>i got this oops after the box swapped like crazy under X for about 5 
>>>>minutes
>>>>while swapping it was nearly unusable (jerky mouse, console switching 
>>>>took 10 seconds)
>>>>the extreme performance drop is always reproducible when swapping starts
>>>>
>>>>
>>>>------------[ cut here ]------------
>>>>kernel BUG at mm/swapfile.c:806!
>>>
>>>
>>>Amazing.  Are you using a swapfile, or are you swapping to a block device?
>>>
>>>
>>>
>>>
>>
>>hehe, hasnt been reported for a while eh ;)
>>
>>i used swapfiles, one static 50mb file and the rest in temp 16MB 
>>blocks managed by swapd
> 
> 
> What is `swapd'?
> 
> 


the box is still running and i just saw another thing

hades:~# cat /proc/swaps
Filename                                Type            Size    Used
   Priority
/swap/linux0.swp                         file           14184   14160   -1
/swap/linux1.swp                         file           16184   16036
   -22
/swap/linux2.swp                         file           16184   15740
   -23
/swap/linux3.swp                         file           16184   15720
   -28
/swap/linux4.swp                         file           16184   15960
   -43
/swap/linux5.swp                         file           16184   13380
   -44
/swap/linux6.swp                         file           16184   104
   -45
/swap/linux7.swp                         file           16184   0
   -46
/swap/linux8.swp                         file           16184   4
   -47


hades:~# free
              total       used       free     shared    buffers     cached
Mem:        188724     184076       4648          0        328      33176
-/+ buffers/cache:     150572      38152
Swap:       127476      90528      36948


have a look at the total swap amount, free reports 127476 but the
total should be 143656
the /swap/linux0.swp file being 2mb smaller is no error
it is caused by setting swapfile size in /etc/swapd.conf to 14184,
while only
this file being in use, and restarting swapd with 16184 as new
swapfile size


