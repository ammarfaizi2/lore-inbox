Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318297AbSHUOfx>; Wed, 21 Aug 2002 10:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318332AbSHUOfx>; Wed, 21 Aug 2002 10:35:53 -0400
Received: from www.wen-online.de ([212.223.88.39]:45830 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S318297AbSHUOfw>;
	Wed, 21 Aug 2002 10:35:52 -0400
Message-ID: <3D63A54D.8010902@gmx.de>
Date: Wed, 21 Aug 2002 16:35:57 +0200
From: Mike Galbraith <EFAULT@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Win95; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
CC: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>,
       Gilad Ben-Yossef <gilad@benyossef.com>, linux-kernel@vger.kernel.org
Subject: Re: Alloc and lock down large amounts of memory
References: <Pine.LNX.4.44.0208211528180.3407-100000@pc40.e18.physik.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Kuhn wrote:

>On Wed, 21 Aug 2002, Mike Galbraith wrote:
>
>>At 03:08 PM 8/20/2002 -0500, Bhavana Nagendra wrote:
>>
>>>>Curiosity:  why do you want to do device DMA buffer
>>>>allocation from userland?
>>>>
>>>I need 256M memory for a graphics operation.  It's a requiremment,
>>>can't change it. There will be other reasonably sized allocs in kernel
>>>space, this is a special case that will be done from userland. As
>>>discussed earlier in this thread, there's no good way of alloc()ing
>>>and pinning that much in DMA memory space, is there?
>>>
>>Not that I know of.  It seems to me that any interface that tried
>>to provide this would have to know what kind of device is going
>>to DMA from/to that ram.
>>
>>Usually, when someone needs a large gob of contiguous ram,
>>folks suggest doing the allocation in kernel, and early.
>>
>BTW: What is the limit for pci_alloc_consistent and friends? Can it really 
>provide 256MB?
>

Dunno.  The page allocator however (lowest) can deliver 1 << MAX_ORDER 
contiguous
pages per request.. unless fragmentation gets you that is, so I doubt 
it's remotely possible
to get 256MB of _physically_ contiguous ram without doing early 
allocation of some sort.
(bootmem, bigphysarea patches or whatnot)

    -Mike



