Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318230AbSHMQRo>; Tue, 13 Aug 2002 12:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318240AbSHMQRo>; Tue, 13 Aug 2002 12:17:44 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:55283 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S318230AbSHMQRl>;
	Tue, 13 Aug 2002 12:17:41 -0400
Date: Tue, 13 Aug 2002 19:21:30 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre2 NFS OOPS on sparc64
Message-ID: <Pine.GSO.4.43.0208131916340.16824-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2 oopses from stock 2.4.20-pre2 during NFS startup 9mountd etc killed as
a result). Looks like a bad use of bitops inside sunrpc. egcs64 compiler
from debian.

ksymoops 2.4.6 on sparc64 2.4.20-pre2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre2/ (default)
     -m /boot/System.map-2.4.20-pre2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Aug 13 19:08:24 janku kernel: ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)
Aug 13 19:08:29 janku kernel:               \|/ ____ \|/
Aug 13 19:08:29 janku kernel:               "@'/ .. \`@"
Aug 13 19:08:29 janku kernel:               /_| \__/ |_\
Aug 13 19:08:29 janku kernel:                  \__U_/
Aug 13 19:08:29 janku kernel: rpc.nfsd(545): Kernel does fpu/atomic unaligned load/store.
Aug 13 19:08:29 janku kernel: TSTATE: 0000004480009602 TPC: 00000000005bfae8 TNPC: 00000000005bfaec Y: 07000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
Aug 13 19:08:29 janku kernel: g0: 0000000000000011 g1: 0000000000000080 g2: 0000000000000007 g3: 0000000000000000
Aug 13 19:08:29 janku kernel: g4: fffff80000000000 g5: 0000000000000080 g6: fffff8000e0fc000 g7: 0000000000000000
Aug 13 19:08:29 janku kernel: o0: 0000000000000000 o1: fffff8000fe630b4 o2: fffff8000078ea80 o3: 00000000005a5360
Aug 13 19:08:29 janku kernel: o4: 00000000005a56a0 o5: fffff8000fe63078 sp: fffff8000e0ff061 ret_pc: 00000000005a5748
Aug 13 19:08:29 janku kernel: l0: fffff8000fe28270 l1: fffff8000fe63078 l2: 00000000005c9000 l3: 0000000000000000
Aug 13 19:08:29 janku kernel: l4: 000000005a2cf071 l5: 0000000000000000 l6: fffff8000e0fc000 l7: 0000000000432f20
Aug 13 19:08:29 janku kernel: i0: 0000000000000000 i1: 000000003d592efc i2: 00000000006d0c00 i3: 000000000000001c
Aug 13 19:08:29 janku kernel: i4: 00000000005b43e4 i5: 0000000000000000 i6: fffff8000e0ff121 i7: 00000000005a6a40
Aug 13 19:08:29 janku kernel: Caller[00000000005a6a40]
Aug 13 19:08:29 janku kernel: Caller[00000000005a6cbc]
Aug 13 19:08:29 janku kernel: Caller[00000000005a6ec4]
Aug 13 19:08:29 janku kernel: Caller[000000000201614c]
Aug 13 19:08:29 janku kernel: Caller[0000000002016988]
Aug 13 19:08:29 janku kernel: Caller[000000000047f228]
Aug 13 19:08:29 janku kernel: Caller[0000000000433048]
Aug 13 19:08:29 janku kernel: Caller[0000000000410674]
Aug 13 19:08:29 janku kernel: Caller[0000000000010cec]
Aug 13 19:08:29 janku kernel: Instruction DUMP: 9089c005  12600006  8219c005 <c3f25007> 80a1c001  3267fffb  ce5a4000  81c3e008  8143e00a


>>PC;  005bfae8 <__bitops_begin+28/40>   <=====

>>o3; 005a5360 <svc_udp_recvfrom+0/340>
>>o4; 005a56a0 <svc_udp_sendto+0/60>
>>ret_pc; 005a5748 <svc_udp_init+48/60>
>>l2; 005c9000 <tvecs+488/d40>
>>l7; 00432f20 <sys32_nfsservctl+0/1e0>
>>i2; 006d0c00 <reserve.607+80/e0>
>>i4; 005b43e4 <__bzero+1d8/274>
>>i7; 005a6a40 <svc_setup_socket+a0/200>

Trace; 005a6a40 <svc_setup_socket+a0/200>
Trace; 005a6cbc <svc_create_socket+11c/180>
Trace; 005a6ec4 <svc_makesock+44/60>
Trace; 0201614c <[nfsd].text.start+8c/1a0>
Trace; 02016988 <[nfsd]handle_sys_nfsservctl+108/3c0>
Trace; 0047f228 <sys_nfsservctl+68/c0>
Trace; 00433048 <sys32_nfsservctl+128/1e0>
Trace; 00410674 <linux_sparc_syscall32+34/40>
Trace; 00010cec Before first symbol

Code;  005bfadc <__bitops_begin+1c/40>
00000000 <_PC>:
Code;  005bfadc <__bitops_begin+1c/40>
   0:   90 89 c0 05       andcc  %g7, %g5, %o0
Code;  005bfae0 <__bitops_begin+20/40>
   4:   12 60 00 06       unknown
Code;  005bfae4 <__bitops_begin+24/40>
   8:   82 19 c0 05       xor  %g7, %g5, %g1
Code;  005bfae8 <__bitops_begin+28/40>   <=====
   c:   c3 f2 50 07       unknown   <=====
Code;  005bfaec <__bitops_begin+2c/40>
  10:   80 a1 c0 01       cmp  %g7, %g1
Code;  005bfaf0 <__bitops_begin+30/40>
  14:   32 67 ff fb       unknown
Code;  005bfaf4 <__bitops_begin+34/40>
  18:   ce 5a 40 00       unknown
Code;  005bfaf8 <__bitops_begin+38/40>
  1c:   81 c3 e0 08       retl
Code;  005bfafc <__bitops_begin+3c/40>
  20:   81 43 e0 0a       unknown

Aug 13 19:08:32 janku kernel:               \|/ ____ \|/
Aug 13 19:08:32 janku kernel:               "@'/ .. \`@"
Aug 13 19:08:32 janku kernel:               /_| \__/ |_\
Aug 13 19:08:32 janku kernel:                  \__U_/
Aug 13 19:08:32 janku kernel: amd(593): Kernel does fpu/atomic unaligned load/store.
Aug 13 19:08:32 janku kernel: TSTATE: 0000004411009600 TPC: 00000000005bfae8 TNPC: 00000000005bfaec Y: 07000000    Not tainted
Aug 13 19:08:32 janku kernel: g0: 0000000000000011 g1: 0000000000000080 g2: 0000000000000007 g3: 0000000000000000
Aug 13 19:08:32 janku kernel: g4: fffff80000000000 g5: 0000000000000080 g6: fffff8000d7e4000 g7: 0000000000000000
Aug 13 19:08:32 janku kernel: o0: 0000000000000000 o1: fffff8000fe63534 o2: fffff8000d8a19e0 o3: 00000000005a5360
Aug 13 19:08:32 janku kernel: o4: 00000000005a56a0 o5: fffff8000fe634f8 sp: fffff8000d7e6d21 ret_pc: 00000000005a5748
Aug 13 19:08:32 janku kernel: l0: fffff8000fe28270 l1: fffff8000fe634f8 l2: 00000000005c9000 l3: 0000000000000000
Aug 13 19:08:32 janku kernel: l4: 000000005a2cf071 l5: 0000000000049000 l6: 000000000003f400 l7: 0000000000049000
Aug 13 19:08:32 janku kernel: i0: 0000000000000000 i1: 000000003d592eff i2: 00000000006d0c00 i3: 000000000000001c
Aug 13 19:08:32 janku kernel: i4: 00000000005b43e4 i5: 0000000000000000 i6: fffff8000d7e6de1 i7: 00000000005a6a40
Aug 13 19:08:32 janku kernel: Caller[00000000005a6a40]
Aug 13 19:08:32 janku kernel: Caller[00000000005a6cbc]
Aug 13 19:08:32 janku kernel: Caller[00000000005a6ec4]
Aug 13 19:08:32 janku kernel: Caller[00000000004bfec8]
Aug 13 19:08:32 janku kernel: Caller[00000000004b1c84]
Aug 13 19:08:32 janku kernel: Caller[000000000046c8e8]
Aug 13 19:08:32 janku kernel: Caller[000000000046cae4]
Aug 13 19:08:32 janku kernel: Caller[000000000048076c]
Aug 13 19:08:32 janku kernel: Caller[0000000000480aa8]
Aug 13 19:08:32 janku kernel: Caller[000000000042ffa8]
Aug 13 19:08:32 janku kernel: Caller[0000000000410674]
Aug 13 19:08:32 janku kernel: Caller[000000007004affc]
Aug 13 19:08:32 janku kernel: Instruction DUMP: 9089c005  12600006  8219c005 <c3f25007> 80a1c001  3267fffb  ce5a4000  81c3e008  8143e00a


>>PC;  005bfae8 <__bitops_begin+28/40>   <=====

>>o3; 005a5360 <svc_udp_recvfrom+0/340>
>>o4; 005a56a0 <svc_udp_sendto+0/60>
>>ret_pc; 005a5748 <svc_udp_init+48/60>
>>l2; 005c9000 <tvecs+488/d40>
>>i2; 006d0c00 <reserve.607+80/e0>
>>i4; 005b43e4 <__bzero+1d8/274>
>>i7; 005a6a40 <svc_setup_socket+a0/200>

Trace; 005a6a40 <svc_setup_socket+a0/200>
Trace; 005a6cbc <svc_create_socket+11c/180>
Trace; 005a6ec4 <svc_makesock+44/60>
Trace; 004bfec8 <lockd_up+a8/1a0>
Trace; 004b1c84 <nfs_read_super+a04/a20>
Trace; 0046c8e8 <get_sb_nodev+48/c0>
Trace; 0046cae4 <do_kern_mount+84/160>
Trace; 0048076c <do_add_mount+6c/1a0>
Trace; 00480aa8 <do_mount+168/1a0>
Trace; 0042ffa8 <sys32_mount+108/160>
Trace; 00410674 <linux_sparc_syscall32+34/40>
Trace; 7004affc <END_OF_CODE+6dfe9c89/????>

Code;  005bfadc <__bitops_begin+1c/40>
00000000 <_PC>:
Code;  005bfadc <__bitops_begin+1c/40>
   0:   90 89 c0 05       andcc  %g7, %g5, %o0
Code;  005bfae0 <__bitops_begin+20/40>
   4:   12 60 00 06       unknown
Code;  005bfae4 <__bitops_begin+24/40>
   8:   82 19 c0 05       xor  %g7, %g5, %g1
Code;  005bfae8 <__bitops_begin+28/40>   <=====
   c:   c3 f2 50 07       unknown   <=====
Code;  005bfaec <__bitops_begin+2c/40>
  10:   80 a1 c0 01       cmp  %g7, %g1
Code;  005bfaf0 <__bitops_begin+30/40>
  14:   32 67 ff fb       unknown
Code;  005bfaf4 <__bitops_begin+34/40>
  18:   ce 5a 40 00       unknown
Code;  005bfaf8 <__bitops_begin+38/40>
  1c:   81 c3 e0 08       retl
Code;  005bfafc <__bitops_begin+3c/40>
  20:   81 43 e0 0a       unknown


1 warning issued.  Results may not be reliable.

-- 
Meelis Roos (mroos@linux.ee)

