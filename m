Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130529AbQK2QP6>; Wed, 29 Nov 2000 11:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130587AbQK2QPr>; Wed, 29 Nov 2000 11:15:47 -0500
Received: from [64.64.109.142] ([64.64.109.142]:530 "EHLO quark.didntduck.org")
        by vger.kernel.org with ESMTP id <S130529AbQK2QPk>;
        Wed, 29 Nov 2000 11:15:40 -0500
Message-ID: <3A252464.2AB55600@didntduck.org>
Date: Wed, 29 Nov 2000 10:44:36 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Sullivan <tsulliva@iex.net>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre3: paging problem
In-Reply-To: <3A250F85.EF1FD067@iex.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Sullivan wrote:
> 
> Hello,
> 
> The following occurred during startup using test12-pre3. test12-pre2
> does not exhibit the problem.
> 
> regards,
> 
> -tim
> 
> kernel: Unable to handle kernel paging request at virtual address
> fffffffc
> kernel:  printing eip:
> kernel: c011a41f
> kernel: *pde = 00001063
> kernel: *pte = 00000000
> kernel: Oops: 0000
> kernel: CPU:    0
> kernel: EIP:    0010:[sys_setitimer+191/208]
> kernel: EFLAGS: 00010246
> kernel: eax: 00000000   ebx: cf4e1fb0   ecx: 00000000   edx: c027169d
> kernel: esi: bffffc68   edi: cf4e1fc0   ebp: 00000000   esp: cf4e1f88
> kernel: ds: 0018   es: 0018   ss: 0018
> kernel: Process ntpdate (pid: 451, stackpage=cf4e1000)
> kernel: Stack: cf4e0000 bffffd1c 00000009 bffffc70 00000000 cf4e0000
> 400538e8 00000000
> kernel:        00000000 40166214 00000000 00030d40 00000000 000186a0
> c010a847 00000000
> kernel:        bffffc58 00000000 bffffd1c 00000009 bffffc70 00000068
> 0000002b 0000002b
> kernel: Call Trace: [system_call+51/56]
> kernel: Code: c8 5d 83 c4 28 c3 90 90 90 90 90 90 90 90 90 90 90 83 ec
> 44

Disassemblind the code bytes, it shows up as:
   0:   c8 5d 83 c4             enter  $0x835d,$0xc4
   4:   28 c3                   subb   %al,%bl
   6:   90                      nop
which is definately wrong.  Moving one byte forward it becomes:
   0:   5d                      popl   %ebp
   1:   83 c4 28                addl   $0x28,%esp
   4:   c3                      ret
   5:   90                      nop
which a normal sequence of instructions for the end of a function.  It
looks like a branch may have been miscompiled off by one.  What
compiler/binutils are you using?

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
