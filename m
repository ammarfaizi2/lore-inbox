Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTKRHWN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 02:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTKRHWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 02:22:12 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:41601
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262373AbTKRHWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 02:22:05 -0500
Date: Tue, 18 Nov 2003 02:21:06 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
In-Reply-To: <Pine.LNX.4.53.0311171813410.30079@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0311180215040.11537@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0311171441380.8840-100000@home.osdl.org>
 <Pine.LNX.4.53.0311171749590.30079@montezuma.fsmlabs.com>
 <Pine.LNX.4.53.0311171813410.30079@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, Zwane Mwaikambo wrote:

> A little bird told me to send diffs... But there is a lot of noise due to 
> offsets i'm afraid.

Another note from our avian friends; i seem to have sent a slightly 
different dump from the patch, although they do both achieve the same 
effect. I shall append it for completeness.

0x0210e860 <do_sys_vm86+0>:     push   %edi
0x0210e861 <do_sys_vm86+1>:     mov    $0xffffe000,%eax
0x0210e866 <do_sys_vm86+6>:     push   %esi
0x0210e867 <do_sys_vm86+7>:     and    %esp,%eax
0x0210e869 <do_sys_vm86+9>:     push   %ebx
0x0210e86a <do_sys_vm86+10>:    mov    0x10(%esp,1),%edi
0x0210e86e <do_sys_vm86+14>:    mov    0x14(%esp,1),%esi
0x0210e872 <do_sys_vm86+18>:    movl   $0x0,0x1c(%edi)
0x0210e879 <do_sys_vm86+25>:    movl   $0x0,0x20(%edi)
0x0210e880 <do_sys_vm86+32>:    mov    (%eax),%edx
0x0210e882 <do_sys_vm86+34>:    mov    0x30(%edi),%eax
0x0210e885 <do_sys_vm86+37>:    mov    %eax,0x5b8(%edx)
0x0210e88b <do_sys_vm86+43>:    mov    0x30(%edi),%edx
0x0210e88e <do_sys_vm86+46>:    mov    0xbc(%edi),%eax
0x0210e894 <do_sys_vm86+52>:    and    $0xdd5,%edx
0x0210e89a <do_sys_vm86+58>:    mov    %edx,0x30(%edi)
0x0210e89d <do_sys_vm86+61>:    mov    0x30(%eax),%eax
0x0210e8a0 <do_sys_vm86+64>:    and    $0xfffff22a,%eax
0x0210e8a5 <do_sys_vm86+69>:    or     %eax,%edx
0x0210e8a7 <do_sys_vm86+71>:    mov    0x54(%edi),%eax
0x0210e8aa <do_sys_vm86+74>:    or     $0x20000,%edx
0x0210e8b0 <do_sys_vm86+80>:    cmp    $0x3,%eax
0x0210e8b3 <do_sys_vm86+83>:    mov    %edx,0x30(%edi)
0x0210e8b6 <do_sys_vm86+86>:    je     0x210e9f0 <do_sys_vm86+400>
0x0210e8bc <do_sys_vm86+92>:    cmp    $0x3,%eax
0x0210e8bf <do_sys_vm86+95>:    ja     0x210e9d5 <do_sys_vm86+373>
0x0210e8c5 <do_sys_vm86+101>:   cmp    $0x2,%eax
0x0210e8c8 <do_sys_vm86+104>:   je     0x210e9c6 <do_sys_vm86+358>
0x0210e8ce <do_sys_vm86+110>:   movl   $0x247000,0x5bc(%esi)
0x0210e8d8 <do_sys_vm86+120>:   mov    0xbc(%edi),%eax
0x0210e8de <do_sys_vm86+126>:   movl   $0x0,0x18(%eax)
0x0210e8e5 <do_sys_vm86+133>:   mov    0x360(%esi),%eax
0x0210e8eb <do_sys_vm86+139>:   mov    %eax,0x5c0(%esi)
0x0210e8f1 <do_sys_vm86+145>:   movl   %fs,0x5c4(%esi)
0x0210e8f7 <do_sys_vm86+151>:   movl   %gs,0x5c8(%esi)
0x0210e8fd <do_sys_vm86+157>:   mov    $0xffffe000,%ebx
0x0210e902 <do_sys_vm86+162>:   and    %esp,%ebx
0x0210e904 <do_sys_vm86+164>:   mov    0x14(%ebx),%eax
0x0210e907 <do_sys_vm86+167>:   inc    %eax
0x0210e908 <do_sys_vm86+168>:   mov    %eax,0x14(%ebx)
0x0210e90b <do_sys_vm86+171>:   mov    0x10(%ebx),%eax
0x0210e90e <do_sys_vm86+174>:   mov    0x4(%esi),%edx
0x0210e911 <do_sys_vm86+177>:   shl    $0x9,%eax
0x0210e914 <do_sys_vm86+180>:   lea    0x26ff000(%eax),%ecx
0x0210e91a <do_sys_vm86+186>:   lea    0x4c(%edi),%eax
0x0210e91d <do_sys_vm86+189>:   mov    %eax,0x360(%esi)
0x0210e923 <do_sys_vm86+195>:   sub    0x1c(%edx),%eax
0x0210e926 <do_sys_vm86+198>:   add    0x20(%edx),%eax
0x0210e929 <do_sys_vm86+201>:   mov    %eax,0x4(%ecx)
0x0210e92c <do_sys_vm86+204>:   mov    0x25fe52c,%eax
0x0210e931 <do_sys_vm86+209>:   test   $0x800,%eax
0x0210e936 <do_sys_vm86+214>:   je     0x210e942 <do_sys_vm86+226>
0x0210e938 <do_sys_vm86+216>:   movl   $0x0,0x364(%esi)
0x0210e942 <do_sys_vm86+226>:   lea    0x340(%esi),%edx
0x0210e948 <do_sys_vm86+232>:   mov    0x20(%edx),%eax
0x0210e94b <do_sys_vm86+235>:   mov    %eax,0x4(%ecx)
0x0210e94e <do_sys_vm86+238>:   mov    0x10(%ecx),%ax
0x0210e952 <do_sys_vm86+242>:   and    $0xffff,%eax
0x0210e957 <do_sys_vm86+247>:   cmp    0x24(%edx),%eax
0x0210e95a <do_sys_vm86+250>:   jne    0x210e9b0 <do_sys_vm86+336>
0x0210e95c <do_sys_vm86+252>:   mov    0x14(%ebx),%eax
0x0210e95f <do_sys_vm86+255>:   dec    %eax
0x0210e960 <do_sys_vm86+256>:   mov    %eax,0x14(%ebx)
0x0210e963 <do_sys_vm86+259>:   mov    0x8(%ebx),%eax
0x0210e966 <do_sys_vm86+262>:   and    $0x8,%eax
0x0210e969 <do_sys_vm86+265>:   jne    0x210e9a9 <do_sys_vm86+329>
0x0210e96b <do_sys_vm86+267>:   mov    0x50(%edi),%eax
0x0210e96e <do_sys_vm86+270>:   mov    %eax,0x5b4(%esi)
0x0210e974 <do_sys_vm86+276>:   testb  $0x1,0x4c(%edi)
0x0210e978 <do_sys_vm86+280>:   jne    0x210e9a0 <do_sys_vm86+320>
0x0210e97a <do_sys_vm86+282>:   push   $0x255f121
0x0210e97f <do_sys_vm86+287>:   call   0x21285a0 <printk>
0x0210e984 <do_sys_vm86+292>:   mov    0x4(%esi),%edx
0x0210e987 <do_sys_vm86+295>:   xor    %eax,%eax
0x0210e989 <do_sys_vm86+297>:   mov    %eax,%fs
0x0210e98b <do_sys_vm86+299>:   mov    %eax,%gs
0x0210e98d <do_sys_vm86+301>:   mov    %edi,%esp
0x0210e98f <do_sys_vm86+303>:   mov    %edx,%ebp
0x0210e991 <do_sys_vm86+305>:   jmp    0xfffeb100 <resume_userspace>
0x0210e996 <do_sys_vm86+310>:   pop    %esi
0x0210e997 <do_sys_vm86+311>:   pop    %ebx
0x0210e998 <do_sys_vm86+312>:   pop    %esi
0x0210e999 <do_sys_vm86+313>:   pop    %edi
0x0210e99a <do_sys_vm86+314>:   ret
0x0210e99b <do_sys_vm86+315>:   nop
0x0210e99c <do_sys_vm86+316>:   lea    0x0(%esi,1),%esi
0x0210e9a0 <do_sys_vm86+320>:   push   %esi
0x0210e9a1 <do_sys_vm86+321>:   call   0x210e5b0 <mark_screen_rdonly>
0x0210e9a6 <do_sys_vm86+326>:   pop    %eax
0x0210e9a7 <do_sys_vm86+327>:   jmp    0x210e97a <do_sys_vm86+282>
0x0210e9a9 <do_sys_vm86+329>:   call   0x21222d0 <preempt_schedule>
0x0210e9ae <do_sys_vm86+334>:   jmp    0x210e96b <do_sys_vm86+267>
0x0210e9b0 <do_sys_vm86+336>:   mov    0x24(%edx),%ax
0x0210e9b4 <do_sys_vm86+340>:   mov    %ax,0x10(%ecx)
0x0210e9b8 <do_sys_vm86+344>:   mov    $0x174,%ecx
0x0210e9bd <do_sys_vm86+349>:   mov    0x24(%edx),%eax
0x0210e9c0 <do_sys_vm86+352>:   xor    %edx,%edx
0x0210e9c2 <do_sys_vm86+354>:   wrmsr
0x0210e9c4 <do_sys_vm86+356>:   jmp    0x210e95c <do_sys_vm86+252>
0x0210e9c6 <do_sys_vm86+358>:   movl   $0x0,0x5bc(%esi)
0x0210e9d0 <do_sys_vm86+368>:   jmp    0x210e8d8 <do_sys_vm86+120>
0x0210e9d5 <do_sys_vm86+373>:   cmp    $0x4,%eax
0x0210e9d8 <do_sys_vm86+376>:   jne    0x210e8ce <do_sys_vm86+110>
0x0210e9de <do_sys_vm86+382>:   movl   $0x47000,0x5bc(%esi)
0x0210e9e8 <do_sys_vm86+392>:   jmp    0x210e8d8 <do_sys_vm86+120>
0x0210e9ed <do_sys_vm86+397>:   lea    0x0(%esi),%esi
0x0210e9f0 <do_sys_vm86+400>:   movl   $0x7000,0x5bc(%esi)
0x0210e9fa <do_sys_vm86+410>:   jmp    0x210e8d8 <do_sys_vm86+120>
