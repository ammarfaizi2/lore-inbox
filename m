Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289118AbSAVBCu>; Mon, 21 Jan 2002 20:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289119AbSAVBCk>; Mon, 21 Jan 2002 20:02:40 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:10637 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289118AbSAVBC1>; Mon, 21 Jan 2002 20:02:27 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201220102.g0M12Nj18568@eng2.beaverton.ibm.com>
Subject: kernel panic with pte-highmem-5 
To: andrea@suse.de, linux-kernel@vger.kernel.org
Date: Mon, 21 Jan 2002 17:02:23 -0800 (PST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

I am testing your pte-highmem-5 patch with some of my database workloads.
I got following OOPS when I tried to startup the database. I am running
2.4.18-pre2aa2 + pte-highmem-5 + vmscan.c (swap_out_pmd) fix.

If you already have fix for this, please pass it on. If you need any
more information please let me know.

Machine configuration: 8x 700 MHz Pentium-III with 12GB RAM

Regards,
Badari


Jan 21 17:43:59 elm3b78 kernel: Unable to handle kernel paging request at virtual address ffe00000
Jan 21 17:43:59 elm3b78 kernel: c01225e6
Jan 21 17:43:59 elm3b78 kernel: *pde = bfffff08
Jan 21 17:43:59 elm3b78 kernel: Oops: 0000
Jan 21 17:43:59 elm3b78 kernel: CPU:    1
Jan 21 17:43:59 elm3b78 kernel: EIP:    0010:[<c01225e6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 21 17:43:59 elm3b78 kernel: EFLAGS: 00010286
Jan 21 17:43:59 elm3b78 kernel: eax: f6dfea20   ebx: c20b3a40   ecx: 00000000   edx: f71d8000
Jan 21 17:43:59 elm3b78 kernel: esi: 00000000   edi: ffe00000   ebp: dfda6210   esp: f71d9f0c
Jan 21 17:43:59 elm3b78 kernel: ds: 0018   es: 0018   ss: 0018
Jan 21 17:43:59 elm3b78 kernel: Process oracle (pid: 1161, stackpage=f71d9000)
Jan 21 17:43:59 elm3b78 kernel: Stack: ce411b80 ceb20500 f71d8000 f6d672a0 f71d8000 f71d8000 ff376000 d3f48210
Jan 21 17:43:59 elm3b78 kernel:        00000000 0a1b5000 08400000 ce410f20 f6dfdee0 c0113eb7 ce411b80 f6dfea20
Jan 21 17:43:59 elm3b78 kernel:        ceb20500 f70d0000 f7022fc4 d8e76564 ce41b120 ceb20500 f6dfea3c f71d8000
Jan 21 17:43:59 elm3b78 kernel: Call Trace: [<c0113eb7>] [<c01147fc>] [<c0105940>] [<c0106dab>]
Jan 21 17:44:00 elm3b78 kernel: Code: 8b 1f 8b 77 04 85 db 75 04 85 f6 74 7e 88 d8 a8 81 75 0b 53

>>EIP; c01225e6 <copy_page_range+1c2/400>   <=====
Trace; c0113eb7 <copy_mm+267/31c>
Trace; c01147fc <do_fork+494/750>
Trace; c0105940 <sys_fork+14/1c>
Trace; c0106dab <system_call+33/38>
Code;  c01225e6 <copy_page_range+1c2/400>
00000000 <_EIP>:
Code;  c01225e6 <copy_page_range+1c2/400>   <=====
   0:   8b 1f                     mov    (%edi),%ebx   <=====
Code;  c01225e8 <copy_page_range+1c4/400>
   2:   8b 77 04                  mov    0x4(%edi),%esi
Code;  c01225eb <copy_page_range+1c7/400>
   5:   85 db                     test   %ebx,%ebx
Code;  c01225ed <copy_page_range+1c9/400>
   7:   75 04                     jne    d <_EIP+0xd> c01225f3 <copy_page_range+1cf/400>
Code;  c01225ef <copy_page_range+1cb/400>
   9:   85 f6                     test   %esi,%esi
Code;  c01225f1 <copy_page_range+1cd/400>
   b:   74 7e                     je     8b <_EIP+0x8b> c0122671 <copy_page_range+24d/400>
Code;  c01225f3 <copy_page_range+1cf/400>
   d:   88 d8                     mov    %bl,%al
Code;  c01225f5 <copy_page_range+1d1/400>
   f:   a8 81                     test   $0x81,%al
Code;  c01225f7 <copy_page_range+1d3/400>
  11:   75 0b                     jne    1e <_EIP+0x1e> c0122604 <copy_page_range+1e0/400>
Code;  c01225f9 <copy_page_range+1d5/400>
  13:   53                        push   %ebx


