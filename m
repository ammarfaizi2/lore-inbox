Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135268AbRDLTZm>; Thu, 12 Apr 2001 15:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135269AbRDLTZd>; Thu, 12 Apr 2001 15:25:33 -0400
Received: from isis.telemach.net ([213.143.65.10]:53778 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S135268AbRDLTZ1>;
	Thu, 12 Apr 2001 15:25:27 -0400
Message-ID: <3AD5F37E.91DBD1A5@telemach.net>
Date: Thu, 12 Apr 2001 20:27:10 +0200
From: Jure Pecar <pegasus@telemach.net>
Organization: Select Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.3 oops
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I have an old 486 box with 28Mb ram and four 3c509 NICs for a home
firewall. Today I found it locked up and after reboot discovered some
oopsen in logs:

Apr 12 04:02:02 skiro anacron[18266]: Updated timestamp for job
`cron.daily' to 2001-04-12
Apr 12 04:05:07 skiro kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000000a
Apr 12 04:05:07 skiro kernel:  printing eip:
Apr 12 04:05:07 skiro kernel: c01341c5
Apr 12 04:05:07 skiro kernel: *pde = 00000000
Apr 12 04:05:07 skiro kernel: Oops: 0000
Apr 12 04:05:07 skiro kernel: CPU:    0
Apr 12 04:05:07 skiro kernel: EIP:    0010:[bdput+5/80]
Apr 12 04:05:07 skiro kernel: EFLAGS: 00010202
Apr 12 04:05:07 skiro kernel: eax: 00000002   ebx: 00000002   ecx:
c13d4a08   edx: c10d9f84
Apr 12 04:05:07 skiro kernel: esi: c10d9f84   edi: c0c31688   ebp:
c10d9f98   esp: c10d9f48
Apr 12 04:05:07 skiro kernel: ds: 0018   es: 0018   ss: 0018
Apr 12 04:05:07 skiro kernel: Process kswapd (pid: 3,
stackpage=c10d9000)
Apr 12 04:05:07 skiro kernel: Stack: c13d4a00 c01409b4 00000002 c0140250
c107bf98 c13d4bd0 c13d4bd0 c13d4a00 
Apr 12 04:05:07 skiro kernel:        c0140a10 c13d4a00 c0c314b8 c0c314b0
c0140c44 c10d9f84 0000065f c13d4838 
Apr 12 04:05:07 skiro kernel:        c0290128 00010f00 00000004 00000000
00000004 c0140c74 00000000 c0127166 
Apr 12 04:05:07 skiro kernel: Call Trace: [clear_inode+196/224]
[destroy_inode+48/64] [dispose_list+64/96] [prune_icache+244/256] [sh
rink_icache_memory+36/80] [do_try_to_free_pages+102/128]
[kswapd+107/256] 
Apr 12 04:05:07 skiro kernel:        [init+0/336] [init+0/336]
[kernel_thread+38/48] [kswapd+0/256] 
Apr 12 04:05:07 skiro kernel: 
Apr 12 04:05:07 skiro kernel: Code: ff 4b 08 0f 94 c0 84 c0 74 39 8b 43
10 85 c0 74 19 68 ce 01 
Apr 12 04:05:08 skiro kernel: kernel BUG at exit.c:458!
Apr 12 04:05:08 skiro kernel: invalid operand: 0000
Apr 12 04:05:08 skiro kernel: CPU:    0
Apr 12 04:05:08 skiro kernel: EIP:    0010:[do_exit+538/560]
Apr 12 04:05:08 skiro kernel: EFLAGS: 00010282
Apr 12 04:05:08 skiro kernel: eax: 0000001a   ebx: 00000000   ecx:
fffffffe   edx: 00000000
Apr 12 04:05:08 skiro kernel: esi: c10d8000   edi: 0000000b   ebp:
c01341c5   esp: c10d9e34
Apr 12 04:05:08 skiro kernel: ds: 0018   es: 0018   ss: 0018
Apr 12 04:05:08 skiro kernel: Process kswapd (pid: 3,
stackpage=c10d9000)
Apr 12 04:05:08 skiro kernel: Stack: c01c1f2c c01c1fe3 000001ca c01341c5
c0107589 c01bdbe8 c01bdd2d 00000000 
Apr 12 04:05:09 skiro kernel:        00000000 0000000a c010d757 0000000b
c10d9f14 00000000 c12261f0 c10d8000 
Apr 12 04:05:09 skiro kernel:        c10d8000 c0182043 00000287 00030001
c01821d3 c10d8000 00000001 00000000 
Apr 12 04:05:09 skiro kernel: Call Trace: [bdput+5/80] [die+57/80]
[do_page_fault+887/1136] [kfree_skbmem+35/128] [__kfree_skb+307/32
0] [update_process_times+30/144] [update_wall_time+22/96] 
Apr 12 04:05:09 skiro kernel:        [timer_bh+36/656] [bh_action+28/96]
[tasklet_hi_action+54/96] [do_softirq+91/128] [do_page_fault
+0/1136] [error_code+52/64] [bdput+5/80] [clear_inode+196/224] 
Apr 12 04:05:09 skiro kernel:        [destroy_inode+48/64]
[dispose_list+64/96] [prune_icache+244/256] [shrink_icache_memory+36/80]
[
do_try_to_free_pages+102/128] [kswapd+107/256] [init+0/336] [init+0/336] 
Apr 12 04:05:09 skiro kernel:        [kernel_thread+38/48]
[kswapd+0/256] 
Apr 12 04:05:09 skiro kernel: 
Apr 12 04:05:09 skiro kernel: Code: 0f 0b 83 c4 0c e9 4d fe ff ff 8d b6
00 00 00 00 8d bf 00 00 
Apr 12 04:05:09 skiro kernel: kernel BUG at exit.c:458



Here are they decoded through ksymoops:


ksymoops 2.3.4 on i486 2.4.3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3/ (default)
     -m /boot/System.map-2.4.3 (specified)

Apr 12 04:05:07 skiro kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000000a
Apr 12 04:05:07 skiro kernel: c01341c5
Apr 12 04:05:07 skiro kernel: *pde = 00000000
Apr 12 04:05:07 skiro kernel: Oops: 0000
Apr 12 04:05:07 skiro kernel: CPU:    0
Apr 12 04:05:07 skiro kernel: EIP:    0010:[bdput+5/80]
Apr 12 04:05:07 skiro kernel: EFLAGS: 00010202
Apr 12 04:05:07 skiro kernel: eax: 00000002   ebx: 00000002   ecx:
c13d4a08   edx: c10d9f84
Apr 12 04:05:07 skiro kernel: esi: c10d9f84   edi: c0c31688   ebp:
c10d9f98   esp: c10d9f48
Apr 12 04:05:07 skiro kernel: ds: 0018   es: 0018   ss: 0018
Apr 12 04:05:07 skiro kernel: Process kswapd (pid: 3,
stackpage=c10d9000)
Apr 12 04:05:07 skiro kernel: Stack: c13d4a00 c01409b4 00000002 c0140250
c107bf98 c13d4bd0 c13d4bd0 c13d4a00 
Apr 12 04:05:07 skiro kernel:        c0140a10 c13d4a00 c0c314b8 c0c314b0
c0140c44 c10d9f84 0000065f c13d4838 
Apr 12 04:05:07 skiro kernel:        c0290128 00010f00 00000004 00000000
00000004 c0140c74 00000000 c0127166 
Apr 12 04:05:07 skiro kernel: Call Trace: [clear_inode+196/224]
[destroy_inode+48/64] [dispose_list+64/96] [prune_icache+244/256]
[shrink
Apr 12 04:05:07 skiro kernel: Code: ff 4b 08 0f 94 c0 84 c0 74 39 8b 43
10 85 c0 74 19 68 ce 01 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff 4b 08                  decl   0x8(%ebx)
Code;  00000003 Before first symbol
   3:   0f 94 c0                  sete   %al
Code;  00000006 Before first symbol
   6:   84 c0                     test   %al,%al
Code;  00000008 Before first symbol
   8:   74 39                     je     43 <_EIP+0x43> 00000043 Before
first symbol
Code;  0000000a Before first symbol
   a:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  0000000d Before first symbol
   d:   85 c0                     test   %eax,%eax
Code;  0000000f Before first symbol
   f:   74 19                     je     2a <_EIP+0x2a> 0000002a Before
first symbol
Code;  00000011 Before first symbol
  11:   68 ce 01 00 00            push   $0x1ce

Apr 12 04:05:08 skiro kernel: invalid operand: 0000
Apr 12 04:05:08 skiro kernel: CPU:    0
Apr 12 04:05:08 skiro kernel: EIP:    0010:[do_exit+538/560]
Apr 12 04:05:08 skiro kernel: EFLAGS: 00010282
Apr 12 04:05:08 skiro kernel: eax: 0000001a   ebx: 00000000   ecx:
fffffffe   edx: 00000000
Apr 12 04:05:08 skiro kernel: esi: c10d8000   edi: 0000000b   ebp:
c01341c5   esp: c10d9e34
Apr 12 04:05:08 skiro kernel: ds: 0018   es: 0018   ss: 0018
Apr 12 04:05:08 skiro kernel: Process kswapd (pid: 3,
stackpage=c10d9000)
Apr 12 04:05:08 skiro kernel: Stack: c01c1f2c c01c1fe3 000001ca c01341c5
c0107589 c01bdbe8 c01bdd2d 00000000 
Apr 12 04:05:09 skiro kernel:        00000000 0000000a c010d757 0000000b
c10d9f14 00000000 c12261f0 c10d8000 
Apr 12 04:05:09 skiro kernel:        c10d8000 c0182043 00000287 00030001
c01821d3 c10d8000 00000001 00000000 
Apr 12 04:05:09 skiro kernel: Call Trace: [bdput+5/80] [die+57/80]
[do_page_fault+887/1136] [kfree_skbmem+35/128] [__kfree_skb+307/320] [
Apr 12 04:05:09 skiro kernel: Code: 0f 0b 83 c4 0c e9 4d fe ff ff 8d b6
00 00 00 00 8d bf 00 00

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   e9 4d fe ff ff            jmp    fffffe57 <_EIP+0xfffffe57>
fffffe57 <END_OF_CODE+3d7c7840/???
Code;  0000000a Before first symbol
   a:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  00000010 Before first symbol
  10:   8d bf 00 00 00 00         lea    0x0(%edi),%edi


Kernel is vanilla 2.4.3. Distribution is RedHat 7.0 and the time it
occured is just when redhat runs its bunch of stuff from cron scripts. I
can provide additional info if needed.
I don't belive it's a ram problem, because the box has been runnning
flawlesslly for more than half a year now. 

Please cc me in replies.

--

Jure Pecar
