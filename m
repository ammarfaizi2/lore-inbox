Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSEUToG>; Tue, 21 May 2002 15:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316577AbSEUToF>; Tue, 21 May 2002 15:44:05 -0400
Received: from web14206.mail.yahoo.com ([216.136.173.70]:11532 "HELO
	web14206.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316576AbSEUTnu>; Tue, 21 May 2002 15:43:50 -0400
Message-ID: <20020521194349.67491.qmail@web14206.mail.yahoo.com>
Date: Tue, 21 May 2002 12:43:49 -0700 (PDT)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: Kernel BUG 2.4.19-pre8-ac1 + preempt
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This output...

kernel BUG at /usr/src/linux-2.2.13/include/linux/mm_inline.h:78!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012dd02>]    Not tainted
EFLAGS: 00210202
eax: 01000049   ebx: c10c4b2c   ecx: c024159c   edx: c10d6c04
esi: c10c4b10   edi: c01325a8   ebp: ffffe000   esp: c52bdde0
ds: 0018   es: 0018   ss: 0018
Process kfind (pid: 20927, stackpage=c52bd000)
Stack: c02414c0 c024159c 0000045c 0000003b c02415cc c52bc000 0000045c 00000000
       00000042 c012df1c c024159c 000001d2 00000006 000001d2 c0241780 000001ff
       00000000 00000002 c012e750 000001d2 c52bc000 c0241780 c012ee6a 000001d2
Call Trace: [<c012df1c>] [<c012e750>] [<c012ee6a>] [<c012f8d3>] [<c012f666>]
   [<c0126442>] [<c01264ba>] [<c0127b0b>] [<c0123b5d>] [<c0123e13>]
[<c01117ab>]
   [<c0111694>] [<c01a7b0e>] [<c01a802c>] [<c01abb58>] [<c0109adc>]
[<c010bd08>]
   [<c0109cc6>] [<c01088e4>] 

Code: 0f 0b 4e 00 20 30 21 c0 8d b6 00 00 00 00 8b 46 18 a8 80 74
 <3>kfind[20927] exited with preempt_count 1

Which I decoded and got this...

ksymoops 2.3.7 on i586 2.4.19-pre8-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre8-ac1/ (default)
     -m /boot/Sys-2.4.19-pre8-ac1 (specified)

Warning (compare_maps): ksyms_base symbol
vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): mismatch on symbol packet_socks_nr  , af_packet says
c8986244, /lib/modules/2.4.19-pre8-ac1/kernel/net/packet/af_packet.o says
c8986164.  Ignoring /lib/modules/2.4.19-pre8-ac1/kernel/net/packet/af_packet.o
entry
Warning (compare_maps): mismatch on symbol journal_enable_debug  , jbd says
c88bffe4, /lib/modules/2.4.19-pre8-ac1/kernel/fs/jbd/jbd.o says c88bffd0. 
Ignoring /lib/modules/2.4.19-pre8-ac1/kernel/fs/jbd/jbd.o entry
Warning (compare_maps): mismatch on symbol unix_socket_table  , unix says
c88b37a0, /lib/modules/2.4.19-pre8-ac1/kernel/net/unix/unix.o says c88b3540. 
Ignoring /lib/modules/2.4.19-pre8-ac1/kernel/net/unix/unix.o entry
kernel BUG at /usr/src/linux-2.2.13/include/linux/mm_inline.h:78!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012dd02>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210202
eax: 01000049   ebx: c10c4b2c   ecx: c024159c   edx: c10d6c04
esi: c10c4b10   edi: c01325a8   ebp: ffffe000   esp: c52bdde0
ds: 0018   es: 0018   ss: 0018
Process kfind (pid: 20927, stackpage=c52bd000)
Stack: c02414c0 c024159c 0000045c 0000003b c02415cc c52bc000 0000045c 00000000
       00000042 c012df1c c024159c 000001d2 00000006 000001d2 c0241780 000001ff 
       00000000 00000002 c012e750 000001d2 c52bc000 c0241780 c012ee6a 000001d2 
Call Trace: [<c012df1c>] [<c012e750>] [<c012ee6a>] [<c012f8d3>] [<c012f666>]
   [<c0126442>] [<c01264ba>] [<c0127b0b>] [<c0123b5d>] [<c0123e13>]
[<c01117ab>] 
   [<c0111694>] [<c01a7b0e>] [<c01a802c>] [<c01abb58>] [<c0109adc>]
[<c010bd08>] 
   [<c0109cc6>] [<c01088e4>]
Code: 0f 0b 4e 00 20 30 21 c0 8d b6 00 00 00 00 8b 46 18 a8 80 74

>>EIP; c012dd02 <page_launder_zone+59a/664>   <=====
Trace; c012df1c <page_launder+150/2c8>
Trace; c012e750 <do_try_to_free_pages+c/16c>
Trace; c012ee6a <try_to_free_pages+2a/38>
Trace; c012f8d3 <__alloc_pages+1a3/2b0>
Trace; c012f666 <_alloc_pages+16/18>
Trace; c0126442 <page_cache_read+8e/e0>
Trace; c01264ba <read_cluster_nonblocking+26/40>
Trace; c0127b0b <filemap_nopage+15b/250>
Trace; c0123b5d <do_no_page+71/250>
Trace; c0123e13 <handle_mm_fault+d7/178>
Trace; c01117ab <do_page_fault+117/430>
Trace; c0111694 <do_page_fault+0/430>
Trace; c01a7b0e <ide_do_request+29a/2e4>
Trace; c01a802c <ide_intr+16c/1ac>
Trace; c01abb58 <ide_dma_intr+0/a4>
Trace; c0109adc <handle_IRQ_event+34/60>
Trace; c010bd08 <end_8259A_irq+18/1c>
Trace; c0109cc6 <do_IRQ+ae/e4>
Trace; c01088e4 <error_code+34/40>
Code;  c012dd02 <page_launder_zone+59a/664>
00000000 <_EIP>:
Code;  c012dd02 <page_launder_zone+59a/664>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012dd04 <page_launder_zone+59c/664>
   2:   4e                        dec    %esi
Code;  c012dd05 <page_launder_zone+59d/664>
   3:   00 20                     add    %ah,(%eax)
Code;  c012dd07 <page_launder_zone+59f/664>
   5:   30 21                     xor    %ah,(%ecx)
Code;  c012dd09 <page_launder_zone+5a1/664>
   7:   c0 8d b6 00 00 00 00      rorb   $0x0,0xb6(%ebp)
Code;  c012dd10 <page_launder_zone+5a8/664>
   e:   8b 46 18                  mov    0x18(%esi),%eax
Code;  c012dd13 <page_launder_zone+5ab/664>
  11:   a8 80                     test   $0x80,%al
Code;  c012dd15 <page_launder_zone+5ad/664>
  13:   74 00                     je     15 <_EIP+0x15> c012dd17
<page_launder_zone+5af/664>


4 warnings issued.  Results may not be reliable.



Was running KDE 3.0 attempting a kfind while updatedb was running in the
background.  System became unresponsive to mouse.  Attempting to switch to a vc
via alt-ctrl-f2 caused a redraw of the screen with kfind missing but no vc
switch.  At this point, life seemed back to normal.  Looking back at the logs
showed the following

Out of Memory: Killed process 21305 (httpd).

repeated many times...

Further back in the log was the following....

May 21 09:25:27 Camhanaich imapd[21311]: Command stream end of file, while
reading line user=??? host=turtle [192.168.0.2]
May 21 09:25:18 Camhanaich sendmail[1272]: rejecting connections on daemon
Daemon0: load average: 53
May 21 09:25:34 Camhanaich telnetd[21317]: ttloop: peer died: EOF 

On this sam box I also getthe following errors,in the past...

May 10 23:59:05 Camhanaich kernel: eth2: Error -110 writing Tx descriptor to
BAP
May 10 23:27:52 Camhanaich kernel: eth2: Error -110 setting multicast list.
May 10 23:27:53 Camhanaich kernel: eth2: Error -110 setting multicast list.
May 10 23:27:53 Camhanaich kernel: eth2: Error -110 setting PROMISCUOUSMODE to
1.
May 10 23:27:54 Camhanaich kernel: eth2: Error -110 writing Tx descriptor to
BAP

where eth2 is a linksys pc card in a pci adaptor using the orinoco_plx driver
(have tried the linux-wlan driver in the past with success, but it doesn't
compile currently with this kernel).  When the first mentioned problem
occurred, this card was disabled.

TIA
Erik

__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
