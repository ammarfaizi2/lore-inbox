Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbTDHIs1 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 04:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTDHIs0 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 04:48:26 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:8929 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S262621AbTDHIsY (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 04:48:24 -0400
Message-ID: <035901c2fdad$390c4470$5600a8c0@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Linus Torvalds" <torvalds@transmeta.com>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com> <035401c2fdac$6e6aa400$5600a8c0@edumazet>
Subject: Re: Kernel BUG linux-2.5.67
Date: Tue, 8 Apr 2003 10:59:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops... I forgot to mention I use HugeTLB Pages...


> Hello
>
> I tried linux-2.5.67 this morning...
>
> instant oops with a small multi-threaded program using futex()
>
> ---------------------------------
> var/log/messages  ------------------------------------------------------
> Apr  8 07:40:12 test1 kernel: ------------[ cut here ]------------
> Apr  8 07:40:12 test1 kernel: kernel BUG at include/linux/mm.h:234!
> Apr  8 07:40:12 test1 kernel: invalid operand: 0000 [#1]
> Apr  8 07:40:12 test1 kernel: CPU:    0
> Apr  8 07:40:12 test1 kernel: EIP:    0060:[<c012d0d5>]    Not tainted
> Apr  8 07:40:12 test1 kernel: EFLAGS: 00010246
> Apr  8 07:40:12 test1 kernel: EIP is at futex_wake+0xeb/0x1ae
> Apr  8 07:40:12 test1 kernel: eax: 00000000   ebx: e2701eec   ecx:
e35e1940
> edx: 00000001
> Apr  8 07:40:12 test1 kernel: esi: c03bb410   edi: c15fed08   ebp:
c03bb410
> esp: e2ab9f5c
> Apr  8 07:40:12 test1 kernel: ds: 007b   es: 007b   ss: 0068
> Apr  8 07:40:12 test1 kernel: Process tstfutex (pid: 1266,
> threadinfo=e2ab8000 task=e2abcca0)
> Apr  8 07:40:12 test1 kernel: Stack: e2701f08 00000000 b08fea20 00000001
> 00000ab4 00000001 089edaa0 e2ab8000
> Apr  8 07:40:12 test1 kernel:        c012d984 089edab4 00000ab4 00000001
> 7fffffff 00000000 00000001 c012da25
> Apr  8 07:40:12 test1 kernel:        089edab4 00000001 00000001 7fffffff
> 01f78a40 00000003 089edab4 00000000
> Apr  8 07:40:12 test1 kernel: Call Trace:
> Apr  8 07:40:12 test1 kernel:  [<c012d984>] do_futex+0x8c/0x8e
> Apr  8 07:40:12 test1 kernel:  [<c012da25>] sys_futex+0x9f/0xce
> Apr  8 07:40:12 test1 kernel:  [<c010aa07>] syscall_call+0x7/0xb
> Apr  8 07:40:12 test1 kernel:
> Apr  8 07:40:12 test1 kernel: Code: 0f 0b ea 00 ea 08 2d c0 eb c8 8b 07 a9
> 00 08 00 00 75 da 8b
> Apr  8 07:40:12 test1 kernel:  ------------[ cut here ]------------
> Apr  8 07:40:12 test1 kernel: kernel BUG at include/linux/mm.h:234!
> Apr  8 07:40:12 test1 kernel: invalid operand: 0000 [#2]
> Apr  8 07:40:12 test1 kernel: CPU:    1
> Apr  8 07:40:12 test1 kernel: EIP:    0060:[<c012d3f6>]    Not tainted
> Apr  8 07:40:12 test1 kernel: EFLAGS: 00010246
> Apr  8 07:40:12 test1 kernel: EIP is at futex_wait+0x1f4/0x2ec
> Apr  8 07:40:12 test1 kernel: eax: 00000000   ebx: c15fed08   ecx:
e2701eec
> edx: e2701eec
> Apr  8 07:40:12 test1 kernel: esi: 7fffffff   edi: e2700000   ebp:
e2701f08
> esp: e2701ed8
> Apr  8 07:40:12 test1 kernel: ds: 007b   es: 007b   ss: 0068
> Apr  8 07:40:12 test1 kernel: Process tstfutex (pid: 1256,
> threadinfo=e2700000 task=e2714ca0)
> Apr  8 07:40:12 test1 kernel: Stack: e2701f08 089edab4 f6314800 c012d198
> 00000000 e2701eec e2701eec 00000001
> Apr  8 07:40:12 test1 kernel:        e2701f58 e2701f58 c15fed08 00000ab4
> 089ed000 f6314800 e2701f10 e2701f10
> Apr  8 07:40:12 test1 kernel:        c012d198 ffffffff 00000000 e35e3ef8
> 00000282 00000000 e2714ca0 c011afd6
> Apr  8 07:40:12 test1 kernel: Call Trace:
> Apr  8 07:40:12 test1 kernel:  [<c012d198>] futex_vcache_callback+0x0/0x6a
> Apr  8 07:40:12 test1 kernel:  [<c012d198>] futex_vcache_callback+0x0/0x6a
> Apr  8 07:40:12 test1 kernel:  [<c011afd6>] default_wake_function+0x0/0x12
> Apr  8 07:40:12 test1 kernel:  [<c011afd6>] default_wake_function+0x0/0x12
> Apr  8 07:40:12 test1 kernel:  [<c012d972>] do_futex+0x7a/0x8e
> Apr  8 07:40:12 test1 kernel:  [<c012da25>] sys_futex+0x9f/0xce
> Apr  8 07:40:12 test1 kernel:  [<c010aa07>] syscall_call+0x7/0xb
> Apr  8 07:40:12 test1 kernel:
> Apr  8 07:40:12 test1 kernel: Code: 0f 0b ea 00 ea 08 2d c0 eb c5 8b 03 a9

