Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWETKIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWETKIF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 06:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWETKIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 06:08:05 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:23054 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964790AbWETKIE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 06:08:04 -0400
Message-ID: <446EE992.4020604@vmware.com>
Date: Sat, 20 May 2006 03:04:02 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, torvalds@osdl.org, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       kraxel@suse.de
Subject: Re: [patch] i386, vdso=[0|1] boot option and /proc/sys/vm/vdso_enabled
References: <1147759423.5492.102.camel@localhost.localdomain>	<20060516064723.GA14121@elte.hu>	<1147852189.1749.28.camel@localhost.localdomain>	<20060519174303.5fd17d12.akpm@osdl.org>	<20060520010303.GA17858@elte.hu>	<20060519181125.5c8e109e.akpm@osdl.org>	<Pine.LNX.4.64.0605191813050.10823@g5.osdl.org>	<20060520085351.GA28716@elte.hu>	<20060520022650.46b048f8.akpm@osdl.org>	<446EE1C2.7060400@vmware.com> <20060520024842.69c77aaf.akpm@osdl.org>
In-Reply-To: <20060520024842.69c77aaf.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Zachary Amsden <zach@vmware.com> wrote:
>   
>> Please try my patch - sent earlier, but attached again.  It will tell 
>>  you with 100% confidence if the problem is with userspace expecting the 
>>  vsyscall page to be at a particular address.
>>
>>
>> [bogo-fixmap  text/plain (645 bytes)]
>>
>>  Index: linux-2.6.17-rc/include/asm-i386/fixmap.h
>>  ===================================================================
>>  --- linux-2.6.17-rc.orig/include/asm-i386/fixmap.h	2006-03-19 21:53:29.000000000 -0800
>>  +++ linux-2.6.17-rc/include/asm-i386/fixmap.h	2006-05-19 18:16:00.000000000 -0700
>>  @@ -20,7 +20,7 @@
>>    * Leave one empty page between vmalloc'ed areas and
>>    * the start of the fixmap.
>>    */
>>  -#define __FIXADDR_TOP	0xfffff000
>>  +#define __FIXADDR_TOP	0xffbff000
>>     
>
> The machine runs OK with that applied and with
> move-vsyscall-page-out-of-fixmap-into-normal-vma-as-per-mmap.patch not
> applied.
>   

Err.  That implies that there is likely a problem in the kernel patch, 
not in userspace,  Let's look more closely at 
move-vsyscall-page-out-of-fixmap-into-normal-vma-as-per-mmap and see if 
there is something missing.

Zach
