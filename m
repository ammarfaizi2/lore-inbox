Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUB1Pou (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 10:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUB1Pou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 10:44:50 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:51106 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261872AbUB1Pos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 10:44:48 -0500
Date: Sat, 28 Feb 2004 07:44:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
cc: castetm@ensisun.imag.fr
Subject: [Bug 2219] New: kernel BUG at mm/rmap.c:306 
Message-ID: <476870000.1077983073@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2219

           Summary: kernel BUG at mm/rmap.c:306
    Kernel Version: 2.6.3
            Status: NEW
          Severity: high
             Owner: akpm@digeo.com
         Submitter: castetm@ensimag.imag.fr


Distribution: gentoo
Hardware Environment:pentium-3/512 Mo RAM

I have try overcommit-accounting with strict overcommit, but when i launch a
program like [1], there was a kernel bug [2]


[1]
int main()
{
        while(fork() != -1) {}
        while(malloc(1024)) {}
        while(1) {}
}
------------------------------------------------
[2]
Out of Memory: Killed process 8289 (a.out).
Out of Memory: Killed process 8297 (a.out).
swap_free: Bad swap offset entry 001c2790
------------[ cut here ]------------
kernel BUG at mm/rmap.c:306!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c014baf0>]    Not tainted
EFLAGS: 00010246
EIP is at try_to_unmap_one+0x1e0/0x1f0
eax: 00000000   ebx: 000c0000   ecx: 00000009   edx: c1000000
esi: c14662e8   edi: df55e300   ebp: c14662e8   esp: dfa99d48
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 8, threadinfo=dfa98000 task=dfa9eca0)
Stack: df55e300 00000009 1c279005 00000000 00000000 00000004 c14662e8 da675ac0
       00000000 c014bbab d4a5d440 00000004 00000000 da675ac0 00000000 c14662e8
       00000001 dfa98000 c0142554 c1416c20 dfa99db8 c036a6f4 dfa98000 00000028
Call Trace:
 [<c014bbab>] try_to_unmap+0xab/0x160
 [<c0142554>] shrink_list+0x224/0x560
 [<c0142a30>] shrink_cache+0x1a0/0x320
 [<c0143243>] shrink_zone+0x83/0xb0
 [<c014365a>] balance_pgdat+0x19a/0x220
 [<c01437f5>] kswapd+0x115/0x130
 [<c011d7e0>] autoremove_wake_function+0x0/0x50
 [<c0109302>] ret_from_fork+0x6/0x14
 [<c011d7e0>] autoremove_wake_function+0x0/0x50
 [<c01436e0>] kswapd+0x0/0x130
 [<c01072a5>] kernel_thread_helper+0x5/0x10

Code: 0f 0b 32 01 13 c0 32 c0 e9 78 fe ff ff 8d 76 00 55 57 56 89
 <6>note: kswapd0[8] exited with preempt_count 2
Out of Memory: Killed process 12353 (a.out).


