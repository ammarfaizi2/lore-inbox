Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbTDUP2s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbTDUP2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:28:48 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:29624 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261335AbTDUP2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:28:46 -0400
Message-ID: <3EA410F4.2050809@colorfullife.com>
Date: Mon, 21 Apr 2003 17:40:36 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Junfeng Yang <yjf@stanford.edu>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER]  Help Needed!
References: <3EA3B87B.60505@colorfullife.com.suse.lists.linux.kernel> <p7365p8x8qu.fsf@oldwotan.suse.de>
In-Reply-To: <p7365p8x8qu.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Manfred Spraul <manfred@colorfullife.com> writes:
> 
>  
>
>>P.S.: On i386, you can access both kernel and user space after
>>set_fs(KERNEL_DS), or if you use __get_user() and bypass
>>access_ok(). Thus the __get_user() in arch/i386/kernel/traps.c,
>>function show_registers is correct. This is the only instance I'm
>>aware of where this is used, and noone else should be doing that. It
>>fails on other archs, e.g. on sparc.
>>    
>>
>
>It is used in a couple more of places in the x86-64 architecture specific
>code. Of course it is legal there too.
>
>Also there are some corner cases; e.g. some architecture specific
>code (particularly the 32bit emulations) just does access_ok or 
>get_user/put_user (with implied access_ok) on the first element 
>of a structure and then accesses the other elements with __*_user.
>This works because these architectures have an unmapped hole at the 
>end of the user address space.
>  
>
This is different bug:
- bug 1 is access user space without the functions from <asm/uaccess.h>, 
or access user space after set_fs(KERNEL_DS), or access kernel space 
without set_fs(KERNEL_DS).
- bug 2 is not enough access_ok() calls, e.g. __put_user without a 
preceeding access_ok() check, either explicit or implicit due to an 
copy_from_user().

--
    Manfred


