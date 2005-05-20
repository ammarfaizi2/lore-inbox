Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVETLbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVETLbF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 07:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVETLbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 07:31:05 -0400
Received: from smtp1.pochta.ru ([81.211.64.6]:6451 "EHLO smtp1.pochta.ru")
	by vger.kernel.org with ESMTP id S261419AbVETLau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 07:30:50 -0400
X-Author: graycardinal@pisem.net from dialup42.sibintercom.ru (dialup42.sibintercom.ru [62.76.132.42] (may be forged)) via Free Mail POCHTA.RU
From: Oleg <graycardinal@pisem.net>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re[2]: PROBLEM: kmem_cache_create: duplicate cache fat_cache
Date: Fri, 20 May 2005 18:31:27 +0400
User-Agent: KMail/1.5.4
References: <200505181217.29904.graycardinal@pisem.net> <87br779jen.fsf@devron.myhome.or.jp>
In-Reply-To: <87br779jen.fsf@devron.myhome.or.jp>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505201831.27842.graycardinal@pisem.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 May 2005 22:10, you wrote:
> Oleg <graycardinal@pisem.net> writes:
> > [1.] kmem_cache_create: duplicate cache fat_cache
> > [2.] When I load module vfat, I'm have BUG. vfat is embedded in my
> > kernel. [3.] modules
> > [4.] Linux version 2.6.12-rc3-mm3 (root@localhost.localdomain) (gcc
> > version 3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #18 SMP
> > [5.] kmem_cache_create: duplicate cache fat_cache
> > ------------[ cut here ]------------
> > kernel BUG at mm/slab.c:1491!
> > invalid operand: 0000 [#1]
> > PREEMPT SMP
> > Modules linked in: fat nls_utf8 nls_cp866 nls_cp855 video hotkey
> > CPU:    0
> > EIP:    0060:[<c014a38f>]    Not tainted VLI
> > EFLAGS: 00010202   (2.6.12-rc3-mm3)
> > EIP is at kmem_cache_create+0x45f/0x5e0
> > eax: 00000030   ebx: f7d187b4   ecx: 0000000d   edx: 00000202
> > esi: c03c91ef   edi: f885ed6e   ebp: f7de1580   esp: f74d1f44
> > ds: 007b   es: 007b   ss: 0068
> > Process modprobe (pid: 2487, threadinfo=f74d0000 task=f7eef090)
> > Stack: c03c6f80 f885ed64 00000004 00020000 f74d1f6c f7de15d8 000000a9
> > c0000000 fffffffc 00000004 00000010 f8862540 00000000 0804e130 f74d0000
> > f8806037 f885ed64 00000014 00000000 00020000 f8857000 00000000 f88060e5
> > c013a8f4 Call Trace:
> >  [<f8806037>] fat_cache_init+0x37/0x80 [fat]
> >  [<f8857000>] init_once+0x0/0x20 [fat]
> >  [<f88060e5>] init_fat_fs+0x5/0xc [fat]
> >  [<c013a8f4>] sys_init_module+0x124/0x1a0
> >  [<c0103175>] syscall_call+0x7/0xb
> > Code: 00 04 00 74 ec e9 8a 01 00 00 8b 4c 24 40 c7 04 24 80 6f 3c c0 89
> > 4c 24 04 e8 4e 44 fd ff f0 ff 05 ac d2 50 c0 0f 8e 73 1a 00 00 <0f> 0b d3
> > 05 95 65 3c c0 8b 0b e9 65 ff ff ff 8b 47 50 c7 04 24
>
> [...]
>
> > [7.7.] module vfat && embedded vfat normal situation, and I'm don't like
> > BUG in my dmesg... Sorry, I'm from Russia.
>
> Ummm... why is this normal situation? Didn't you run the
> modules_install after changed .config?  Anyway, this patch returns
> NULL instead of calling BUG().  This case seems to also happen with
> user error.
>
> Manfred, what do you think of this?

Thank you, but "goto opps", not "goto oops" in patch. 
>Didn't you run the  modules_install after changed .config?
No, I'm don't run modules_install. I'm build all modules first and use it (if required) for all my kernel's... And I have one init script, where :
...
/sbin/modprobe vfat
...
I want test to load any modules. Why not ?



