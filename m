Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSHJIkr>; Sat, 10 Aug 2002 04:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316677AbSHJIkr>; Sat, 10 Aug 2002 04:40:47 -0400
Received: from zok.SGI.COM ([204.94.215.101]:24734 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316675AbSHJIkq>;
	Sat, 10 Aug 2002 04:40:46 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at /usr/src/linux-2.5.30/include/linux/dcache.h:261! 
In-reply-to: Your message of "Sat, 10 Aug 2002 09:08:04 +0100."
             <20020810090803.A7235@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 10 Aug 2002 18:44:22 +1000
Message-ID: <11683.1028969062@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Aug 2002 09:08:04 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>In 2.5, I changed ARM to indicate the last word as the EIP (so we get more
>context as Andrew Morton suggests.)  However, ksymoops now seems to ignore
>the '()' !
>
>At some point I plan to check what happens if its the second to last.  I
>suspect ksymoops is looking for the strings ' (' and ') ', the second of
>which obviously doesn't exist.

ksymoops is scanning for (oops.c line 361)

              "([<(]?)"                 /* 2 */
              "([0-9a-fA-F]+)"          /* 3 */
              "[)>]?"
              " *"

The trailing [)>] is required but any space after that is optional.  It
works for me.

Code: e7973108 e1a02423 e5c42001 e5c43000 (e1a02823)

Code;  c00160b8 No symbols available
00000000 <_EIP>:
Code;  c00160b8 No symbols available
0:   08 31                     or     %dh,(%ecx)
Code;  c00160ba No symbols available
2:   97                        xchg   %eax,%edi
Code;  c00160bb No symbols available
3:   e7 23                     out    %eax,$0x23
Code;  c00160bd No symbols available
5:   24 a0                     and    $0xa0,%al
Code;  c00160bf No symbols available
7:   e1 01                     loope  a <_EIP+0xa> c00160c2 No symbols available
Code;  c00160c1 No symbols available
9:   20 c4                     and    %al,%ah
Code;  c00160c3 No symbols available
b:   e5 00                     in     $0x0,%eax
Code;  c00160c5 No symbols available
d:   30 c4                     xor    %al,%ah
Code;  c00160c7 No symbols available   <=====
f:   e5 23                     in     $0x23,%eax   <=====
Code;  c00160c9 No symbols available
11:   28 a0 e1 00 00 00         sub    %ah,0xe1(%eax)

Disassembling arm as i386 is pointless, but it shows that ksymoops
2.4.5 recognises () as the last code fragment.

