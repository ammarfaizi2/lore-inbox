Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268328AbUHLCYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268328AbUHLCYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 22:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268353AbUHLCYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 22:24:00 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:9875 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S268328AbUHLCXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 22:23:52 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Wed, 11 Aug 2004 22:23:50 -0400
User-Agent: KMail/1.6.82
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@osdl.org>,
       "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408111037.56062.gene.heskett@verizon.net> <411AC750.3040809@yahoo.com.au>
In-Reply-To: <411AC750.3040809@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408112223.50438.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.10.83] at Wed, 11 Aug 2004 21:23:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 August 2004 21:26, Nick Piggin wrote:
>Gene Heskett wrote:
>>On Wednesday 11 August 2004 01:15, Linus Torvalds wrote:
>>>On Tue, 10 Aug 2004, Linus Torvalds wrote:
>>>>So I suspect it's a balancing issue. Possibly just the slight
>>>>change in slab balancing to fix the highmem problems. Maybe we
>>>>shrink slab _too_ aggressively or something.
>>>
>>>Udo, that's a simple thing to check. If it's the slab balancing
>>>changes, then you should be able to test it with just a
>>>
>>>	bk cset -x1.1830.4.3
>>>
>>>if you have the current BK and are a BK user, or by just revertign
>>>the patch here ("patch -R -p1" from inside your linux source tree)
>>>if you're not a BK user..
>>>
>>>		Linus
>>
>>With the previously attached patch reverted, a fresh kernel builds
>> in: real    7m18.296s
>>user    5m49.385s
>>sys     0m31.760s
>>which is a marked improvement, but still about 1m30 or so slow.
>
>This could easily be from too much slab pressure. How much memory do
> you have?

1 Gb in 2 512Mb sticks of DDR400 ram which signs on in the bios as 
dual channel.  The sticks are in the first and third slots as 
recommended by the mobo docs.

>Have you got highmem turned on?
Yes

>The new slab pressure calculation is an improvement in that it won't
> let slab
>get out of control and cause OOMs, however it can shrink the slab
> too much. If you regularly need ZONE_DMA pages, for example. AFAIKS
> there isn't much you
>can do about this except go to per-zone slab LRUs.

And how would an otherwise clueless user like me determine that?

>That said, your stability problems should be resolved first. If they
> are fixed,

Which as yet is an unknown, Nick.  Uptime now at
 22:15:14 up 12:30,  5 users,  load average: 1.03, 1.11, 1.05

>and you would like to help track down the slowdown, run the kernel
>compile about
>3 times each with and without the patch, and save cat /proc/vmstat
>before and
>after each compile. Try to keep all else constant.

I'll try that if I get to a 30+ hour uptime.

>Thanks
>Nick

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
