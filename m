Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286446AbRL0SK7>; Thu, 27 Dec 2001 13:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286447AbRL0SKr>; Thu, 27 Dec 2001 13:10:47 -0500
Received: from isis.telemach.net ([213.143.65.10]:64264 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S286429AbRL0SJy>;
	Thu, 27 Dec 2001 13:09:54 -0500
Date: Thu, 27 Dec 2001 19:09:54 +0100
From: Jure Pecar <pegasus@telemach.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17-rc1 oops
Message-Id: <20011227190954.6b504c04.pegasus@telemach.net>
Organization: Select Technology 
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

This happened yesterday on our 4-way system with highmem:

ksymoops 0.7c on i686 2.4.17-rc1.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-rc1/ (default)
     -m /usr/src/linux/System.map (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c01ee900, vmlinux says c0156eb0.  Ignoring ksyms_base entry
Dec 26 09:06:00 castor kernel: invalid operand: 0000 
Dec 26 09:06:00 castor kernel: CPU:    0 
Dec 26 09:06:00 castor kernel: EIP:    0010:[__free_pages_ok+75/508]  Not tainted 
Dec 26 09:06:00 castor kernel: EFLAGS: 00010202 
Dec 26 09:06:00 castor kernel: eax: 00000840   ebx: c1e1dec0   ecx: c1e1dec0   edx: 00000000 
Dec 26 09:06:00 castor kernel: esi: fe2b6fdd   edi: 00000000   ebp: 00000000   esp: f1d79ef4 
Dec 26 09:06:00 castor kernel: ds: 0018   es: 0018   ss: 0018 
Dec 26 09:06:00 castor kernel: Process ps (pid: 32579, stackpage=f1d79000)

Dec 26 09:06:00 castor kernel: Stack: 00000360 fe2b6fdd 00000000 d3778000 e979a700 bffffc7d 00000000 00000000  
Dec 26 09:06:00 castor kernel:        00000360 c012e8d8 c011de64 e979a700 00000000 00000360 d8124000 f1d79f44  
Dec 26 09:06:00 castor kernel:        f1d78000 e979a71c d3778000 e979a700 c1e1dec0 f4c973e0 c0152319 d8124000  
Dec 26 09:06:00 castor kernel: Call Trace: [__free_pages+28/32] [access_process_vm+368/432] [proc_pid_environ+85/104]
[proc_info_read+89/296] [sys_read+142/196]  
Dec 26 09:06:00 castor kernel: Code: 0f 0b 8b 43 18 a8 80 74 02 0f 0b 80
63 18 eb be 00 e0 ff ff 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  00000005 Before first symbol
   5:   a8 80                     test   $0x80,%al
Code;  00000007 Before first symbol
   7:   74 02                     je     b <_EIP+0xb> 0000000b Before
first symbol
Code;  00000009 Before first symbol
   9:   0f 0b                     ud2a   
Code;  0000000b Before first symbol
   b:   80 63 18 eb               andb   $0xeb,0x18(%ebx)
Code;  0000000f Before first symbol
   f:   be 00 e0 ff ff            mov    $0xffffe000,%esi


1 warning issued.  Results may not be reliable.


This box is a heavily loaded mail server, running what once was redhat
6.2. When users started complaining, it was around 13h and loadavg was
~400 and still growing. I couldn't even list the processes, hard reset was
the only option to put things back into normal quickly. Luckily I have ext3 :)

Any ideas?

--

Jure Pecar

