Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbWEaVF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbWEaVF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbWEaVF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:05:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965003AbWEaVFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:05:39 -0400
Date: Wed, 31 May 2006 14:08:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@google.com>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060531140823.580dbece.akpm@osdl.org>
In-Reply-To: <447DEF47.6010908@google.com>
References: <447DEF47.6010908@google.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh <mbligh@google.com> wrote:
>
> Another panic. This time on x440.
> 
> M.
> 
> http://test.kernel.org/abat/33803/debug/console.log
> 
> BUG: unable to handle kernel paging request at virtual address 22222232
>   printing eip:
> c012b6eb
> *pde = 15621001
> *pte = 00000000
> Oops: 0000 [#1]
> SMP
> last sysfs file: /class/vc/vcs1/dev
> CPU:    1
> EIP:    0060:[<c012b6eb>]    Not tainted VLI
> EFLAGS: 00010002   (2.6.17-rc5-mm1-autokern1 #1)
> EIP is at check_deadlock+0x15/0xe0
> eax: 22222222   ebx: 00000001   ecx: d4996000   edx: 00000001
> esi: d686f550   edi: 22222222   ebp: 22222222   esp: d5bdfec8
> ds: 007b   es: 007b   ss: 0068
> Process mkdir09 (pid: 18867, threadinfo=d5bdf000 task=d5c0e000)
> Stack: 00000000 d686f550 d3960568 22222222 c012b77b d3960568 d5bdf000 
> d5bdff00
>         d5c0e000 c012b922 d5bdff48 d3960568 00000246 c02d50de d5bdff00 
> d5bdff00
>         11111111 11111111 d5bdff00 ffffff9c d5bdff48 00000000 d5bdff48 
> ffffffef
> Call Trace:
>   <c012b77b> check_deadlock+0xa5/0xe0  <c012b922> 
> debug_mutex_add_waiter+0x46/0x55
>   <c02d50de> __mutex_lock_slowpath+0x9e/0x1c0  <c0160061> 
> lookup_create+0x19/0x5b
>   <c016043a> sys_mkdirat+0x4c/0xc3  <c01604c0> sys_mkdir+0xf/0x13
>   <c02d6217> syscall_call+0x7/0xb

Looks like the lock validator came unstuck.  But there's so much other crap
happening in there it's hard to tell.  Did you try it without all the
lockdep stuff enabled?

