Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbVI3PSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbVI3PSp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbVI3PSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:18:45 -0400
Received: from quark.didntduck.org ([69.55.226.66]:23178 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1030328AbVI3PSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:18:44 -0400
Message-ID: <433D57AE.9080103@didntduck.org>
Date: Fri, 30 Sep 2005 11:20:14 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arijit Das <Arijit.Das@synopsys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: RH30: Virtual Mem shot heavily by locale-archive...
References: <7EC22963812B4F40AE780CF2F140AFE9168304@IN01WEMBX1.internal.synopsys.com>
In-Reply-To: <7EC22963812B4F40AE780CF2F140AFE9168304@IN01WEMBX1.internal.synopsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arijit Das wrote:
> I have RH3.0 installed in an AMD64 machine. 
>  
> In this system, when I look at the virtual address space mappings of a process (say a sleep process), I find that almost 80% of its virtual address space has been taken by a private copy of /usr/lib/locale/locale-archive mapped to its virtual address space by default. Check this:
>  
>      31396 KB    r--p    /usr/lib/locale/locale-archive
>  

Only the pages of the file that are actually accessed are loaded into 
physical memory.  This mapping just reserves a slot of virtual memory 
for those demand loaded pages to be mapped.

> Total Virtual Memory = 38816 KB
> On the other hand, when I look at the same info in a RH7.2 system, I see that a few small set of essential locale files have been mapped whose overall summed up size is around 236KB (way smaller than RH3.0)...Check this: 
>          4    r--p    /usr/lib/locale/en_US/LC_IDENTIFICATION
>          4    r--p    /usr/lib/locale/en_US/LC_MEASUREMENT
>          4    r--p    /usr/lib/locale/en_US/LC_TELEPHONE
>          4    r--p    /usr/lib/locale/en_US/LC_ADDRESS
>          4    r--p    /usr/lib/locale/en_US/LC_NAME
>          4    r--p    /usr/lib/locale/en_US/LC_PAPER
>          4    r--p    /usr/lib/locale/en_US/LC_MESSAGES/SYS_LC_MESSAGES
>          4    r--p    /usr/lib/locale/en_US/LC_MONETARY
>         24    r--p    /usr/lib/locale/en_US/LC_COLLATE
>          4    r--p    /usr/lib/locale/en_US/LC_TIME
>          4    r--p    /usr/lib/locale/en_US/LC_NUMERIC
>        172    r--p    /usr/lib/locale/en_US/LC_CTYPE
> This seems like a huge requirement of memory for each small process executed in the RH3.0 system and hence, shots up the memory requirement of the entire system because the mapped region /usr/lib/locale/locale-archive is privately mapped.

Private mapping means copy-on-write.  But since these mappings are 
read-only they will still be shared by other users of that file.  So no 
extra physical memory for each process mapping the file.

--
				Brian Gerst
