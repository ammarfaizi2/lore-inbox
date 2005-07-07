Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVGGVYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVGGVYA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVGGVVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:21:36 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:13468 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261545AbVGGVUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:20:52 -0400
Message-ID: <42CD9CA8.5080807@us.ibm.com>
Date: Thu, 07 Jul 2005 14:20:40 -0700
From: Vara Prasad <prasadav@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, prasanna@in.ibm.com, davem@davemloft.net,
       systemtap@sources.redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [1/6 PATCH] Kprobes : Prevent possible race conditions generic
 changes
References: <20050707101015.GE12106@in.ibm.com> <20050707032537.7588acb9.akpm@osdl.org> <20050707103421.GU21330@wotan.suse.de>
In-Reply-To: <20050707103421.GU21330@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>On Thu, Jul 07, 2005 at 03:25:37AM -0700, Andrew Morton wrote:
>  
>
>>Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
>>    
>>
>>>There are possible race conditions if probes are placed on routines within the
>>>kprobes files and routines used by the kprobes.
>>>      
>>>
>>So...  don't do that then?  Is it likely that anyone would want to stick a
>>probe on the kprobe code itself?
>>    
>>
>
>iirc one goal of systemtap (which uses kprobes) is to be provable
>safe so that an user cannot crash the kernel by adding probes. Basically
>to make it possible to use this on production systems safely. I have my
>doubts they will fully reach it, but at least it's a nice goal.
>  
>
Yes, you are right it is a lofty goal but we feel we can achieve this 
with safety features built into the system. To facilitate this we are 
providing two modes safe and guru. In safe mode we are trying to limit 
the user to do limited yet useful operations so that they don't 
compromise the integrity of the system. Guru mode is meant for power 
users where we expect the users to know what they are doing hence they 
can do more intrusive operations. Another feature we are doing is coming 
up with a library of routines for common needs. Users can activate these 
routines with a simple scripting language so that they don't write their 
own kernel modules, this limits their ability to compromise the 
integrity of the system. We expect users to use this method 
predominantly in the safe mode.

>  
>
>>>-int register_kprobe(struct kprobe *p)
>>>+static int __kprobes in_kprobes_functions(unsigned long addr)
>>>+{
>>>+	/* Linker adds these: start and end of __kprobes functions */
>>>+	extern char __kprobes_text_start[], __kprobes_text_end[];
>>>      
>>>
>>There's an old unix convention that section markers (start, end, edata,
>>etc) are declared `int'.  For some reason we don't do that in the kernel. 
>>Oh well.
>>    
>>
>
>The Linux convention is to put it into asm-generic/sections.h at least.
>
>-Andi
>
>  
>


