Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272348AbRHYAA1>; Fri, 24 Aug 2001 20:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272349AbRHYAAR>; Fri, 24 Aug 2001 20:00:17 -0400
Received: from cabal.xs4all.nl ([213.84.101.140]:10220 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S272348AbRHYAAI>;
	Fri, 24 Aug 2001 20:00:08 -0400
Date: Sat, 25 Aug 2001 02:00:22 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: oops in 3c59x driver
Message-ID: <20010825020022.B21339@wiggy.net>
Mail-Followup-To: Wichert Akkerman <wichert@wiggy.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After switching my laptop to a 2.4 kernel I've had it die occasionaly
and I finally managed to get an oops out of it today (not running X
makes that a lot simpler :).

Decoded oops is below. The machine died in the middle of transferring
a large chunk of data (500Mb or so) via ssh. It did that twice in a row
now so it seems to be reprocuable.

This oops was made using 2.4.7ac11 (with freeswan 1.91 patch included
but which is not used). I get the same problem on 2.4.8ac5 and all
other 2.4 releases from the last few weeks as well.

The usual more-info-available-on-request applies. 

Wichert.

CPU:    0
EIP:    0010:[<c01d27c3>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 000005dc   ebx: c2f5c6e0   ecx: 00000006   edx: cae12712
esi: c1e12812   edi: c5fd4870   ebp: c5fd4940   esp: c125be70
ds:  0018  es: 0078   ss: 0018
Process kpnpbios (pid: 2, stackpage=c125b000)
Stack: c2f5c6e0 c5fd4800 c5fd4800 c8875003 c2f5c6e0 c5fd4800 00000020 c5fd4800
       0000000b 0000e601 000005ea 42413938 0000001f 600085ea 00001800 00000017
       c88748a0 c5fd4800 c335e240 04000001 0000000b c125bf34 c12437f0 c1243760
Call Trace: [<c8875003>] [<c88748a0>] [<c01c58c>] [<c010802d>] [<c010818e>]
   [<c010a0ee>] [<c01b8634>] [<c0110018>] [<c01b8811>] [<c0105454>]
Code: f3 a6 74 04 c6 43 6a 03 0f b7 42 0c 86 c4 0f b7 c0 3d ff 05

>>EIP; c01d27c3 <eth_type_trans+6b/a8>   <=====
Trace; c8875003 <[3c59x]boomerang_rx+23b/3ec>
Trace; c88748a0 <[3c59x]boomerang_interrupt+120/38c>
Trace; 0c01c58c Before first symbol
Trace; c010802d <handle_IRQ_event+35/60>
Trace; c010818e <do_IRQ+6e/b0>
Trace; c010a0ee <call_do_IRQ+5/b>
Trace; c01b8634 <pnp_bios_dock_station_info+98/e8>
Trace; c0110018 <do_release+78/b8>
Trace; c01b8811 <pnp_dock_thread+59/c8>
Trace; c0105454 <kernel_thread+28/38>
Code;  c01d27c3 <eth_type_trans+6b/a8>
00000000 <_EIP>:
Code;  c01d27c3 <eth_type_trans+6b/a8>   <=====
   0:   f3 a6                     repz cmpsb %es:(%edi),%ds:(%esi)   <=====
Code;  c01d27c5 <eth_type_trans+6d/a8>
   2:   74 04                     je     8 <_EIP+0x8> c01d27cb <eth_type_trans+73/a8>
Code;  c01d27c7 <eth_type_trans+6f/a8>
   4:   c6 43 6a 03               movb   $0x3,0x6a(%ebx)
Code;  c01d27cb <eth_type_trans+73/a8>
   8:   0f b7 42 0c               movzwl 0xc(%edx),%eax
Code;  c01d27cf <eth_type_trans+77/a8>
   c:   86 c4                     xchg   %al,%ah
Code;  c01d27d1 <eth_type_trans+79/a8>
   e:   0f b7 c0                  movzwl %ax,%eax
Code;  c01d27d4 <eth_type_trans+7c/a8>
  11:   3d ff 05 00 00            cmp    $0x5ff,%eax

 <0>Kernel panic: Aiee, killing in interrupt handler!

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
