Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266108AbTGDSjU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 14:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266107AbTGDSjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 14:39:20 -0400
Received: from lukewarm.bos.fast.no ([65.198.110.10]:50184 "EHLO
	lukewarm.boston.fast.no") by vger.kernel.org with ESMTP
	id S266108AbTGDSjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 14:39:07 -0400
Message-ID: <3F05CCDA.8080709@fastsearch.com>
Date: Sat, 05 Jul 2003 03:52:10 +0900
From: Terje Marthinussen <terje.marthinussen@fastsearch.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030612
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.21 (aa1/ac4/release) oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System setup:
Asus P4P800, 2GB memory, 2.8GHZ P4 with HT enabled.
1 disk on ICH5 PATA (OS)
2 disks on ICH5 SATA (md0)
3 disks on a Tekram DC-390U3W scsi controlled (md1)
Redhat 7.3

I am  having trouble with instability in this system on 2.4.21-ac4, 2.4.21-rc8aa1, 2.4.21 and 2.4.20-18.7smp when under heavy IO load (100% utilization of the 2 SATA and the 3 SCSI drives which are 15000 RPM doing mostly fairly small read and write operations). 
Somewhat different oops between each kernel, although I get similar ooops every time using the same kernel.

Turning off highmem (by accident) in the 2.4.21 kernel made the system run stable for 2 days on heavy load (the processing took forever due to lack of memory) while it normally crashes within 5 hours of heavy load. 

2.4.21-rc8aa1 might seem a bit seem to survive for a longer time than 2.4.21/2.4.20-18.7smp while 2.4.21-ac4 seems to be the least stable.

I have done some tasks that put fairly heavy IO (practically only reads) and CPU load system. It seems to be stable under this load (no hang so far).

Once I get a lot of data updates to disk, it gets problems however.

Have tried moving the IO load around between the disks, but seems like this makes no difference (quick check since the SATA driver is fairly new).

2.4.21-ac4 simply hung without any oops (only tried once).
2.4.21/2.4.20-18.7smp hangs but one can still ping the machine
2.4.21-rc8aa1 seems to hang hard (no pings).

Not sure if I should blame it hardware or linux. Any advice?

Ooops for 2.4.21, 2.4.21-rc8aa1 and 2.4.20-18.7smp at the bottom. 
While all of these shows kswap running, this isn't always the case. Especially 2.4.21 has gone down a few time show the most IO demanding user space process when OOPsing.

Regards, 
Terje

2.4.21
kernel BUG at vmscan.c:358!                  
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012fd1e>]    Not tainted
EFLAGS: 00010202
eax: 00000040   ebx: 00000000   ecx: c2461800   edx: c286e000
esi: c24617e4   edi: 00000006   ebp: 00012f62   esp: c286ff34
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c286f000)
Stack: 00000046 c286e000 00000166 000001d0 c02fd1e8 c286e000 00000000 00000000 
       00000000 00000020 000001d0 00000006 00000020 c0130182 00000006 00000000 
       c02fd1e8 00000006 000001d0 c02fd1e8 00000000 c01301ec 00000020 c02fd1e8 
Call Trace:    [<c0130182>] [<c01301ec>] [<c01302ff>] [<c0130376>] [<c01304b1>]
  [<c0130410>] [<c0105000>] [<c0105716>] [<c0130410>]

Code: 0f 0b 66 01 b8 87 2a c0 8b 41 fc a9 80 00 00 00 74 08 0f 0b 
(sorry, don't have the ksymoops at hand and the machine has crashed in the office again...)

2.4.21-rc8aa1 oops:
kernel BUG at vmscan.c:358!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012ffce>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202 
eax: 00000040   ebx: 00000000   ecx: e7e08e30   edx: c286e000 
esi: e7e08e14   edi: 00000017   ebp: 0000f70e   esp: c286ff34 
ds: 0018   es: 0018   ss: 0018  
Process kswapd (pid: 5, stackpage=c286f000)   
Stack: f7283c00 c286e000 00000200 000001d0 c02fdae8 c286e000 00000000 00000000
       00000000 00000020 000001d0 00000006 00000020 c0130432 00000006 00000004 
       c02fdae8 00000006 000001d0 c02fdae8 00000000 c013049c 00000020 c02fdae8
Call Trace:    [<c0130432>] [<c013049c>] [<c01305af>] [<c0130626>] [<c0130761>]
  [<c01306c0>] [<c0105000>] [<c0105716>] [<c01306c0>]
Code: 0f 0b 66 01 b8 90 2a c0 8b 41 fc a9 80 00 00 00 74 08 0f 0b 


>>>>EIP; c012ffce <END_OF_CODE+3ce226cf/????>   <=====
>>    
>>
Trace; c0130432 <END_OF_CODE+3ce22b33/????>
Trace; c013049c <END_OF_CODE+3ce22b9d/????>
Trace; c01305af <END_OF_CODE+3ce22cb0/????>
Trace; c0130626 <END_OF_CODE+3ce22d27/????>
Trace; c0130761 <END_OF_CODE+3ce22e62/????>
Trace; c01306c0 <END_OF_CODE+3ce22dc1/????>
Trace; c0105000 <END_OF_CODE+3cdf7701/????>
Trace; c0105716 <END_OF_CODE+3cdf7e17/????>
Trace; c01306c0 <END_OF_CODE+3ce22dc1/????>
Code;  c012ffce <END_OF_CODE+3ce226cf/????>
00000000 <_EIP>:
Code;  c012ffce <END_OF_CODE+3ce226cf/????>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012ffd0 <END_OF_CODE+3ce226d1/????>
   2:   66 01 b8 90 2a c0 8b      add    %di,0x8bc02a90(%eax)
Code;  c012ffd7 <END_OF_CODE+3ce226d8/????>
   9:   41                        inc    %ecx
Code;  c012ffd8 <END_OF_CODE+3ce226d9/????>
   a:   fc                        cld    
Code;  c012ffd9 <END_OF_CODE+3ce226da/????>
   b:   a9 80 00 00 00            test   $0x80,%eax
Code;  c012ffde <END_OF_CODE+3ce226df/????>
  10:   74 08                     je     1a <_EIP+0x1a> c012ffe8
<END_OF_CODE+3ce226e9/????>
Code;  c012ffe0 <END_OF_CODE+3ce226e1/????>
  12:   0f 0b                     ud2a   



2.4.20-18.7smp oops:
(Note that the machine has an ATI graphic card and does not run X)
Jul  3 12:48:08 sashimi kernel: Page has mapping still set. This is a serious
situation. However if you 
Jul  3 12:48:08 sashimi kernel: are using the NVidia binary only module please
report this bug to 
Jul  3 12:48:08 sashimi kernel: NVidia and not to the linux kernel mailinglist.
Jul  3 12:48:08 sashimi kernel: ------------[ cut here ]------------
Jul  3 12:48:08 sashimi kernel: kernel BUG at page_alloc.c:114!
Jul  3 12:48:08 sashimi kernel: invalid operand: 0000
Jul  3 12:48:08 sashimi kernel: sg 3c2000 raid0 sym53c8xx sd_mod scsi_mod ext3 jbd  
Jul  3 12:48:08 sashimi kernel: CPU:    0
Jul  3 12:48:08 sashimi kernel: EIP:    0010:[<c013d5c7>]    Not tainted
Jul  3 12:48:08 sashimi kernel: EFLAGS: 00010296
Jul  3 12:48:08 sashimi kernel: 
Jul  3 12:48:08 sashimi kernel: EIP is at __free_pages_ok [kernel] 0x77 (2.4.20-18.7smp)
Jul  3 12:48:08 sashimi kernel: eax: 00000033   ebx: c12e8e90   ecx: c2da2000  edx: 00000001
Jul  3 12:48:08 sashimi kernel: esi: 00000000   edi: c030d310   ebp: dd7ff3b4 esp: c44c5ec4
Jul  3 12:48:08 sashimi kernel: ds: 0018   es: 0018   ss: 0018
Jul  3 12:48:08 sashimi kernel: Process kswapd (pid: 4, stackpage=c44c5000)
Jul  3 12:48:08 sashimi kernel: Stack: c0254fa0 c0254f40 c0254ee0 f243cb20 c12e8e90 c014a903 c44bce00 c12e8e90 
Jul  3 12:48:08 sashimi kernel:        000001d0 c014895f c030d310 c12e8e90 c030d310 00000000 c0139d15 c12e8e90 
Jul  3 12:48:08 sashimi kernel:        000001d0 00000001 000000ec c030d310 c030e4c8 00000013 c013bdfa c030d310 
Jul  3 12:48:08 sashimi kernel: Call Trace:   [<c014a903>] try_to_free_buffers[kernel] 0xd3 (0xc44c5ed8))
Jul  3 12:48:08 sashimi kernel: [<c014895f>] try_to_release_page [kernel] 0x2f(0xc44c5ee8))
Jul  3 12:48:08 sashimi kernel: [<c0139d15>] launder_page [kernel] 0x8b5(0xc44c5efc))
Jul  3 12:48:08 sashimi kernel: [<c013bdfa>] rebalance_dirty_zone [kernel] 0x9a(0xc44c5f1c))
Jul  3 12:48:08 sashimi kernel: [<c013c07e>] rebalance_inactive_zone [kernel]0x21e (0xc44c5f3c))
Jul  3 12:48:08 sashimi kernel: [<c013c1ed>] rebalance_inactive [kernel] 0x3d(0xc44c5f6c))
Jul  3 12:48:08 sashimi kernel: [<c013c321>] do_try_to_free_pages_kswapd[kernel] 0x31 (0xc44c5f90))
Jul  3 12:48:08 sashimi kernel: [<c013c7d1>] kswapd [kernel] 0x141 (0xc44c5fd4))
Jul  3 12:48:08 sashimi kernel: [<c0105000>] stext [kernel] 0x0 (0xc44c5fe8))
Jul  3 12:48:08 sashimi kernel: [<c0107266>] arch_kernel_thread [kernel] 0x26(0xc44c5ff0))
Jul  3 12:48:08 sashimi kernel: [<c013c690>] kswapd [kernel] 0x0 (0xc44c5ff8))
Jul  3 12:48:08 sashimi kernel: 
Jul  3 12:48:08 sashimi kernel: 
Jul  3 12:48:08 sashimi kernel: Code: 0f 0b 72 00 e8 56 25 c0 83 c4 0c 8b 3d b084 3b c0 89 d8 29 


Ksymoops output

>>>>EIP; c013d5c7 <__free_pages_ok+77/420>   <=====
>>    
>>
Trace; c014a903 <try_to_free_buffers+d3/150>
Trace; c014895f <try_to_release_page+2f/50>
Trace; c0139d15 <launder_page+8b5/990>
Trace; c013bdfa <rebalance_dirty_zone+9a/100>
Trace; c013c07e <rebalance_inactive_zone+21e/350>
Trace; c013c1ed <rebalance_inactive+3d/80>
Trace; c013c321 <do_try_to_free_pages_kswapd+31/310>
Trace; c013c7d1 <kswapd+141/4e0>
Trace; c0105000 <_stext+0/0>
Trace; c0107266 <arch_kernel_thread+26/30>
Trace; c013c690 <kswapd+0/4e0>
Code;  c013d5c7 <__free_pages_ok+77/420>
00000000 <_EIP>:
Code;  c013d5c7 <__free_pages_ok+77/420>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013d5c9 <__free_pages_ok+79/420>
   2:   72 00                     jb     4 <_EIP+0x4> c013d5cb
<__free_pages_ok+7b/420>
Code;  c013d5cb <__free_pages_ok+7b/420>
   4:   e8 56 25 c0 83            call   83c0255f <_EIP+0x83c0255f> 43d3fb26
Before first symbol
Code;  c013d5d0 <__free_pages_ok+80/420>
   9:   c4 0c 8b                  les    (%ebx,%ecx,4),%ecx
Code;  c013d5d3 <__free_pages_ok+83/420>
   c:   3d b0 84 3b c0            cmp    $0xc03b84b0,%eax
Code;  c013d5d8 <__free_pages_ok+88/420>
  11:   89 d8                     mov    %ebx,%eax
Code;  c013d5da <__free_pages_ok+8a/420>
  13:   29 00                     sub    %eax,(%eax)


