Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267719AbSLGFmB>; Sat, 7 Dec 2002 00:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267720AbSLGFmB>; Sat, 7 Dec 2002 00:42:01 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:56524 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S267719AbSLGFmA>; Sat, 7 Dec 2002 00:42:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.5.50, ACPI] link error
Date: Fri, 6 Dec 2002 21:50:05 -0800
User-Agent: KMail/1.4.3
Cc: Jochen Hein <jochen@jochen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E18Ix71-0003ik-00@gswi1164.jochen.org> <200212031247.07284.EricAltendorf@orst.edu> <20021205173145.GB731@elf.ucw.cz>
In-Reply-To: <20021205173145.GB731@elf.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212062150.06350.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 December 2002 09:31, Pavel Machek wrote:
> Hi!
>
> > Right ... I'm no kernel hacker so I don't know why, but I can
> > only get the recent kernels to compile with sleep states if I
> > turn *ON* software suspend as well.  However, as soon as I turn
> > on swsusp and get a compiled kernel, it oops'es on boot.
>
> Can you mail me decoded oops?
> 								Pavel

This is the first time I've decoded an oops, and since I had to decode it on a different kernel (2.5.25) than the one I'm debugging (2.5.50 + Dec 6 ACPI patch), and I couldn't get the ksyms file, I used -K ... and because I built w/o modules I used -L and -O.  Let me know if I did it wrong or if you need more info...  Thanks.  (Also I had to transcribe the oops by hand ... I'm pretty sure I got all the values right but I could have missed something)

ksymoops 2.4.4 on i586 2.5.25.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

*pde = 00000000
Oops: 0000
CPU: 0
EIP:  0060:[<c013a6b1>]   Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: a55a5a5a  ebx: 00001000  ecx: 00000000  edx: 00000200
esi: c130f628  edi: cedc5000  ebp: c0326e00  esp: c12bdf7c
ds: 0068  es: 0068  ss: 0068
Stack: c130f628 00000000 c0121816 c130f628 00001000 c130d628 00000001 00000000
       00000003 c03f0080 00000000 c03f0045 00000000 c0121937 c0326e00 00000000
       c02c5c9f c0326e00 c01051c4 c02bed13 00000000 00000000 c0105020 00000000
 [<c0121816>] read_suspend_image+0x81/0x107
 [<c0121937>] software_resume+0x9b/0xc0
 [<c01051c4>] prepare_namespace+0x84/0x10c
 [<c0105020>] init+0x0/0x120
 [<c010503f>] init+0x1f/0x120
 [<c0105020>] init+0x0/0x120
 [<c0106ca9>] kernel_thread_helper+0x5/0xb
Code: 8b 40 28 85 c0 74 11 66 83 b8 b6 00 00 00 00 74 07 0f b7 90

>>EIP; c013a6b1 <set_blocksize+26/83>   <=====
Code;  c013a6b1 <set_blocksize+26/83>
00000000 <_EIP>:
Code;  c013a6b1 <set_blocksize+26/83>   <=====
   0:   8b 40 28                  mov    0x28(%eax),%eax   <=====
Code;  c013a6b4 <set_blocksize+29/83>
   3:   85 c0                     test   %eax,%eax
Code;  c013a6b6 <set_blocksize+2b/83>
   5:   74 11                     je     18 <_EIP+0x18> c013a6c9 <set_blocksize+3e/83>
Code;  c013a6b8 <set_blocksize+2d/83>
   7:   66 83 b8 b6 00 00 00      cmpw   $0x0,0xb6(%eax)
Code;  c013a6bf <set_blocksize+34/83>
   e:   00 
Code;  c013a6c0 <set_blocksize+35/83>
   f:   74 07                     je     18 <_EIP+0x18> c013a6c9 <set_blocksize+3e/83>
Code;  c013a6c2 <set_blocksize+37/83>
  11:   0f b7 90 00 00 00 00      movzwl 0x0(%eax),%edx

 <0>Kernel panic: Attempted to kill init!

eric

-- 
"First they ignore you.  Then they laugh at you.
 Then they fight you.  And then you win."             -Gandhi
