Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbRGKXmr>; Wed, 11 Jul 2001 19:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266945AbRGKXm1>; Wed, 11 Jul 2001 19:42:27 -0400
Received: from usr1470-gh1.blueyonder.co.uk ([62.31.171.200]:3333 "EHLO
	tim.rpnet.com") by vger.kernel.org with ESMTP id <S266941AbRGKXmQ>;
	Wed, 11 Jul 2001 19:42:16 -0400
Message-ID: <003f01c10a63$08f50540$0301a8c0@rpnet.com>
From: "Richard Purdie" <rpurdie@bigfoot.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <007501c10a1b$bc3a0bc0$0301a8c0@rpnet.com> <01071116375404.29517@frumious.unidec.co.uk>
Subject: Re: PROBLEM: <BUG Report: kernel BUG at slab.c:1062! from pppd with speedtouch drivers and pppoatm>
Date: Thu, 12 Jul 2001 00:36:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was mismatched module versions that casued the original bug error. I had
recompiled the speedtouch module itself but not the sarlib library it uses.
My fault, sorry :(.

Now I'm back to the kerenel panic below which takes down the system at the
same point as before:
It also did this on 2.4.5. It sometimes does and sometime doesn't happen but
always at the same point.
I'm going to try with 2.4.2 and see what happens from there.

invalid operand: 0000
CPU:    0
EIP:    0010:[<c4856824>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010097
eax: 00000000   ebx: c174f69c   ecx: 00000046   edx: c11e8440
esi: c174f680   edi: c174f68c   ebp: c174f69c   esp: c02e7ef4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02e7000)
Stack: 00000000 c174f69c 00000000 c1604600 c1604600 00000092 c00141e8
c4852844
       c174f69c c174fd1c c174f69c c174fd1c c174fd1c 00000000 00000000
c00141e8
       c48528d2 c174f69c c174fd10 c174fd10 c174fc80 c02e7fac 00000292
c4852aoe
Call Trace: [<c0107eef>] [<c010804e>] [<c0105340>] [<c0106d80>] [<c0105340>]
[<c
0105363>] [<c01053c7>]
       [<c0105000>]
Code: 0f 45 c2 89 43 54 8b 40 2c 89 43 58 8b 46 04 89 45 14 8b 56

>>EIP; c4856824 <END_OF_CODE+2febd/????>   <=====
Trace; c0107eef <handle_IRQ_event+2f/58>
Trace; c010804e <do_IRQ+6e/b0>
Trace; c0105340 <default_idle+0/28>
Trace; c0106d80 <ret_from_intr+0/7>
Trace; c0105340 <default_idle+0/28>
Code;  c4856824 <END_OF_CODE+2febd/????>
0000000000000000 <_EIP>:
Code;  c4856824 <END_OF_CODE+2febd/????>   <=====
   0:   0f 45 c2                  cmovne %edx,%eax   <=====
Code;  c4856827 <END_OF_CODE+2fec0/????>
   3:   89 43 54                  mov    %eax,0x54(%ebx)
Code;  c485682a <END_OF_CODE+2fec3/????>
   6:   8b 40 2c                  mov    0x2c(%eax),%eax
Code;  c485682d <END_OF_CODE+2fec6/????>
   9:   89 43 58                  mov    %eax,0x58(%ebx)
Code;  c4856830 <END_OF_CODE+2fec9/????>
   c:   8b 46 04                  mov    0x4(%esi),%eax
Code;  c4856833 <END_OF_CODE+2fecc/????>
   f:   89 45 14                  mov    %eax,0x14(%ebp)
Code;  c4856836 <END_OF_CODE+2fecf/????>
  12:   8b 56 00                  mov    0x0(%esi),%edx

Kernel panic: Aiee, killing interrupt handler!

It doesn't look very helpful to me. I'm sure the numbers are right but they
were hand copied.

Cheers,

RP




