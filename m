Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269734AbRHII0S>; Thu, 9 Aug 2001 04:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269735AbRHII0J>; Thu, 9 Aug 2001 04:26:09 -0400
Received: from [193.120.224.170] ([193.120.224.170]:35733 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S269734AbRHIIZ5>;
	Thu, 9 Aug 2001 04:25:57 -0400
Date: Thu, 9 Aug 2001 09:26:02 +0100 (IST)
From: Paul Jakma <paulj@alphyra.ie>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        <linux-kernel@vger.kernel.org>
Subject: Re: kupdated oops in 2.4.8-pre5
In-Reply-To: <Pine.LNX.4.33.0108071433480.1434-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0108090923030.13822-100000@dunlop.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Linus Torvalds wrote:

> Yes, stupid lost test. Already fixed in -pre6.

Hi Linus,

I'm seeing what appears to be the same problem in pre7, can trigger
it reliably:

Aug  9 08:36:15 dunlop kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000001c
Aug  9 08:36:15 dunlop kernel: c0133dd7
Aug  9 08:36:15 dunlop kernel: *pde = 00000000
Aug  9 08:36:15 dunlop kernel: Oops: 0000
Aug  9 08:36:15 dunlop kernel: CPU:    0
Aug  9 08:36:15 dunlop kernel: EIP:    0010:[sync_old_buffers+39/80]
Aug  9 08:36:15 dunlop kernel: EFLAGS: 00210286
Aug  9 08:36:15 dunlop kernel: eax: 0001691d   ebx: c127c550   ecx: 00000000   edx: 00000000
Aug  9 08:36:15 dunlop kernel: esi: ffffffff   edi: fff9ffff   ebp: c127c000   esp: c127dfc4
Aug  9 08:36:15 dunlop kernel: ds: 0018   es: 0018   ss: 0018
Aug  9 08:36:15 dunlop kernel: Process kupdated (pid: 7, stackpage=c127d000)
Aug  9 08:36:15 dunlop kernel: Stack: ffffff10 c127c550 ffffffff c127c000 c0134078 0008e000 c127c000 00010f00
Aug  9 08:36:15 dunlop kernel:        c7fc5fb0 c0105000 0008e000 c01054f6 c026ce44 c0133f90 c0259fc4
Aug  9 08:36:15 dunlop kernel: Call Trace: [kupdate+232/240] [stext+0/48] [kernel_thread+38/48] [kupdate+0/240]
Aug  9 08:36:15 dunlop kernel: Code: 3b 42 1c 79 e4 81 3d e0 0f 25 c0 e0 0f 25 c0 74 0b 68 e0 0f

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   3b 42 1c                  cmp    0x1c(%edx),%eax
Code;  00000003 Before first symbol
   3:   79 e4                     jns    ffffffe9 <_EIP+0xffffffe9>
ffffffe9 <END_OF_CODE+3777d6f5/???
Code;  00000005 Before first symbol
   5:   81 3d e0 0f 25 c0 e0      cmpl   $0xc0250fe0,0xc0250fe0
Code;  0000000c Before first symbol
   c:   0f 25 c0
Code;  0000000f Before first symbol
   f:   74 0b                     je     1c <_EIP+0x1c> 0000001c
Before first symbol
Code;  00000011 Before first symbol
  11:   68 e0 0f 00 00            push   $0xfe0

regards,

Paul Jakma.

