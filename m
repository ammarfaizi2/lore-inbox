Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286222AbRL0GSv>; Thu, 27 Dec 2001 01:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285169AbRL0GSm>; Thu, 27 Dec 2001 01:18:42 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:58837 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S286222AbRL0GSX>; Thu, 27 Dec 2001 01:18:23 -0500
Date: Thu, 27 Dec 2001 08:17:20 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, <kaos@ocs.com.au>
Subject: Re: BUG and Kernel Panic on 2.5.2-pre1 with loop and cdrom 
In-Reply-To: <11207.1009422284@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0112270813090.28333-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
mount /dev/fd0 /floppy -o loop gives a "better" dump :) This is on
2.5.2-pre2 (The END_OF_CODE is because i didn't do modprobe loop before
running ksymoops. Thanks to Keith Owens for that) but we know where the
bug really is now.

invalid operand: 0000
CPU:    0
EIP:    0010:[<c020c065>]    Not tainted
EFLAGS: 00010286
eax: 00000020   ebx: c88db1a4   ecx: c0304cc4   edx: 000025e1
esi: cae38c64   edi: cae95000   ebp: 00000000   esp: c8adff9c
ds: 0018   es: 0018   ss: 0018
Process loop0 (pid: 697, stackpage=c8adf000)
Stack: c02e1c03 00000554 cae38c64 cae38f64 c014dd33 cae38c64 00000000 cc9170a2
       cae38c64 00000001 00000000 cae95000 cae38f64 cae38c64 00000000 00000000
       00000000 c1560018 00000f00 ca13bf30 00000000 c0107286 cae95000 cc916e80
Call Trace: [<c014dd33>] [<cc9170a2>] [<c0107286>] [<cc916e80>]

Code: 0f 0b 58 5a 8b 46 0c 83 e0 01 50 53 ff 53 34 56 e8 b6 14 f4

 Jan  1 02:12:34 mondecino kernel: kernel BUG at ll_rw_blk.c:1364!
Jan  1 02:12:34 mondecino kernel: invalid operand: 0000
Jan  1 02:12:34 mondecino kernel: CPU:    0
Jan  1 02:12:34 mondecino kernel: EIP:    0010:[end_bio_bh_io_sync+37/80]    Not tainted
Jan  1 02:12:34 mondecino kernel: EIP:    0010:[<c020c065>]    Not tainted
Jan  1 02:12:34 mondecino kernel: EFLAGS: 00010286
Jan  1 02:12:34 mondecino kernel: eax: 00000020   ebx: c88db1a4   ecx: c0304cc4   edx: 000025e1
Jan  1 02:12:34 mondecino kernel: esi: cae38c64   edi: cae95000   ebp: 00000000   esp: c8adff9c
Jan  1 02:12:34 mondecino kernel: ds: 0018   es: 0018   ss: 0018
Jan  1 02:12:34 mondecino kernel: Process loop0 (pid: 697, stackpage=c8adf000)
Jan  1 02:12:34 mondecino kernel: Stack: c02e1c03 00000554 cae38c64 cae38f64 c014dd33 cae38c64 000
Jan  1 02:12:34 mondecino kernel:        cae38c64 00000001 00000000 cae95000 cae38f64 cae38c64 000
Jan  1 02:12:34 mondecino kernel:        00000000 c1560018 00000f00 ca13bf30 00000000 c0107286 cae
Jan  1 02:12:34 mondecino kernel: Call Trace: [bio_endio+35/48] [sound:num_midis_Rsmp_a1eae7cf+814
Jan  1 02:12:34 mondecino kernel: Call Trace: [<c014dd33>] [<cc9170a2>] [<c0107286>] [<cc916e80>]
Jan  1 02:12:34 mondecino kernel:
Jan  1 02:12:34 mondecino kernel: Code: 0f 0b 58 5a 8b 46 0c 83 e0 01 50 53 ff 53 34 56 e8 b6 14 f

>>EIP; c020c065 <end_bio_bh_io_sync+25/50>   <=====
Trace; c014dd33 <bio_endio+23/30>
Trace; cc9170a2 <END_OF_CODE+90a42/????>
Trace; c0107286 <kernel_thread+26/30>
Trace; cc916e80 <END_OF_CODE+90820/????>
Code;  c020c065 <end_bio_bh_io_sync+25/50>
00000000 <_EIP>:
Code;  c020c065 <end_bio_bh_io_sync+25/50>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c020c067 <end_bio_bh_io_sync+27/50>
   2:   58                        pop    %eax
Code;  c020c068 <end_bio_bh_io_sync+28/50>
   3:   5a                        pop    %edx
Code;  c020c069 <end_bio_bh_io_sync+29/50>
   4:   8b 46 0c                  mov    0xc(%esi),%eax
Code;  c020c06c <end_bio_bh_io_sync+2c/50>
   7:   83 e0 01                  and    $0x1,%eax
Code;  c020c06f <end_bio_bh_io_sync+2f/50>
   a:   50                        push   %eax
Code;  c020c070 <end_bio_bh_io_sync+30/50>
   b:   53                        push   %ebx
Code;  c020c071 <end_bio_bh_io_sync+31/50>
   c:   ff 53 34                  call   *0x34(%ebx)
Code;  c020c074 <end_bio_bh_io_sync+34/50>
   f:   56                        push   %esi
Code;  c020c075 <end_bio_bh_io_sync+35/50>
  10:   e8 b6 14 f4 00            call   f414cb <_EIP+0xf414cb> c114d530 <_end+d6c100/c444c30>

