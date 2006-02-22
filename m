Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWBVUOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWBVUOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWBVUOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:14:37 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:41118 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751396AbWBVUOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:14:36 -0500
Message-ID: <43FCC62A.4070704@acm.org>
Date: Wed, 22 Feb 2006 14:14:34 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with NETIF_F_HIGHDMA
References: <43FCB1B3.8090101@acm.org> <1140634261.2979.59.camel@laptopd505.fenrus.org>
In-Reply-To: <1140634261.2979.59.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Wed, 2006-02-22 at 12:47 -0600, Corey Minyard wrote:
>  
>
>>I was looking at a problem with a new system we are trying to get up and
>>running.  It has a 32-bit only PCI network device, but is a 64-bit
>>(x86_64) system.  Looking at the code for NETIF_F_HIGHDMA (which, when
>>not set on a PCI network device, means that it cannot do 64-bit
>>accesses) in net/core/dev.c, it seems wrong to me.
>>
>>It is dependent on HIGHMEM, but HIGHMEM has nothing to do with 32/64 bit
>>accesses.  On 64-bit systems, HIGHMEM is not set, thus the network code
>>will pass any address (including those >32bits) to the driver.  Plus,
>>highmem on 32-bit systems may very well be 32-bit accessible, possibly
>>resulting in unecessary copies.  AFAICT, the current code will only work
>>with i386 and PAE and is sub-optim
>>    
>>
>
>you use the PCI mapping api right? if you do that then there's no
>problem, after pci mapping the addresses will be in the lower address
>range perfectly fine....
>  
>
Ah, cool, physical memory remapping.  Then the problem lies elsewhere. 
Thanks.

-Corey
