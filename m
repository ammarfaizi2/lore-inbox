Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269198AbUISJbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269198AbUISJbh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 05:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269200AbUISJbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 05:31:34 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:32949 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S269198AbUISJbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 05:31:03 -0400
Message-ID: <414D4631.4030809@free.fr>
Date: Sun, 19 Sep 2004 10:41:21 +0200
From: Remi Colinet <remi.colinet@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cyril Wattebled <neurowork@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: init_tss problem
References: <414CBCE0.5000508@free.fr>
In-Reply-To: <414CBCE0.5000508@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cyril Wattebled wrote:

> Hi,
> I'm trying to understand some piece of kernel code and I've come to 
> this :
> In arch/i386/kernel/process.c:
>     struct tss_struct *tss = &per_cpu(init_tss, cpu);
> I don't know what init_tss is.
> It's defined in asm/processor.h with the macro DEFINE_PER_CPU 
> (tss_struct, init_tss)
> which basically does extern tss_struct init_tss.
> But this init_tss has to be declared somewhere to be used as extern ...
> I've searched the entire code for any reference to it but I only found 
> it in
> arch/x86_64/kernel/init_task.c which is normaly not compiled on my 
> system.
> I'm in a dead end ... anyone .. help ?
> Thanks

TSS is a Task State Segment. It is defined in include/asm-i386/processor.h.
init_tss is the Task State Segment used by the statically forked init 
process. (process 0)

Each CPU has its own tss.

This segment is used by i386 and x86_64 CPUs to store the CPU/process 
context. Could be used to have hardware context switch (not used by Linux).

In order to have a clean understanding about TSS (and more generally 
i386), you should have a look at the i386 Intel specifiction, manual vol 
3 (system programming manual)
Then, you could also read the AMD64 specification if you wish to 
understand x86_64...

Regards
Remi

