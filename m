Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWETBQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWETBQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 21:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWETBQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 21:16:46 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:5900 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964783AbWETBQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 21:16:46 -0400
Message-ID: <446E6DFC.5010808@vmware.com>
Date: Fri, 19 May 2006 18:16:44 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       virtualization@lists.osdl.org, kraxel@suse.de
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
 patch
References: <1147759423.5492.102.camel@localhost.localdomain>	<20060516064723.GA14121@elte.hu>	<1147852189.1749.28.camel@localhost.localdomain>	<20060519174303.5fd17d12.akpm@osdl.org>	<20060520010303.GA17858@elte.hu> <20060519181125.5c8e109e.akpm@osdl.org>
In-Reply-To: <20060519181125.5c8e109e.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040108080305040404040004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040108080305040404040004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
>   
>> * Andrew Morton <akpm@osdl.org> wrote:
>>
>>     
>>> Rusty Russell <rusty@rustcorp.com.au> wrote:
>>>       
>>>> Name: Move vsyscall page out of fixmap into normal vma as per mmap
>>>>         
>>> This causes mysterious hangs when starting init.
>>>
>>> Distro is RH FC1, running SysVinit-2.85-5.
>>>
>>> dmesg, sysrq-T and .config are at
>>> http://www.zip.com.au/~akpm/linux/patches/stuff/log-vmm - nothing leaps
>>> out.
>>>
>>> This is the second time recently when a patch has caused this machine 
>>> to oddly hang in init.  It's possible that there's a bug of some form 
>>> in that version of init that we'll need to know about and take care of 
>>> in some fashion.
>>>       
>> FC1 is like really ancient. I think there was a glibc bug that caused 
>> vsyscall related init hangs like that. To nevertheless let people run 
>> their old stuff there's a vdso=0 boot option in exec-shield.
>>
>>     
>
> Well that patch took a machine from working to non-working.  Pretty serious
> stuff.  We should get to the bottom of the problem so we can assess the
> risk and impact, no?

An easy test for culpability of kernel vs. init would be to back out all 
patches and recompile the kernel with vsyscall moved down by 4 megs.



--------------040108080305040404040004
Content-Type: text/plain;
 name="bogo-fixmap"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bogo-fixmap"


Index: linux-2.6.17-rc/include/asm-i386/fixmap.h
===================================================================
--- linux-2.6.17-rc.orig/include/asm-i386/fixmap.h	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.17-rc/include/asm-i386/fixmap.h	2006-05-19 18:16:00.000000000 -0700
@@ -20,7 +20,7 @@
  * Leave one empty page between vmalloc'ed areas and
  * the start of the fixmap.
  */
-#define __FIXADDR_TOP	0xfffff000
+#define __FIXADDR_TOP	0xffbff000
 
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>

--------------040108080305040404040004--
