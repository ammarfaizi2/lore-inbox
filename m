Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSJEQJD>; Sat, 5 Oct 2002 12:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262398AbSJEQJD>; Sat, 5 Oct 2002 12:09:03 -0400
Received: from math.ut.ee ([193.40.5.125]:35798 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S262395AbSJEQIz>;
	Sat, 5 Oct 2002 12:08:55 -0400
Date: Sat, 5 Oct 2002 19:14:28 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre9: oopses on PPC
Message-ID: <Pine.GSO.4.44.0210051905030.20309-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previous kernels have run well on this machine. Yesterday I compiled
2.4.20-pre9 and it ran until today. Today I switched from using
controlfb to using offb and the kernel started to oops on bitkeeper
operations. This may or may not be related to fb driver change because
maybe I didn't stress the machine too hard in the last day. But it was
stable in pre7 or pre8.

The oopses, run through ksymoops on the same running kernel, no reboot.
Looks like PPC oops output does not contain code, so ksymoops complains.
No idea though why it complains about sunrpc symbols. The kernel is
still running if anybody needs some additional information.

ksymoops 2.4.6 on ppc 2.4.20-pre9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre9/ (default)
     -m /boot/System.map-2.4.20-pre9 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol xchg_u32  , ksyms_base says c000b88c, System.map says c0006424.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says c8212b0c, /lib/modules/2.4.20-pre9/kernel/fs/lockd/lockd.o says c820500c.  Ignoring /lib/modules/2.4.20-pre9/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says c82028e8, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f1018.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says c82028ec, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f101c.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says c82028f0, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f1020.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says c82028e4, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f1014.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol packet_socks_nr  , af_packet says c81ecdd4, /lib/modules/2.4.20-pre9/kernel/net/packet/af_packet.o says c81e9004.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/packet/af_packet.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says c81de720, /lib/modules/2.4.20-pre9/kernel/drivers/usb/usbcore.o says c81cd000.  Ignoring /lib/modules/2.4.20-pre9/kernel/drivers/usb/usbcore.o entry
Oops: kernel access of bad area, sig: 11
NIP: C00294D4 XER: 20000000 LR: C0029588 SP: C4823E90 REGS: c4823de0 TRAP: 0300    Not tainted
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c4822000[460] 'bk' Last syscall: 4
last math c6a8a000 last altivec 00000000
GPR00: C0029588 C4823E90 C4822000 C4213AE8 000003E5 00000088 C4898314 00000000
GPR08: 00000000 00000068 C0240000 C04C0000 80808080 10111C54 C4898314 00000000
GPR16: C4213A88 C4213AA0 C48982F4 C4213AE8 FFFFFFF4 30016000 00001000 00000000
GPR24: C4213A1C C04CC05C 00001000 000003E5 00000088 C4213AE8 000003E5 00000088
Call backtrace:
00000000 C0029588 C002C464 C003AB14 C0003C7C 00000000 0FF209BC
0FF208C8 0FF20D88 0FF216E4 0FF15F44 1002C75C 10002BCC 100025F4
0FECAC50 00000000
Warning (Oops_read): Code line not seen, dumping what data is available


>>NIP; c00294d4 <__find_lock_page_helper+30/d0>   <=====

>>GPR0; c0029588 <__find_lock_page+14/24>
>>GPR1; c4823e90 <_end+45afdec/7f40f5c>
>>GPR2; c4822000 <_end+45adf5c/7f40f5c>
>>GPR3; c4213ae8 <_end+3f9fa44/7f40f5c>
>>GPR6; c4898314 <_end+4624270/7f40f5c>
>>GPR10; c0240000 <nvramData+4f44/8000>
>>GPR11; c04c0000 <_end+24bf5c/7f40f5c>
>>GPR14; c4898314 <_end+4624270/7f40f5c>
>>GPR16; c4213a88 <_end+3f9f9e4/7f40f5c>
>>GPR17; c4213aa0 <_end+3f9f9fc/7f40f5c>
>>GPR18; c48982f4 <_end+4624250/7f40f5c>
>>GPR19; c4213ae8 <_end+3f9fa44/7f40f5c>
>>GPR24; c4213a1c <_end+3f9f978/7f40f5c>
>>GPR25; c04cc05c <_end+257fb8/7f40f5c>
>>GPR29; c4213ae8 <_end+3f9fa44/7f40f5c>

Trace; 00000000 Before first symbol
Trace; c0029588 <__find_lock_page+14/24>
Trace; c002c464 <generic_file_write+484/828>
Trace; c003ab14 <sys_write+c8/14c>
Trace; c0003c7c <ret_from_syscall_1+0/b4>
Trace; 00000000 Before first symbol
Trace; 0ff209bc Before first symbol
Trace; 0ff208c8 Before first symbol
Trace; 0ff20d88 Before first symbol
Trace; 0ff216e4 Before first symbol
Trace; 0ff15f44 Before first symbol
Trace; 1002c75c Before first symbol
Trace; 10002bcc Before first symbol
Trace; 100025f4 Before first symbol
Trace; 0fecac50 Before first symbol
Trace; 00000000 Before first symbol


10 warnings issued.  Results may not be reliable.


ksymoops 2.4.6 on ppc 2.4.20-pre9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre9/ (default)
     -m /boot/System.map-2.4.20-pre9 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol xchg_u32  , ksyms_base says c000b88c, System.map says c0006424.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says c8212b0c, /lib/modules/2.4.20-pre9/kernel/fs/lockd/lockd.o says c820500c.  Ignoring /lib/modules/2.4.20-pre9/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says c82028e8, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f1018.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says c82028ec, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f101c.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says c82028f0, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f1020.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says c82028e4, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f1014.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol packet_socks_nr  , af_packet says c81ecdd4, /lib/modules/2.4.20-pre9/kernel/net/packet/af_packet.o says c81e9004.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/packet/af_packet.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says c81de720, /lib/modules/2.4.20-pre9/kernel/drivers/usb/usbcore.o says c81cd000.  Ignoring /lib/modules/2.4.20-pre9/kernel/drivers/usb/usbcore.o entry
Oops: kernel access of bad area, sig: 11
NIP: C0028DDC XER: 00000000 LR: C0033A4C SP: C04B7E10 REGS: c04b7d60 TRAP: 0300    Not tainted
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c04b6000[4] 'kswapd' Last syscall: -1
last math c2aba000 last altivec 00000000
GPR00: C0033A4C C04B7E10 C04B6000 C031EE58 C01C14C8 0003D6C0 C04CC05C C024CCC4
GPR08: 00000F5B 00000088 C819B000 C0240000 C0240000 10041FBC C3F5E10C 11000000
GPR16: 00000000 11559000 11000000 C3F5E10C C56612CC 00000015 10C55000 10C49000
GPR24: FFFFFFFD C020FEDC 00ADF285 C04B7E68 C031EE70 C01C14C8 C031EE58 C031EE58
Call backtrace:
C0B75150 C0033A4C C003191C C0031E14 C00320A8 C0032140 C0032298
C0032320 C00324B0 C00066B8
Warning (Oops_read): Code line not seen, dumping what data is available


>>NIP; c0028ddc <add_to_page_cache_unique+28/d0>   <=====

>>GPR0; c0033a4c <add_to_swap_cache+c4/174>
>>GPR1; c04b7e10 <_end+243d6c/7f40f5c>
>>GPR2; c04b6000 <_end+241f5c/7f40f5c>
>>GPR3; c031ee58 <_end+aadb4/7f40f5c>
>>GPR4; c01c14c8 <swapper_space+0/34>
>>GPR6; c04cc05c <_end+257fb8/7f40f5c>
>>GPR7; c024ccc4 <swap_info+0/700>
>>GPR10; c819b000 <_end+7f26f5c/7f40f5c>
>>GPR11; c0240000 <nvramData+4f44/8000>
>>GPR12; c0240000 <nvramData+4f44/8000>
>>GPR14; c3f5e10c <_end+3cea068/7f40f5c>
>>GPR19; c3f5e10c <_end+3cea068/7f40f5c>
>>GPR20; c56612cc <_end+53ed228/7f40f5c>
>>GPR25; c020fedc <mem_pieces_print+4/74>
>>GPR27; c04b7e68 <_end+243dc4/7f40f5c>
>>GPR28; c031ee70 <_end+aadcc/7f40f5c>
>>GPR29; c01c14c8 <swapper_space+0/34>
>>GPR30; c031ee58 <_end+aadb4/7f40f5c>
>>GPR31; c031ee58 <_end+aadb4/7f40f5c>

Trace; c0b75150 <_end+9010ac/7f40f5c>
Trace; c0033a4c <add_to_swap_cache+c4/174>
Trace; c003191c <swap_out+43c/598>
Trace; c0031e14 <shrink_cache+39c/43c>
Trace; c00320a8 <shrink_caches+68/ac>
Trace; c0032140 <try_to_free_pages_zone+54/88>
Trace; c0032298 <kswapd_balance_pgdat+68/c4>
Trace; c0032320 <kswapd_balance+2c/58>
Trace; c00324b0 <kswapd+b8/d0>
Trace; c00066b8 <kernel_thread+2c/38>


10 warnings issued.  Results may not be reliable.




ksymoops 2.4.6 on ppc 2.4.20-pre9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre9/ (default)
     -m /boot/System.map-2.4.20-pre9 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol xchg_u32  , ksyms_base says c000b88c, System.map says c0006424.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says c8212b0c, /lib/modules/2.4.20-pre9/kernel/fs/lockd/lockd.o says c820500c.  Ignoring /lib/modules/2.4.20-pre9/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says c82028e8, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f1018.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says c82028ec, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f101c.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says c82028f0, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f1020.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says c82028e4, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f1014.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol packet_socks_nr  , af_packet says c81ecdd4, /lib/modules/2.4.20-pre9/kernel/net/packet/af_packet.o says c81e9004.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/packet/af_packet.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says c81de720, /lib/modules/2.4.20-pre9/kernel/drivers/usb/usbcore.o says c81cd000.  Ignoring /lib/modules/2.4.20-pre9/kernel/drivers/usb/usbcore.o entry
Oops: kernel access of bad area, sig: 11
NIP: C00294D4 XER: 20000000 LR: C0029588 SP: C3DFBE90 REGS: c3dfbde0 TRAP: 0300    Not tainted
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c3dfa000[530] 'bk' Last syscall: 4
last math 00000000 last altivec 00000000
GPR00: C0029588 C3DFBE90 C3DFA000 C4911AE8 000005D7 00000088 C2059794 00000000
GPR08: 00000000 00000063 C0240000 C04C0000 80808080 10111C54 C2059794 00000000
GPR16: C4911A88 C4911AA0 C2059774 C4911AE8 FFFFFFF4 30016000 00001000 00000000
GPR24: C4911A1C C04CC05C 00001000 000005D7 00000088 C4911AE8 000005D7 00000088
Call backtrace:
00000000 C0029588 C002C464 C003AB14 C0003C7C 00000000 0FF209BC
0FF208C8 0FF20D88 0FF216E4 0FF15F44 1002C75C 10002BCC 100025F4
0FECAC50 00000000
Warning (Oops_read): Code line not seen, dumping what data is available


>>NIP; c00294d4 <__find_lock_page_helper+30/d0>   <=====

>>GPR0; c0029588 <__find_lock_page+14/24>
>>GPR1; c3dfbe90 <_end+3b87dec/7f40f5c>
>>GPR2; c3dfa000 <_end+3b85f5c/7f40f5c>
>>GPR3; c4911ae8 <_end+469da44/7f40f5c>
>>GPR6; c2059794 <_end+1de56f0/7f40f5c>
>>GPR10; c0240000 <nvramData+4f44/8000>
>>GPR11; c04c0000 <_end+24bf5c/7f40f5c>
>>GPR14; c2059794 <_end+1de56f0/7f40f5c>
>>GPR16; c4911a88 <_end+469d9e4/7f40f5c>
>>GPR17; c4911aa0 <_end+469d9fc/7f40f5c>
>>GPR18; c2059774 <_end+1de56d0/7f40f5c>
>>GPR19; c4911ae8 <_end+469da44/7f40f5c>
>>GPR24; c4911a1c <_end+469d978/7f40f5c>
>>GPR25; c04cc05c <_end+257fb8/7f40f5c>
>>GPR29; c4911ae8 <_end+469da44/7f40f5c>

Trace; 00000000 Before first symbol
Trace; c0029588 <__find_lock_page+14/24>
Trace; c002c464 <generic_file_write+484/828>
Trace; c003ab14 <sys_write+c8/14c>
Trace; c0003c7c <ret_from_syscall_1+0/b4>
Trace; 00000000 Before first symbol
Trace; 0ff209bc Before first symbol
Trace; 0ff208c8 Before first symbol
Trace; 0ff20d88 Before first symbol
Trace; 0ff216e4 Before first symbol
Trace; 0ff15f44 Before first symbol
Trace; 1002c75c Before first symbol
Trace; 10002bcc Before first symbol
Trace; 100025f4 Before first symbol
Trace; 0fecac50 Before first symbol
Trace; 00000000 Before first symbol


10 warnings issued.  Results may not be reliable.






ksymoops 2.4.6 on ppc 2.4.20-pre9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre9/ (default)
     -m /boot/System.map-2.4.20-pre9 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol xchg_u32  , ksyms_base says c000b88c, System.map says c0006424.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says c8212b0c, /lib/modules/2.4.20-pre9/kernel/fs/lockd/lockd.o says c820500c.  Ignoring /lib/modules/2.4.20-pre9/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says c82028e8, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f1018.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says c82028ec, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f101c.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says c82028f0, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f1020.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says c82028e4, /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o says c81f1014.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol packet_socks_nr  , af_packet says c81ecdd4, /lib/modules/2.4.20-pre9/kernel/net/packet/af_packet.o says c81e9004.  Ignoring /lib/modules/2.4.20-pre9/kernel/net/packet/af_packet.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says c81de720, /lib/modules/2.4.20-pre9/kernel/drivers/usb/usbcore.o says c81cd000.  Ignoring /lib/modules/2.4.20-pre9/kernel/drivers/usb/usbcore.o entry
Oops: kernel access of bad area, sig: 11
NIP: C00294D4 XER: 20000000 LR: C0029588 SP: C6735E90 REGS: c6735de0 TRAP: 0300    Not tainted
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c6734000[580] 'bk' Last syscall: 4
last math 00000000 last altivec 00000000
GPR00: C0029588 C6735E90 C6734000 C0E16110 000001EA 00000088 C16047B4 00000000
GPR08: 00000000 00000075 C0240000 C04C0000 80808080 10111C54 C16047B4 00000000
GPR16: C0E160B0 C0E160C8 C1604794 C0E16110 FFFFFFF4 30016000 00001000 00000000
GPR24: C0E16044 C04CC05C 00001000 000001EA 00000088 C0E16110 000001EA 00000088
Call backtrace:
00000000 C0029588 C002C464 C003AB14 C0003C7C 00000000 0FF209BC
0FF208C8 0FF20D88 0FF216E4 0FF15F44 1002C75C 10002BCC 100025F4
0FECAC50 00000000
Warning (Oops_read): Code line not seen, dumping what data is available


>>NIP; c00294d4 <__find_lock_page_helper+30/d0>   <=====

>>GPR0; c0029588 <__find_lock_page+14/24>
>>GPR1; c6735e90 <_end+64c1dec/7f40f5c>
>>GPR2; c6734000 <_end+64bff5c/7f40f5c>
>>GPR3; c0e16110 <_end+ba206c/7f40f5c>
>>GPR6; c16047b4 <_end+1390710/7f40f5c>
>>GPR10; c0240000 <nvramData+4f44/8000>
>>GPR11; c04c0000 <_end+24bf5c/7f40f5c>
>>GPR14; c16047b4 <_end+1390710/7f40f5c>
>>GPR16; c0e160b0 <_end+ba200c/7f40f5c>
>>GPR17; c0e160c8 <_end+ba2024/7f40f5c>
>>GPR18; c1604794 <_end+13906f0/7f40f5c>
>>GPR19; c0e16110 <_end+ba206c/7f40f5c>
>>GPR24; c0e16044 <_end+ba1fa0/7f40f5c>
>>GPR25; c04cc05c <_end+257fb8/7f40f5c>
>>GPR29; c0e16110 <_end+ba206c/7f40f5c>

Trace; 00000000 Before first symbol
Trace; c0029588 <__find_lock_page+14/24>
Trace; c002c464 <generic_file_write+484/828>
Trace; c003ab14 <sys_write+c8/14c>
Trace; c0003c7c <ret_from_syscall_1+0/b4>
Trace; 00000000 Before first symbol
Trace; 0ff209bc Before first symbol
Trace; 0ff208c8 Before first symbol
Trace; 0ff20d88 Before first symbol
Trace; 0ff216e4 Before first symbol
Trace; 0ff15f44 Before first symbol
Trace; 1002c75c Before first symbol
Trace; 10002bcc Before first symbol
Trace; 100025f4 Before first symbol
Trace; 0fecac50 Before first symbol
Trace; 00000000 Before first symbol


10 warnings issued.  Results may not be reliable.


-- 
Meelis Roos (mroos@linux.ee)

