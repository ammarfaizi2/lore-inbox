Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268396AbUHLBdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268396AbUHLBdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 21:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268355AbUHLBdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 21:33:22 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:34748 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268350AbUHLB0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 21:26:47 -0400
Message-ID: <411AC750.3040809@yahoo.com.au>
Date: Thu, 12 Aug 2004 11:26:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Possible dcache BUG
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org> <200408111037.56062.gene.heskett@verizon.net>
In-Reply-To: <200408111037.56062.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Wednesday 11 August 2004 01:15, Linus Torvalds wrote:
>
>>On Tue, 10 Aug 2004, Linus Torvalds wrote:
>>
>>>So I suspect it's a balancing issue. Possibly just the slight
>>>change in slab balancing to fix the highmem problems. Maybe we
>>>shrink slab _too_ aggressively or something.
>>>
>>Udo, that's a simple thing to check. If it's the slab balancing
>>changes, then you should be able to test it with just a
>>
>>	bk cset -x1.1830.4.3
>>
>>if you have the current BK and are a BK user, or by just revertign
>>the patch here ("patch -R -p1" from inside your linux source tree)
>>if you're not a BK user..
>>
>>		Linus
>>
>>
>With the previously attached patch reverted, a fresh kernel builds in:
>real    7m18.296s
>user    5m49.385s
>sys     0m31.760s
>which is a marked improvement, but still about 1m30 or so slow.
>
>

This could easily be from too much slab pressure. How much memory do you 
have?
Have you got highmem turned on?

The new slab pressure calculation is an improvement in that it won't let 
slab
get out of control and cause OOMs, however it can shrink the slab too much.
If you regularly need ZONE_DMA pages, for example. AFAIKS there isn't 
much you
can do about this except go to per-zone slab LRUs.

That said, your stability problems should be resolved first. If they are 
fixed,
and you would like to help track down the slowdown, run the kernel 
compile about
3 times each with and without the patch, and save cat /proc/vmstat 
before and
after each compile. Try to keep all else constant.

Thanks
Nick

