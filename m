Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265158AbTIEW2v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 18:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265208AbTIEW2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 18:28:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:32763 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265158AbTIEW2s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 18:28:48 -0400
Message-ID: <3F590D85.20803@mvista.com>
Date: Fri, 05 Sep 2003 15:26:13 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take
 2
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D224@fmsmsx405.fm.intel.com>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1902C7D224@fmsmsx405.fm.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
> 
> 
>>-----Original Message-----
>>From: Andrew Morton [mailto:akpm@osdl.org] 
>>
>>We seem to keep on proliferating home-grown x86 64-bit math functions.
>>
>>Do you really need these?  Is it possible to use do_div() and 
>>the C 64x64
>>`*' operator instead?
>>
> 
> 
> 
> We can change these handcoded 64 bit divs to do_div, with just an
> additional data copy 

We already have this in .../include/asm-i386/div64.h.  Check usage in 
.../posix-timers.c to cover archs that have not yet included it in 
there div64.h.

> (as do_div changes dividend in place). But, changing mul into 64x64 '*'
> may be tricky. 
> Gcc seem to generate a combination of mul, 2imul and add, where as we
> are happy with 
> using only one mull here.

You just need to do the right casting.  It should like 
u64=u32*(u64)u32  as in .../kernel/posix-timers.c.  This could also be 
signed with the same results.  If you really need to do a u64*u32, it 
will do that as well but takes two mpys.  In this case you will need 
to do it unsigned to eliminate the third mpy.
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

