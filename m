Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264415AbRF1VNO>; Thu, 28 Jun 2001 17:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264432AbRF1VNA>; Thu, 28 Jun 2001 17:13:00 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:29967 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S264423AbRF1VMv>; Thu, 28 Jun 2001 17:12:51 -0400
Message-ID: <3B3B9DCD.17C55DA5@delusion.de>
Date: Thu, 28 Jun 2001 23:12:45 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Tvmixer Oops
In-Reply-To: <20010626133925.A6890@bytesex.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
> 
> On Mon, Jun 25, 2001 at 12:56:03PM +0200, Udo A. Steinberg wrote:
> >
> > Hello,
> >
> > Attached is the trace of an oops which seems to be caused by the
> > tvmixer code. Tvmixer is compiled monolithically into the kernel,
> > the rest of bttv is compiled as modules.
> 
> Any hints on how to reproduce that one?

I just got another one, however I still cannot reliably reproduce it.

Regards,
Udo.


ksymoops 2.4.1 on i686 2.4.5-ac18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac18/ (default)
     -m /boot/System.map-2.4.5-ac18 (specified)
 
Unable to handle kernel NULL pointer dereference at virtual address 0000002c
c01b8faa
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b8faa>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: ccb16980   ecx: 00000010   edx: 00000000
esi: c02f7fc0   edi: 00000000   ebp: 00000010   esp: cf351ef4
ds: 0018   es: 0018   ss: 0018
Process rat-4.2.19-medi (pid: 5876, stackpage=cf351000)
Stack: c028b580 00000000 c01cfa68 c5c0dc40 c85162c0 00000000 c85162c0 c5c0dc40
       c14a82c0 c028ab60 c85162c0 c5c0dc40 c14a82c0 c5c0dc40 ffffffeb 00000002
       c013900a c5c0dc40 c012febe c5c0dc40 c85162c0 c85162c0 c5c0dc40 00000000
Call Trace: [<c01cfa68>] [<c013900a>] [<c012febe>] [<c012ef5d>] [<c012ee92>]
   [<c012f186>] [<c0106bfb>]
Code: 83 78 2c 00 74 09 50 8b 40 2c ff d0 83 c4 04 31 c0 5b 5e c3

>>EIP; c01b8faa <tvmixer_open+5a/70>   <=====
Trace; c01cfa68 <soundcore_open+108/190>
Trace; c013900a <permission+2a/30>
Trace; c012febe <chrdev_open+3e/50>
Trace; c012ef5d <dentry_open+bd/140>
Trace; c012ee92 <filp_open+52/60>
Trace; c012f186 <sys_open+36/a0>
Trace; c0106bfb <system_call+33/38>
Code;  c01b8faa <tvmixer_open+5a/70>
00000000 <_EIP>:
Code;  c01b8faa <tvmixer_open+5a/70>   <=====
   0:   83 78 2c 00               cmpl   $0x0,0x2c(%eax)   <=====
Code;  c01b8fae <tvmixer_open+5e/70>
   4:   74 09                     je     f <_EIP+0xf> c01b8fb9 <tvmixer_open+69/70>
Code;  c01b8fb0 <tvmixer_open+60/70>
   6:   50                        push   %eax
Code;  c01b8fb1 <tvmixer_open+61/70>
   7:   8b 40 2c                  mov    0x2c(%eax),%eax
Code;  c01b8fb4 <tvmixer_open+64/70>
   a:   ff d0                     call   *%eax
Code;  c01b8fb6 <tvmixer_open+66/70>
   c:   83 c4 04                  add    $0x4,%esp
Code;  c01b8fb9 <tvmixer_open+69/70>
   f:   31 c0                     xor    %eax,%eax
Code;  c01b8fbb <tvmixer_open+6b/70>
  11:   5b                        pop    %ebx
Code;  c01b8fbc <tvmixer_open+6c/70>
  12:   5e                        pop    %esi
Code;  c01b8fbd <tvmixer_open+6d/70>
  13:   c3                        ret
