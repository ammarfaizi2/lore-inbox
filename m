Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318108AbSFTDeo>; Wed, 19 Jun 2002 23:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318109AbSFTDen>; Wed, 19 Jun 2002 23:34:43 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:39595 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S318108AbSFTDen>; Wed, 19 Jun 2002 23:34:43 -0400
Message-ID: <3D114C27.4000801@quark.didntduck.org>
Date: Wed, 19 Jun 2002 23:29:43 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: devnull@adc.idt.com
CC: linux-kernel@vger.kernel.org
Subject: Re: >3G Memory support
References: <Pine.GSO.4.31.0206191818370.13822-100000@bom.adc.idt.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devnull@adc.idt.com wrote:
> Hello All.
> 
> I have a PC with 4G of Memory and would like a process to be able to
> address all 4G of memory.
> 
> I am running 2.4.13-ac8
> 
> The way i understand it is that linux shares the top 1G of process address
> space with all processes on the system(so on systems with 4G is physical
> addressability, it leaves 3G for each process).
> 
>>From the archives, i learnt that i need to modify __PAGE_OFFSET and change
> it from the default  (0xC0000000).
> 
> Looking at /usr/src/linux/include/asm-i386/page.h
> 
> <<SNIP>>
> /*
>  * This handles the memory map.. We could make this a config
>  * option, but too many people screw it up, and too few need
>  * it.
>  *
>  * A __PAGE_OFFSET of 0xC0000000 means that the kernel has
>  * a virtual address space of one gigabyte, which limits the
>  * amount of physical memory you can use to about 950MB.
>  *
>  * If you want more physical memory than this then see the
>  *   CONFIG_HIGHMEM4G
>  * and CONFIG_HIGHMEM64G options in the kernel configuration.
>  */
> 
> <<END_OF_SNIP>>
> 
> When i compiled my kernel, i set CONFIG_HIGHMEM4G.
> 
> Does this mean that all my programs should be able to address 4G ?

No.  It means the kernel can access all 4GB of memory.  For memory above 
the 950MB that it can directly map, it needs to use dynamic mappings 
(kmap).  User space is always 3GB virtual space per process, regardless 
of the highmem setting.

--
				Brian Gerst

