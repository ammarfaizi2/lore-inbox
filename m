Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284189AbRLPB4w>; Sat, 15 Dec 2001 20:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284195AbRLPB4m>; Sat, 15 Dec 2001 20:56:42 -0500
Received: from dorf.wh.uni-dortmund.de ([129.217.255.136]:40455 "HELO
	mail.dorf.wh.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S284189AbRLPB4e>; Sat, 15 Dec 2001 20:56:34 -0500
Date: Sun, 16 Dec 2001 02:56:22 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Oops with 2.4.16-pre1 (nfs related)
Message-ID: <20011216015622.GA913@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

today I had the following oops which makes the machine hang.
Lots of processes where in D state and I had no keyboard so
I pushed the Big Button and rebooted.

The kernel runs without modules and uses ext3.
Hardware is an old AMD K6-2, 384MB RAM, IDE Disks
VIA chipset ... what else is important ?

Maybe the kernel is a bit old but I wanted to report it
anyways. The machine was/is very stable otherwise.

ksymoops 2.4.3 on i586 2.4.16-pre1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16-pre1/ (default)
     -m /boot/System.map-2.4.16-1 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?

invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129cf8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: 00000002   ecx: c38cfea0   edx: c0291e94
esi: c38cfea0   edi: c3c07c60   ebp: 00000001   esp: d1343d4c
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 18513, stackpage=d1343000)
Stack: 00000002 c012a5f1 c38cfea0 00000002 c5433670 c1663c00 c012a601 c38cfea0
c014dca4 c38cfea0 c38cfea0 c3c07c60 00000000 00000000 00000000 c0146ab9
c3c07c60 c38cfea0 00000000 c38cfea0 00001000 c3c07c60 c1c30000 c38cfea0
Call Trace: [<c012a5f1>] [<c012a601>] [<c014dca4>] [<c0146ab9>] [<c0146922>]
[<c0146ccd>] [<c0146aa4>] [<c0120835>] [<c0144a07>] [<c0173639>] [<c01782f2>]
[<c0170032>] [<c0215605>] [<c016fe2b>] [<c010546c>]
Code: 0f 0b 83 3a 00 75 05 89 0a 89 49 24 8b 02 89 41 20 8b 02 8b

>>EIP; c0129cf8 <__insert_into_lru_list+1c/5c>   <=====
Trace; c012a5f0 <__refile_buffer+48/50>
Trace; c012a600 <refile_buffer+8/10>
Trace; c014dca4 <journal_dirty_data+168/19c>
Trace; c0146ab8 <journal_dirty_sync_data+14/58>
Trace; c0146922 <walk_page_buffers+56/7c>
Trace; c0146ccc <ext3_commit_write+104/1b4>
Trace; c0146aa4 <journal_dirty_sync_data+0/58>
Trace; c0120834 <generic_file_write+498/640>
Trace; c0144a06 <ext3_file_write+42/4c>
Trace; c0173638 <nfsd_write+120/29c>
Trace; c01782f2 <nfsd3_proc_write+ea/108>
Trace; c0170032 <nfsd_dispatch+d2/1a0>
Trace; c0215604 <svc_process+28c/4d8>
Trace; c016fe2a <nfsd+1b2/2e8>
Trace; c010546c <kernel_thread+28/38>
Code;  c0129cf8 <__insert_into_lru_list+1c/5c>
00000000 <_EIP>:
Code;  c0129cf8 <__insert_into_lru_list+1c/5c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0129cfa <__insert_into_lru_list+1e/5c>
   2:   83 3a 00                  cmpl   $0x0,(%edx)
Code;  c0129cfc <__insert_into_lru_list+20/5c>
   5:   75 05                     jne    c <_EIP+0xc> c0129d04 <__insert_into_lru_list+28/5c>
Code;  c0129cfe <__insert_into_lru_list+22/5c>
   7:   89 0a                     mov    %ecx,(%edx)
Code;  c0129d00 <__insert_into_lru_list+24/5c>
   9:   89 49 24                  mov    %ecx,0x24(%ecx)
Code;  c0129d04 <__insert_into_lru_list+28/5c>
   c:   8b 02                     mov    (%edx),%eax
Code;  c0129d06 <__insert_into_lru_list+2a/5c>
   e:   89 41 20                  mov    %eax,0x20(%ecx)
Code;  c0129d08 <__insert_into_lru_list+2c/5c>
  11:   8b 02                     mov    (%edx),%eax
Code;  c0129d0a <__insert_into_lru_list+2e/5c>
  13:   8b 00                     mov    (%eax),%eax

1 warning issued.  Results may not be reliable.

cheers,
Patrick
