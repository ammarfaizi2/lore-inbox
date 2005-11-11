Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVKKUcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVKKUcU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVKKUcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:32:20 -0500
Received: from frodo.ingrian.com ([207.47.3.25]:53136 "EHLO frodo.ingrian.com")
	by vger.kernel.org with ESMTP id S1751167AbVKKUcT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:32:19 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: tcp_sendmsg in scheduler queue 
Date: Fri, 11 Nov 2005 12:32:12 -0800
Message-ID: <7B18208E62D0B74A9A7D854F3C897467033498@mail.ingrian.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: tcp_sendmsg in scheduler queue 
Thread-Index: AcXm/v8ORFyVO/hBRKW+jauc5apzxQ==
From: "Seva Tonkonoh" <seva@ingrian.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am developing a kernel module that schedules a task to run
in the scheduler queue (kernel is 2.4), and inside the task there is a
call
to tcp_sendmsg().

I have intermittent kernel crashes which seem to happen in alloc_skb()
(below is the output from ksymoops).

Is there anything wrong with calling tcp_sendmsg() from a task in the
scheduler queue?

Thanks,
Seva Tonkonoh

>>EIP; c012f10f <kmem_cache_alloc_batch+67/e0>   <=====

>>ecx; c1c0da28 <_end+18a5138/11ce9710>
>>esi; c1c0da28 <_end+18a5138/11ce9710>

Trace; c012f2ea <kmem_cache_alloc+72/13c>
Trace; c01f996c <alloc_skb+cc/1bc>
Trace; c0213348 <tcp_sendmsg+23c/1140>
Trace; f899e5f8 <END_OF_CODE+268d1001/????>
Trace; c0115233 <schedule_timeout+83/a0>
Trace; c011d2ec <__run_task_queue+64/70>
Trace; c01250d7 <context_thread+137/1d0>
Trace; c0105684 <kernel_thread+28/38>

Code;  c012f10f <kmem_cache_alloc_batch+67/e0>
00000000 <_EIP>:
Code;  c012f10f <kmem_cache_alloc_batch+67/e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012f113 <kmem_cache_alloc_batch+6b/e0>
   4:   03 59 0c                  add    0xc(%ecx),%ebx
Code;  c012f116 <kmem_cache_alloc_batch+6e/e0>
   7:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012f119 <kmem_cache_alloc_batch+71/e0>
   a:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012f11c <kmem_cache_alloc_batch+74/e0>
   d:   75 23                     jne    32 <_EIP+0x32> c012f141
<kmem_cache_alloc_batch+99/e0>
Code;  c012f11e <kmem_cache_alloc_batch+76/e0>
   f:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012f121 <kmem_cache_alloc_batch+79/e0>
  12:   8b 11                     mov    (%ecx),%edx
