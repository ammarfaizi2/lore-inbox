Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317552AbSG2SF7>; Mon, 29 Jul 2002 14:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317561AbSG2SF7>; Mon, 29 Jul 2002 14:05:59 -0400
Received: from [195.223.140.120] ([195.223.140.120]:46689 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317552AbSG2SF6>; Mon, 29 Jul 2002 14:05:58 -0400
Date: Mon, 29 Jul 2002 20:10:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: oopsen with rc3-aa3
Message-ID: <20020729181020.GU1201@dualathlon.random>
References: <20020729174238.GA1919@714-cm.cps.unizar.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020729174238.GA1919@714-cm.cps.unizar.es>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 07:42:38PM +0200, J.A. Magallon wrote:
> Hi.
> 
> The new code in rc3aa3 makes a dual Xeon box hang on boot just
> when stating migration threads. I get two simultaneous oops, one
> for migration_thread=1 and =2. Decoded oops for one of them:

can you find out the exact line of C code that oopses (i.e. what it is
supposed to be edx)? If you can't find it please send me the disassembly
of the function load_balance, thanks.

Also please try to reproduce with Ingo's latest, I merged a few fixes
for the migration thread startup from his latest update.

> 
> *pde = 00000000
> CPU: 1
> EIP: 0010:[<80119f9d>] Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010006
> eax: 00002700 ebx: 000000ff ecx: 00000004 edx: 00000000
> esi: 00000000 edi: 00000004 ebp: bffe7f80 esp: bffe7f40
> ds: 0018 es: 0018 ss: 0018
> Process migration_CPU1 (pid: 3, stackpage=bffe7000)
> Stack: 00000000 00000004 0000000a bffe7fc8 ffffffff 00000001
>        bffe634b ffffffff 00000001 00000000 0000000a 00000001
>            802fe240 00000000 bffe6000 802fe240 bffe7fc0 8011a7e7
>            802fe240 00000001 802fe240 8025c116 bffe633e bffe6000
> Call Trace: [<8011a7e7>] [<8025c116>] [<8025c134>] [<8011c009>]
>         [<80105000>] [<80105000>] [<80107256>] [<8011bec0>]
> Code: 8b 42 14 c7 42 14 01 00 00 00 85 c0 0f 85 88 03 00 00 8b 52
> 
> >>EIP; 80119f9c <load_balance+ec/490>   <=====
> Trace; 8011a7e6 <schedule+126/3a0>
> Trace; 8025c116 <vsprintf+16/20>
> Trace; 8025c134 <sprintf+14/20>
> Trace; 8011c008 <migration_thread+148/320>
> Trace; 80105000 <_stext+0/0>
> Trace; 80105000 <_stext+0/0>
> Trace; 80107256 <kernel_thread+26/30>
> Trace; 8011bec0 <migration_thread+0/320>
> Code;  80119f9c <load_balance+ec/490>
> 00000000 <_EIP>:
> Code;  80119f9c <load_balance+ec/490>   <=====
>    0:   8b 42 14                  mov    0x14(%edx),%eax   <=====
> Code;  80119f9e <load_balance+ee/490>
>    3:   c7 42 14 01 00 00 00      movl   $0x1,0x14(%edx)
> Code;  80119fa6 <load_balance+f6/490>
>    a:   85 c0                     test   %eax,%eax
> Code;  80119fa8 <load_balance+f8/490>
>    c:   0f 85 88 03 00 00         jne    39a <_EIP+0x39a> 8011a336 <load_balance+486/490>
> Code;  80119fae <load_balance+fe/490>
>   12:   8b 52 00                  mov    0x0(%edx),%edx


Andrea
