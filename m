Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262888AbSJGFmH>; Mon, 7 Oct 2002 01:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262889AbSJGFmH>; Mon, 7 Oct 2002 01:42:07 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:30656 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262888AbSJGFmF>;
	Mon, 7 Oct 2002 01:42:05 -0400
Message-ID: <3DA11FC6.80308@us.ibm.com>
Date: Sun, 06 Oct 2002 22:46:46 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: 2.5.40-mm2
References: <3DA0854E.CF9080D7@digeo.com> <3DA0A144.8070301@us.ibm.com> <3DA0B151.6EF8C8D9@digeo.com> <3DA0B422.C23B23D4@digeo.com> <3DA0B52C.6E1E53FD@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> grr.  So that's what that "send" button does.
> 
> Updated patch:

Still dies :(

Unable to handle kernel NULL pointer dereference at virtual addre
ss 00000004
  printing eip:
80120479
*pde = 64502001
*pte = 00000000
Oops: 0002

CPU:    2
EIP:    0060:[<80120479>]    Not tainted
EFLAGS: 00010012
EIP is at run_timer_tasklet+0xcd/0x13c
eax: 00000000   ebx: 80264a38   ecx: e4f46e20   edx: 00000000
esi: e4f47040   edi: 80399ac0   ebp: 00000282   esp: e474df64
ds: 0068   es: 0068   ss: 0068
Process httpd (pid: 2587, threadinfo=e474c000 task=f55d17e0)
Stack: 8c093148 00000000 e474c000 00000001 8011d295 00000000 00000001
        80397960 fffffffe 00000040 8037c1a4 8037c1a4 8011cf9a 80397960
        00000008 00000002 00000001 7ffff89c 00000046 801111dd 0813eff0
        0813ef14 0813f064 80107a8a
Call Trace:
  [<8011d295>] tasklet_hi_action+0x85/0xe0
  [<8011cf9a>] do_softirq+0x5a/0xac
  [<801111dd>] smp_apic_timer_interrupt+0x111/0x118
  [<80107a8a>] apic_timer_interrupt+0x1a/0x20

Code: 89 50 04 89 02 c7 06 00 00 00 00 c7 46 04 00 00 00 00 c7 46


8012046a:       39 c6                   cmp    %eax,%esi
8012046c:       74 42   <the last if>   je     801204b0 
<run_timer_tasklet+0x104>
8012046e:       8b 5e 0c                mov    0xc(%esi),%ebx
80120471:       8b 4e 10                mov    0x10(%esi),%ecx
80120474:       8b 56 04                mov    0x4(%esi),%edx
80120477:       8b 06                   mov    (%esi),%eax
80120479:       89 50 04      ------->  mov    %edx,0x4(%eax)
8012047c:       89 02                   mov    %eax,(%edx)
8012047e:       c7 06 00 00 00 00       movl   $0x0,(%esi)
80120484:       c7 46 04 00 00 00 00    movl   $0x0,0x4(%esi)
8012048b:       c7 46 14 00 00 00 00    movl   $0x0,0x14(%esi)
80120492:       89 77 08                mov    %esi,0x8(%edi)
80120495:       c6 07 01                movb   $0x1,(%edi)
80120498:       55                      push   %ebp
80120499:       9d                      popf


-- 
Dave Hansen
haveblue@us.ibm.com

