Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266599AbRGTGRW>; Fri, 20 Jul 2001 02:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266620AbRGTGRN>; Fri, 20 Jul 2001 02:17:13 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:54796 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S266599AbRGTGRE>; Fri, 20 Jul 2001 02:17:04 -0400
Date: Fri, 20 Jul 2001 08:16:04 +0200 (CEST)
From: Niels Kristian Bech Jensen <nkbj@image.dk>
X-X-Sender: <nkbj@hafnium.nkbj.dk>
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Oops in 2.4.7-pre9.
Message-ID: <Pine.LNX.4.33.0107200815230.858-100000@hafnium.nkbj.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I get this oops while booting 2.4.7-pre9:

Jul 20 08:01:52 hafnium kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000007c
Jul 20 08:01:52 hafnium kernel: c01467e3
Jul 20 08:01:52 hafnium kernel: *pde = 00000000
Jul 20 08:01:52 hafnium kernel: Oops: 0000
Jul 20 08:01:52 hafnium kernel: CPU:    0
Jul 20 08:01:52 hafnium kernel: EIP:    0010:[proc_pid_make_inode+131/176]
Jul 20 08:01:52 hafnium kernel: EIP:    0010:[<c01467e3>]
Using defaults from ksymoops -t elf32-i386 -a i386
Jul 20 08:01:52 hafnium kernel: EFLAGS: 00010206
Jul 20 08:01:52 hafnium kernel: eax: 00000000   ebx: c11ba000   ecx: c48c89c0   edx: c104b578
Jul 20 08:01:52 hafnium kernel: esi: c11ed000   edi: 0000000b   ebp: c01e0ca0   esp: c493de68
Jul 20 08:01:52 hafnium kernel: ds: 0018   es: 0018   ss: 0018
Jul 20 08:01:52 hafnium kernel: Process pidof (pid: 177, stackpage=c493d000)
Jul 20 08:01:52 hafnium kernel: Stack: c11ba000 0000000b c01bf0aa c0146a3a c11ed000 c11ba000 0000000b c11ba000
Jul 20 08:01:52 hafnium kernel:        ffffffea fffffff4 c01406a8 c1157e08 000000f0 c4b6c9a0 fffffff4 c48c87e0
Jul 20 08:01:52 hafnium kernel:        c4b6c920 c01388cf c48c87e0 c4b6c9a0 c493df00 c4b6c920 c4b6c920 c4fee00c
Jul 20 08:01:52 hafnium kernel: Call Trace: [proc_base_lookup+138/544] [d_alloc+24/368] [real_lookup+79/192] [path_walk+1409/2000] [destroy_inode+48/64] [open_namei+124/1360] [filp_open+52/96]
Jul 20 08:01:52 hafnium kernel: Call Trace: [<c0146a3a>] [<c01406a8>] [<c01388cf>] [<c0138fd1>] [<c0141050>] [<c013972c>] [<c012e334>]
Jul 20 08:01:52 hafnium kernel:        [<c013861f>] [<c012e636>] [<c0106cf3>]
Jul 20 08:01:52 hafnium kernel: Code: f6 40 7c 01 74 12 8b 83 24 01 00 00 89 41 30 8b 83 34 01 00

>>EIP; c01467e3 <proc_pid_make_inode+83/b0>   <=====
Trace; c0146a3a <proc_base_lookup+8a/220>
Trace; c01406a8 <d_alloc+18/170>
Trace; c01388cf <real_lookup+4f/c0>
Trace; c0138fd1 <path_walk+581/7d0>
Trace; c0141050 <destroy_inode+30/40>
Trace; c013972c <open_namei+7c/550>
Trace; c012e334 <filp_open+34/60>
Trace; c013861f <getname+5f/a0>
Trace; c012e636 <sys_open+36/b0>
Trace; c0106cf3 <system_call+33/40>
Code;  c01467e3 <proc_pid_make_inode+83/b0>
00000000 <_EIP>:
Code;  c01467e3 <proc_pid_make_inode+83/b0>   <=====
   0:   f6 40 7c 01               testb  $0x1,0x7c(%eax)   <=====
Code;  c01467e7 <proc_pid_make_inode+87/b0>
   4:   74 12                     je     18 <_EIP+0x18> c01467fb <proc_pid_make_inode+9b/b0>
Code;  c01467e9 <proc_pid_make_inode+89/b0>
   6:   8b 83 24 01 00 00         mov    0x124(%ebx),%eax
Code;  c01467ef <proc_pid_make_inode+8f/b0>
   c:   89 41 30                  mov    %eax,0x30(%ecx)
Code;  c01467f2 <proc_pid_make_inode+92/b0>
   f:   8b 83 34 01 00 00         mov    0x134(%ebx),%eax



-- 
Niels Kristian Bech Jensen -- nkbj@image.dk -- http://www.image.dk/~nkbj/

----------->>  Stop software piracy --- use free software!  <<-----------

