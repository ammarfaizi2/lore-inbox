Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbVLVIn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbVLVIn4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 03:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbVLVIn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 03:43:56 -0500
Received: from mailserv.intranet.GR ([146.124.14.106]:39888 "EHLO
	mailserv.intranet.gr") by vger.kernel.org with ESMTP
	id S965137AbVLVInz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 03:43:55 -0500
Message-ID: <43AA65F4.10409@intracom.gr>
Date: Thu, 22 Dec 2005 10:38:12 +0200
From: Pantelis Antoniou <panto@intracom.gr>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051101)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
CC: jes@trained-monkey.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] genalloc != generic DEVICE memory allocator
References: <43A98F90.9010001@varma-el.com>
In-Reply-To: <43A98F90.9010001@varma-el.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Volkov wrote:
> Hello Jes and all
> 
> I try to use your allocator (gen_pool_xxx), idea of which
> is a cute nice thing. But current implementation of it is
> inappropriate for a _device_ (aka onchip, like framebuffer) memory
> allocation, by next reasons:
> 
>  1) Device memory is expensive resource by access time and/or size cost.
>     So we couldn't use (usually) this memory for the free blocks lists.
>  2) Device memory usually have special requirement of access to it
>     (alignment/special insn). So we couldn't use part of allocated
>     blocks for some control structures (this problem solved in your
>     implementation, it's common remark)
>  3) Obvious (IMHO) workflow of mem. allocator look like:
>  	- at startup time, driver allocate some big
> 	  (almost) static mem. chunk(s) for a control/data structures.
>         - during work of the device, driver allocate many small
> 	  mem. blocks with almost identical size.
>     such behavior lead to degeneration of buddy method and
>     transform it to the first/best fit method (with long seek
>     by the free node list).
>  4) The simple binary buddy method is far away from perfect for a device
>     due to a big internal fragmentation. Especially for a
>     network/mfd devices, for which, size of allocated data very
>     often is not a power of 2.
> 
> I start to modify your code to satisfy above demands,
> but firstly I wish to know your, or somebody else, opinion.
> 
> Especially I will very happy if somebody have and could
> provide to all, some device specific memory usage statistics.
> 

Hi Andrey,

FYI, on arch/ppc/lib/rheap.c theres an implementation of a remote heap.

It is currently used for the management of freescale's CPM1 & CPM2 internal
dual port RAM.

Take a look, it might be what you have in mind.

Regards

Pantelis

