Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263741AbUEMPLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUEMPLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUEMPLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:11:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18076 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263741AbUEMPJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:09:23 -0400
Date: Thu, 13 May 2004 11:09:18 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens-dated-1085310070.4b1f@endorphin.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] AES i586 optimized
In-Reply-To: <20040513110110.GA8491@ghanima.endorphin.org>
Message-ID: <Xine.LNX.4.44.0405131104230.16026-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004, Fruhwirth Clemens wrote:

> The following patch adds an i586 optimized implementation of AES aka
> Rijndael.

I got an oops when I loaded the tcrypt testing module with this code, on a 
dual Xeon.

Also, it would be good if the asm algorithm as automatically selected
instead of the C version for the correct architecture.


Unable to handle kernel NULL pointer dereference at virtual address 
00000000
 printing eip:
f886daed
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP 
CPU:    0
EIP:    0060:[<f886daed>]    Not tainted
EFLAGS: 00010202   (2.6.6) 
EIP is at aes_32+0x3/0x499 [aes_i586]
eax: f6370e88   ebx: f6370e5c   ecx: 00000004   edx: 00000000
esi: f8873db4   edi: f75b2264   ebp: f780fe44   esp: f780fe30
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1208, threadinfo=f780e000 task=f7990130)
Stack: f75b2264 f8873db4 f6370e5c f780fe54 00000246 f780fe58 00000246 f8873747 
       00000000 f6370e5c f780fe6c c023b545 f6370e5c f6370e5c f88d2164 f780ff88
       f88c81d6 f88c95f1 00000001 00000080 f780feec f75b20bc f75b2330 f75b2330 
Call Trace:
 [<f8873747>] aes_set_key_glue+0x27/0x40 [aes_i586]
 [<c023b545>] setkey+0x3c/0x3e
 [<f88c81d6>] test_cipher+0x71f/0x963 [tcrypt]
 [<f885702f>] init+0x2f/0x68 [tcrypt]
 [<c013dbbd>] kmem_cache_alloc+0x165/0x199
 [<f88c8f3a>] do_test+0x2ea/0x888 [tcrypt]
 [<f885703d>] init+0x3d/0x68 [tcrypt]
 [<c0131770>] sys_init_module+0x120/0x26c
 [<c0105aa9>] sysenter_past_esp+0x52/0x71

Code: 89 4a 00 8d 41 06 89 42 04 8b 75 10 8d 7a 08 fc 55 89 c8 f3



- James
-- 
James Morris
<jmorris@redhat.com>


