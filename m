Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136506AbREIOpt>; Wed, 9 May 2001 10:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136511AbREIOpq>; Wed, 9 May 2001 10:45:46 -0400
Received: from capitanata.ca.astro.it ([192.167.8.254]:11013 "EHLO
	capitanata.ca.astro.it") by vger.kernel.org with ESMTP
	id <S136506AbREIOpW>; Wed, 9 May 2001 10:45:22 -0400
Date: Wed, 9 May 2001 16:45:15 +0200 (CEST)
From: Giacomo Mulas <gmulas@ca.astro.it>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.4: BUG in ll_rw_blk.c?
Message-ID: <Pine.LNX.4.21.0105091634370.29725-100000@capitanata.ca.astro.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I am running a 2.4.4 kernel compiled from the sources in the
debian kernel-source package (it only includes a couple of small patches
taken from pre and ac, as far as I can tell) and run in the following
oopses, always while compiling the kernel itself. Here I included three
different oopses, and the computer had been rebooted between them (for
different reasons). Is this a known bug? Any fix available for it?
The computer is a 500MHz PIII, with a 440BX chipset on the motherboard,
more data available if required (just ask) running debian potato. The only
"nonstandard" system component is a 2.1.3 libc6 compiled with the 2.4.4
kernel headers, to be able to use large files. Here come the
(decoded) oopses:

May  7 14:57:11 stampace kernel: elevator returned crap (-1072325408)
May  7 14:57:11 stampace kernel: kernel BUG at ll_rw_blk.c:778!
May  7 14:57:11 stampace kernel: invalid operand: 0000
May  7 14:57:11 stampace kernel: CPU:    0
May  7 14:57:11 stampace kernel: EIP:    0010:[__make_request+950/1696]
May  7 14:57:11 stampace kernel: EFLAGS: 00010082
May  7 14:57:11 stampace kernel: eax: 0000001f   ebx: 00000000   ecx: ccdcc000   edx: c0229328
May  7 14:57:11 stampace kernel: esi: cc147840   edi: 00000008   ebp: c02af660   esp: cc257e08
May  7 14:57:11 stampace kernel: ds: 0018   es: 0018   ss: 0018
May  7 14:57:11 stampace kernel: Process cpp (pid: 18004, stackpage=cc257000)
May  7 14:57:11 stampace kernel: Stack: c01f801f c01f8262 0000030a 000000ff cc147840 00000001 0000000c c02ac9a0 
May  7 14:57:11 stampace kernel:        c02af688 0000000c 00001000 00000246 00002000 c02af690 c1472d80 c02af688 
May  7 14:57:11 stampace kernel:        000000ff 00000000 00000000 012a19c8 00000000 c0158f81 c02af660 00000000 
May  7 14:57:11 stampace kernel: Call Trace: [generic_make_request+293/308] [submit_bh+87/116] [block_read_full_page+525/548] [add_to_page_cache_unique+198/208] [ext2_readpage+15/20] [ext2_get_block+0/1168] [generic_file_readahead+548/668] 
May  7 14:57:11 stampace kernel:        [do_generic_file_read+838/1292] [generic_file_read+91/120] [file_read_actor+0/84] [sys_read+150/204] [system_call+51/56] 
May  7 14:57:11 stampace kernel: 
May  7 14:57:11 stampace kernel: Code: 0f 0b 83 c4 0c 83 7c 24 38 00 74 12 8b 44 24 38 89 44 24 40 

May  8 15:35:06 stampace kernel: elevator returned crap (-1072325408)
May  8 15:35:06 stampace kernel: kernel BUG at ll_rw_blk.c:778!
May  8 15:35:06 stampace kernel: invalid operand: 0000
May  8 15:35:06 stampace kernel: CPU:    0
May  8 15:35:06 stampace kernel: EIP:    0010:[__make_request+950/1696]
May  8 15:35:06 stampace kernel: EFLAGS: 00010082
May  8 15:35:06 stampace kernel: eax: 0000001f   ebx: 00000000   ecx: c33f2000   edx: c0227b48
May  8 15:35:06 stampace kernel: esi: c3d8a6e0   edi: 00000008   ebp: c02ad660   esp: c6f97e08
May  8 15:35:06 stampace kernel: ds: 0018   es: 0018   ss: 0018
May  8 15:35:06 stampace kernel: Process cpp (pid: 18605, stackpage=c6f97000)
May  8 15:35:06 stampace kernel: Stack: c01f7957 c01f7b62 0000030a 000000ff c3d8a6e0 00000001 0000000c c02aa9a0 
May  8 15:35:06 stampace kernel:        c02ad688 0000000c 00001000 00000246 00002000 c02ad690 c1470a80 c02ad688 
May  8 15:35:06 stampace kernel:        000000ff 00000000 00000000 00cc8ca0 00000000 c0158f81 c02ad660 00000000 
May  8 15:35:06 stampace kernel: Call Trace: [generic_make_request+293/308] [submit_bh+87/116] [block_read_full_page+525/548] [add_to_page_cache_unique+198/208] [ext2_readpage+15/20] [ext2_get_block+0/1168] [generic_file_readahead+548/668] 
May  8 15:35:06 stampace kernel:        [do_generic_file_read+838/1292] [generic_file_read+91/120] [file_read_actor+0/84] [sys_read+150/204] [system_call+51/56] 
May  8 15:35:06 stampace kernel: 
May  8 15:35:06 stampace kernel: Code: 0f 0b 83 c4 0c 83 7c 24 38 00 74 12 8b 44 24 38 89 44 24 40 

May  9 16:15:22 stampace kernel: elevator returned crap (-1072325408)
May  9 16:15:22 stampace kernel: kernel BUG at ll_rw_blk.c:778!
May  9 16:15:22 stampace kernel: invalid operand: 0000
May  9 16:15:22 stampace kernel: CPU:    0
May  9 16:15:22 stampace kernel: EIP:    0010:[__make_request+950/1696]
May  9 16:15:22 stampace kernel: EFLAGS: 00010082
May  9 16:15:22 stampace kernel: eax: 0000001f   ebx: 00000000   ecx: c289a000   edx: c0227b48
May  9 16:15:22 stampace kernel: esi: cd389ae0   edi: 00000008   ebp: c02ad660   esp: c3b09e08
May  9 16:15:22 stampace kernel: ds: 0018   es: 0018   ss: 0018
May  9 16:15:22 stampace kernel: Process cpp (pid: 13267, stackpage=c3b09000)
May  9 16:15:22 stampace kernel: Stack: c01f7957 c01f7b62 0000030a 000000ff cd389ae0 00000001 0000000c c02aa9a0 
May  9 16:15:22 stampace kernel:        c02ad688 0000000c 00001000 00000246 00002000 c02ad690 c146e240 c02ad688 
May  9 16:15:22 stampace kernel:        000000ff 00000000 00000000 0108d270 00000000 c0158f81 c02ad660 00000000 
May  9 16:15:22 stampace kernel: Call Trace: [generic_make_request+293/308] [submit_bh+87/116] [block_read_full_page+525/548] [add_to_page_cache_unique+198/208] [ext2_readpage+15/20] [ext2_get_block+0/1168] [generic_file_readahead+548/668] 
May  9 16:15:22 stampace kernel:        [do_generic_file_read+838/1292] [generic_file_read+91/120] [file_read_actor+0/84] [sys_read+150/204] [system_call+51/56] 
May  9 16:15:22 stampace kernel: 
May  9 16:15:22 stampace kernel: Code: 0f 0b 83 c4 0c 83 7c 24 38 00 74 12 8b 44 24 38 89 44 24 40 

Bye, thanks
Giacomo Mulas

_________________________________________________________________

Giacomo Mulas <gmulas@ca.astro.it, giacomo.mulas@tin.it>
_________________________________________________________________

OSSERVATORIO  ASTRONOMICO
Str. 54, Loc. Poggio dei Pini * 09012 Capoterra (CA)

Tel.: +39 070 71180 216     Fax : +39 070 71180 222
_________________________________________________________________

"When the storms are raging around you, stay right where you are"
                         (Freddy Mercury)
_________________________________________________________________

