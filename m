Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSE2XOc>; Wed, 29 May 2002 19:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315718AbSE2XOb>; Wed, 29 May 2002 19:14:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57618 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315717AbSE2XO3>;
	Wed, 29 May 2002 19:14:29 -0400
Message-ID: <3CF56062.4010102@mandrakesoft.com>
Date: Wed, 29 May 2002 19:12:34 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, davej@suse.de
Subject: Re: [PATCH] intel-x86 model config cleanup
In-Reply-To: <20020529143544.GA2224@werewolf.able.es> <3CF53C03.5040301@mandrakesoft.com> <3CF53C34.2080300@mandrakesoft.com> <20020529224423.GA3174@werewolf.able.es> <3CF55C3D.6030008@mandrakesoft.com> <20020529230644.GC3174@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

>On 2002.05.30 Jeff Garzik wrote:
>  
>
>>The basic thing to remember is that "generic_foo" or "cpu_intel_foo" 
>>options should very rarely, if ever, appear in the config.in or sources. 
>>We simply want to use the generic or cpu-specific user selection to 
>>determine (a) compiler flags, (b) CONFIG_xxx symbols for specific CPU 
>>features and optimizations, [like CONFIG_X86_F00F_BUG] and maybe (c) 
>>enable and disable CPU-specific drivers.  (c) will be a special case, 
>>since very few drivers should require a specific CPU type... but some 
>>drivers simply don't work on 386.
>>
>>    
>>
>
>Grep on the tree showed this:
>
>drivers/char/serial.c:
>
>#if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
>#define SERIAL_INLINE
>#endif
>
>include/asm-i386/processor.h:
>
>/* Prefetch instructions for Pentium III and AMD Athlon */
>#ifdef  CONFIG_MPENTIUMIII
>
>#define ARCH_HAS_PREFETCH
>  
>


ARCH_HAS_foo are feature symbols, just like CONFIG_X86_F00F_BUG, so 
those are fine. They're just cross-architecture, but perform the same 
task: feature dis/enabling.  For the serial example, you'd just need to 
make sure the net effect of the code is the same, both before and after 
an x86 config.in cleanup.

    Jeff



