Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130335AbQLIHSX>; Sat, 9 Dec 2000 02:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130486AbQLIHSO>; Sat, 9 Dec 2000 02:18:14 -0500
Received: from mx2.core.com ([208.40.40.41]:37777 "EHLO smtp-2.core.com")
	by vger.kernel.org with ESMTP id <S130335AbQLIHSB>;
	Sat, 9 Dec 2000 02:18:01 -0500
Message-ID: <3A31D5DA.2C8DA0E7@megsinet.net>
Date: Sat, 09 Dec 2000 00:48:58 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: another buffer.c:827 BUG, RAID1 reconstruction.
In-Reply-To: <A528EB7F25A2D111838100A0C9A6E5EF068A1DBC@exc01.oup.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this BUG report after test12-pre7 soft locked on my NFS server,
all nfsd's in D state and I had to reboot and system was rebuilding the
ide RAID1 arrays.

NFS client test12-pre7 was rebooted as well, root logged in, and ran ldconfig

NFS server BUG'd out

Hand copied OOPS hope too much isn't wrong.

Martin

heli:~$ ksymoops -K -L -O -m /boot/System.map-2.4.0-test12 < buffer.bug
ksymoops 2.3.5 on i586 2.2.17-RAID.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.0-test12 (specified)

Kernel BUG at buffer.c 827
invalid operand: 0000
CPU: 0
EIP: 0010:[<c012ca53>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 0000001c ebx: c10837d0 ecx: 00000000 edx: 00000000
esi: c1be2e40 edi: 00000002 epb: c1be2e88 esp: c0275ea8
ds:  0018 es: 0018 ss: 0018
Stack: c02151a5 c021545a 0000033b 0001e2ba 00000046 c13c7be0 cabe2e40 c011c226c
       c1b32e40 00000001 c13c7be0 c13c7bf8 00000001 00000001 c01c2392 c13c7be0
       00000001 c13c7b88 c11d3780 00000002 c0174c39 c13c7bf8 00000001 c11d3780
Call Trace: [<c0215195>] [<c021545a>] [<c01c226e>] [<c01c2399>] [<c0174c39>] [<c019db3b>] [<c01a60b4>]
            [<c019f367>] [<c01a6050>] [<c010a04f>] [<c010a1ae>] [<c01071f0>] [<ffffe000>] [<c0108f20>] [<c0107180>]
            [<ffffe000>] [<c0107213>] [<c0107277>] [<c0105000>] [<c0100191>]
code: 0f 06 83 c4 0c 8d 73 28 8d 43 2c 39 43 2c 74 15 b9 01 00 00

>>EIP; c012ca53 <end_buffer_io_async+c7/f4>   <=====
Trace; c0215195 <tvecs+318d/19d24>
Trace; c021545a <tvecs+3452/19d24>
Trace; c01c226e <raid1_end_bh_io+7e/110>
Trace; c01c2399 <raid1_end_request+99/a0>
Trace; c0174c39 <end_that_request_first+65/c4>
Trace; c019db3b <ide_end_request+27/74>
Trace; c01a60b4 <ide_dma_intr+64/9c>
Trace; c019f367 <ide_intr+fb/150>
Trace; c01a6050 <ide_dma_intr+0/9c>
Trace; c010a04f <handle_IRQ_event+2f/58>
Trace; c010a1ae <do_IRQ+6e/b0>
Trace; c01071f0 <default_idle+0/28>
Trace; ffffe000 <END_OF_CODE+3fd2af28/????>
Trace; c0108f20 <ret_from_intr+0/20>
Trace; c0107180 <init+a4/104>
Trace; ffffe000 <END_OF_CODE+3fd2af28/????>
Trace; c0107213 <default_idle+23/28>
Trace; c0107277 <cpu_idle+3f/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  c012ca53 <end_buffer_io_async+c7/f4>
00000000 <_EIP>:
Code;  c012ca53 <end_buffer_io_async+c7/f4>   <=====
   0:   0f 06                     clts      <=====
Code;  c012ca55 <end_buffer_io_async+c9/f4>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012ca58 <end_buffer_io_async+cc/f4>
   5:   8d 73 28                  lea    0x28(%ebx),%esi
Code;  c012ca5b <end_buffer_io_async+cf/f4>
   8:   8d 43 2c                  lea    0x2c(%ebx),%eax
Code;  c012ca5e <end_buffer_io_async+d2/f4>
   b:   39 43 2c                  cmp    %eax,0x2c(%ebx)
Code;  c012ca61 <end_buffer_io_async+d5/f4>
   e:   74 15                     je     25 <_EIP+0x25> c012ca78 <end_buffer_io_async+ec/f4>
Code;  c012ca63 <end_buffer_io_async+d7/f4>
  10:   b9 01 00 00 00            mov    $0x1,%ecx
 
Aiee, killing interrupt handler
heli:~$
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
