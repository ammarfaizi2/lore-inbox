Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129824AbQLGCLZ>; Wed, 6 Dec 2000 21:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbQLGCLQ>; Wed, 6 Dec 2000 21:11:16 -0500
Received: from thirteenthfloor.net ([64.84.54.230]:25869 "EHLO
	protelligence.net") by vger.kernel.org with ESMTP
	id <S129824AbQLGCLI>; Wed, 6 Dec 2000 21:11:08 -0500
Message-Id: <4.3.2.7.2.20001206172756.00d06570@protelligence.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 06 Dec 2000 17:41:24 -0800
To: linux-kernel@vger.kernel.org
From: Paul Marshall <pmarshal@protelligence.com>
Subject: Kernel Oops. Possible motherboard problem
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been having trouble with a server crashing for the last few months. The machine seems to run fine for a few days and then unexpectedly crashes or locks up. I have tried numerous things to resolve the problem. At first the issue appeared memory related so I swapped the memory. Still crashed. I have also added another hard drive. Based on the kernel opuses I had been checking the programs that own the processes that crash, however, I also read somewhere that software can not cause Kernel panics or Kernel oopses. I read that only a kernel bug or a hardware problem can cause the oops. As a result, I upgraded the kernel and the machine ran fine for 5 days and then crashed. I think I have a decent amount of experience, however I have not had to trouble shoot an issue like this before. I have run the latest oopses through ksymoops. I would appreciate some help in understanding what they mean and what the actual problem might be. Here are the messages

ksymoops 0.7c on i686 2.2.16-3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.16-3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Dec  4 23:08:31 ws1 kernel: Unable to handle kernel paging request at virtual address 91d1bfc8 
Dec  4 23:08:31 ws1 kernel: current->tss.cr3 = 00101000, %cr3 = 00101000 
Dec  4 23:08:31 ws1 kernel: *pde = 00000000 
Dec  4 23:08:31 ws1 kernel: Oops: 0000 
Dec  4 23:08:31 ws1 kernel: CPU:    0 
Dec  4 23:08:31 ws1 kernel: EIP:    0010:[kmem_cache_free+64/372] 
Dec  4 23:08:31 ws1 kernel: EFLAGS: 00010086 
Dec  4 23:08:31 ws1 kernel: eax: 0000005c   ebx: d1d1b8a0   ecx: 91d1bfc0   edx: d1d1b8fc 
Dec  4 23:08:31 ws1 kernel: esi: dff94740   edi: 00000286   ebp: c052f668   esp: dfeebf70 
Dec  4 23:08:31 ws1 kernel: ds: 0018   es: 0018   ss: 0018 
Dec  4 23:08:31 ws1 kernel: Process kswapd (pid: 5, process nr: 5, stackpage=dfeeb000) 
Dec  4 23:08:31 ws1 kernel: Stack: d1d1b8a0 c052f668 d1d1b8fc c0232000 c0127b1d dff94740 d1d1b8a0 d1d1b8a0  
Dec  4 23:08:31 ws1 kernel:        d1d1b8a0 c0128883 d1d1b8a0 d1d1b8a0 c052f668 000007f6 00000030 00001000  
Dec  4 23:08:31 ws1 kernel:        c011d4f6 c052f668 00000010 00000006 00000030 c0122272 00000006 00000030  
Dec  4 23:08:31 ws1 kernel: Call Trace: [put_unused_buffer_head+33/76] [try_to_free_buffers+75/136] [shrink_mmap+238/324] [do_try_to_free_pages+38/120] [tvecs+7374/13920] [kswapd+115/180] [get_options+0/116]  
Dec  4 23:08:31 ws1 kernel: Code: 8b 69 08 81 fd 2b 2f c3 a5 0f 85 d9 00 00 00 8b 69 0c 85 ed  
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 69 08                  mov    0x8(%ecx),%ebp
Code;  00000003 Before first symbol
   3:   81 fd 2b 2f c3 a5         cmp    $0xa5c32f2b,%ebp
Code;  00000009 Before first symbol
   9:   0f 85 d9 00 00 00         jne    e8 <_EIP+0xe8> 000000e8 Before first symbol
Code;  0000000f Before first symbol
   f:   8b 69 0c                  mov    0xc(%ecx),%ebp
Code;  00000012 Before first symbol
  12:   85 ed                     test   %ebp,%ebp


1 warning issued.  Results may not be reliable.



ksymoops 0.7c on i686 2.2.16-3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.16-3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Dec  4 23:09:45 ws1 kernel: Unable to handle kernel paging request at virtual address 91d1b854 
Dec  4 23:09:45 ws1 kernel: current->tss.cr3 = 01025000, %cr3 = 01025000 
Dec  4 23:09:45 ws1 kernel: *pde = 00000000 
Dec  4 23:09:45 ws1 kernel: Oops: 0000 
Dec  4 23:09:45 ws1 kernel: CPU:    0 
Dec  4 23:09:45 ws1 kernel: EIP:    0010:[try_to_free_buffers+18/136] 
Dec  4 23:09:45 ws1 kernel: EFLAGS: 00010287 
Dec  4 23:09:45 ws1 kernel: eax: 91d1b840   ebx: c052cf08   ecx: 00000013   edx: 00040000 
Dec  4 23:09:45 ws1 kernel: esi: 91d1b840   edi: d1d1b840   ebp: c052cf08   esp: c269fe9c 
Dec  4 23:09:45 ws1 kernel: ds: 0018   es: 0018   ss: 0018 
Dec  4 23:09:45 ws1 kernel: Process opbs (pid: 24222, process nr: 94, stackpage=c269f000) 
Dec  4 23:09:45 ws1 kernel: Stack: 00000013 0097c000 c011d4f6 c052cf08 0000001c 00000006 00000013 c0122272  
Dec  4 23:09:45 ws1 kernel:        00000006 00000013 00000001 00000013 00000013 c01223a0 00000013 c269e000  
Dec  4 23:09:45 ws1 kernel:        df3b4aa0 c0122bb8 00000013 00961000 df3b4aa0 00000000 0097c000 c052ccd8  
Dec  4 23:09:45 ws1 kernel: Call Trace: [shrink_mmap+238/324] [do_try_to_free_pages+38/120] [try_to_free_pages+40/52] [__get_free_pages+180/1020] [try_to_read_ahead+47/276] [do_generic_file_read+750/1508] [generic_file_read+99/124]  
Dec  4 23:09:46 ws1 kernel: Code: 8b 76 14 83 78 20 00 75 06 f6 40 18 46 74 0f 6a 00 e8 70 01  
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 76 14                  mov    0x14(%esi),%esi
Code;  00000003 Before first symbol
   3:   83 78 20 00               cmpl   $0x0,0x20(%eax)
Code;  00000007 Before first symbol
   7:   75 06                     jne    f <_EIP+0xf> 0000000f Before first symbol
Code;  00000009 Before first symbol
   9:   f6 40 18 46               testb  $0x46,0x18(%eax)
Code;  0000000d Before first symbol
   d:   74 0f                     je     1e <_EIP+0x1e> 0000001e Before first symbol
Code;  0000000f Before first symbol
   f:   6a 00                     push   $0x0
Code;  00000011 Before first symbol
  11:   e8 70 01 00 00            call   186 <_EIP+0x186> 00000186 Before first symbol


1 warning issued.  Results may not be reliable.


Any help or assistance would be greatly appreciated. Please cc pmarshal@protelligence.com when replying.

Thanks.

Paul Marshall 
Paul Marshall -- President, CEO
Protelligence
Internet Consulting and Marketing
http://www.protelligence.com  415-482-0700

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
