Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268355AbUHLCgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268355AbUHLCgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 22:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268345AbUHLCgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 22:36:45 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:12624 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268355AbUHLCgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 22:36:22 -0400
Message-ID: <411AD7A3.5070705@yahoo.com.au>
Date: Thu, 12 Aug 2004 12:36:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Possible dcache BUG
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408111037.56062.gene.heskett@verizon.net> <411AC750.3040809@yahoo.com.au> <200408112223.50438.gene.heskett@verizon.net>
In-Reply-To: <200408112223.50438.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Wednesday 11 August 2004 21:26, Nick Piggin wrote:
>
>>This could easily be from too much slab pressure. How much memory do
>>you have?
>>
>
>1 Gb in 2 512Mb sticks of DDR400 ram which signs on in the bios as 
>dual channel.  The sticks are in the first and third slots as 
>recommended by the mobo docs.
>
>
>>Have you got highmem turned on?
>>
>Yes
>
>

OK, leave it on until you sort out the stability problem. When we look
at performance problem, we'll probably start with highmem off.

I'll try to reproduce it here, but my highmem system has 4GB and is
allergic to mem=

>>The new slab pressure calculation is an improvement in that it won't
>>let slab
>>get out of control and cause OOMs, however it can shrink the slab
>>too much. If you regularly need ZONE_DMA pages, for example. AFAIKS
>>there isn't much you
>>can do about this except go to per-zone slab LRUs.
>>
>
>And how would an otherwise clueless user like me determine that?
>
>

We can look at deltas on some /proc/vmstat fields like pgpgin, slab_scanned,
pgalloc_dma etc. before and after the kbuild. Look at those deltas before
and after Linus' patch, and see if we can work out what is going on.

>>That said, your stability problems should be resolved first. If they
>>are fixed,
>>
>
>Which as yet is an unknown, Nick.  Uptime now at
> 22:15:14 up 12:30,  5 users,  load average: 1.03, 1.11, 1.05
>
>
>>and you would like to help track down the slowdown, run the kernel
>>compile about
>>3 times each with and without the patch, and save cat /proc/vmstat
>>before and
>>after each compile. Try to keep all else constant.
>>
>
>I'll try that if I get to a 30+ hour uptime.
>

Well make sure it is stable first, then get back to me when you're ready
to tackle the performance problem. Thanks.

