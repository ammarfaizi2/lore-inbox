Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUFVTww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUFVTww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUFVTs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:48:59 -0400
Received: from tossu.ebaana.net ([62.121.33.10]:9228 "EHLO tossu.ssp.fi")
	by vger.kernel.org with ESMTP id S265119AbUFVTrC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:47:02 -0400
Message-ID: <200406222247190082.00051F88@smtp.ebaana.net>
In-Reply-To: <20040622171806.GF2135@holomorphy.com>
References: <200406221954150026.009597B0@smtp.ebaana.net>
 <20040622171806.GF2135@holomorphy.com>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Tue, 22 Jun 2004 22:47:19 +0300
From: "Juhani Pirttilahti" <juhani.pirttilahti@mbnet.fi>
To: "William Lee Irwin III" <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel problem
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.6.2004 at 10:18 William Lee Irwin III wrote:
>On Tue, Jun 22, 2004 at 07:54:15PM +0300, Juhani Pirttilahti wrote:
>> "Screenshot":
>> Unable to handle kernel paging request at virtual address 591bb01c
>> printing eip: c0142104 *pde = 00000000
>> Oops: 0002
>> CPU: 0
>> EIP: 0010:[<c0142104>] Not tainted
>> EFLAGS: 00010202
>> eax: 00000001 ebx: 591bafc0 ecx: 00000000 edx: 591bb01c
>> esi: c02177cd edi: 591bb01c ebp: 00000000 esp: c0285f40
>> ds: 0018 es: 0018 ss: 0018
>> Process swapper (pid: 0, stackpage=c0285000)
>> Stack: 00000000 c12143e0 c0246540 00000000 c0142235 00000000 c0285f5c
>c02177cd 00000001 00000000 c0246540 c1216800 c014d8ca c12143e0 c1216800
>00000000 c0136b0c c1216800 00000000 00000000 cbfcc190 c0246540 fffffff4
>> Call Trace: [<c0142235>] [<c0136b0c>] [<c0136bad>] [c0105000>]
>[<c0136cfc>]
>> Code: a4 8b 4c 24 18 8b 41 04 c6 04 10 00 c7 03 01 00 00 00 c7 43
>> <0>Kernel Panic: Attempted to kill the idle task!
>> In idle task - not syncing
>
>Could you run this through ksymoops or post the 2.6 oops?
>
>Thanks.
>
>-- wli

Okay, noticed that there seemed to be some initrd problems... (failed to ungzip)
There is ksymoops output:

>>EIP; c0142104 <d_alloc+7f/14a>   <=====

>>esi; c02177cd <cpdext+1bed/1c820>
>>esp; c0285f40 <init_task_union+1f40/2000>

Code;  c0142104 <d_alloc+7f/14a>
00000000 <_EIP>:
Code;  c0142104 <d_alloc+7f/14a>   <=====
   0:   a4                        movsb  %ds:(%esi),%es:(%edi)   <=====
Code;  c0142105 <d_alloc+80/14a>
   1:   8b 4c 24 18               mov    0x18(%esp,1),%ecx
Code;  c0142109 <d_alloc+84/14a>
   5:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c014210c <d_alloc+87/14a>
   8:   c6 04 10 00               movb   $0x0,(%eax,%edx,1)
Code;  c0142110 <d_alloc+8b/14a>
   c:   c7 03 01 00 00 00         movl   $0x1,(%ebx)
Code;  c0142116 <d_alloc+91/14a>
  12:   c7 43 00 00 00 00 00      movl   $0x0,0x0(%ebx)

<0>Kernel Panic: Attempted to kill the idle task!


