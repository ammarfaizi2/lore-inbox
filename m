Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbTBFC4q>; Wed, 5 Feb 2003 21:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265249AbTBFC4p>; Wed, 5 Feb 2003 21:56:45 -0500
Received: from komarek.dsl.telerama.com ([205.201.10.127]:57474 "EHLO
	tux.home.fake") by vger.kernel.org with ESMTP id <S265255AbTBFC4o>;
	Wed, 5 Feb 2003 21:56:44 -0500
Subject: Re: bug at buffer.c:2513
From: Paul Komarek <komarek@cmu.edu>
Reply-To: komarek@cmu.edu
To: linux-kernel@vger.kernel.org
In-Reply-To: <1043916513.18095.31.camel@tux.home.fake>
References: <1043916513.18095.31.camel@tux.home.fake>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044500777.2080.11.camel@tux.home.fake>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 05 Feb 2003 22:06:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, my bad.  Not only didn't I get /dev/ksyms the first time, but I
wasn't able to reproduce an oops which didn't also include destruction
of the interrupt handler.  In the end, it was a bad memory module. 
Sorry for the noise.

-Paul Komarek

On Thu, 2003-01-30 at 03:48, Paul Komarek wrote:
> Kernel 2.4.21-pre4 told me it has a bug in buffer.c:2513.  The relevant
> lines of fs/buffer.c are
> 
> 2512:    if (size < 512 || size > PAGE_SIZE)
> 2513:             BUG();
> 
> I'm running kernel 2.4.21-pre4 compiled for i386 on a natsemi geode gx1
> with ns cs5530a (Acrosser AR-B1565,
> http://www.acrosser.com/products/ar-b1565.htm).  I was running rsync at
> the time of the bug message.  Below is the bug message:
> 
> ----------------------------------------------------------------------------------
> kernel BUG at buffer.c:2513!
> invalid operand: 0000
> CPU: 0
> EIP: 0010:[<c01340cf>] Not tainted
> EFLAGS: 00010286
> eax: c6000e00 ebx: 00000000 ecx: 00000200 edx: 00000000
> esi: 00000300 edi: c6001000 ebp: 00000300 esp: c5959e3c
> ds: 0018   es: 0018   ss: 0018
> Process rsync (pid: 161, stackpage=c5959000)
> Stack: 00000000 00000300 c6001000 00120087 c0132209 00000300 00120087
> c6001000
>        c78ec800 00000480 c1637ac0 00083780 c01323f4 00000300 00120087
> c6001000
>        00000300 c01554d0 00000300 00120087 c6001000 00000024 00120087
> 00000000
> Call Trace:  [<c0132209>] [<c01323f4>] [<c01554d0>] [<c0155e60>]
> [<c0160a9f>]
> [<c0155f04>] [<c015abe7>] [<c0155fcf>] [<c0142393>] [<c012697d>]
> [<c0151c57>]
> [<c01308fc>] [<c0108967>] 
> 
> Code: 0f 0b d1 09 5a 6a 27 c0 b9 ff ff ff ff 41 89 f8 d3 e0 3d ff
>  rsync: connection unexpectedly closed (802675 bytes read so far)
> rsync error: error in rsync protocol data stream (code 12) at io.c(150)
> ---------------------------------------------------------------------------------
> 
> If anyone is interested, I can provide details about my kernel config
> and run experiments.  I'd like to be a proper kernel-hacker, figure this
> out myself, and be generally cool; however, I need to finish my degree
> before my advisor notices I'm posting on lkml.
> 
> Please cc me (komarek_at_cmu_edu) on any messages you want me to read.
> 
> -Paul Komarek
> 
