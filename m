Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129704AbRAPUci>; Tue, 16 Jan 2001 15:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131188AbRAPUc2>; Tue, 16 Jan 2001 15:32:28 -0500
Received: from proxy.ovh.net ([213.244.20.42]:18952 "HELO proxy.ovh.net")
	by vger.kernel.org with SMTP id <S129704AbRAPUcR>;
	Tue, 16 Jan 2001 15:32:17 -0500
Message-ID: <3A64AF23.6C11CEB4@ovh.net>
Date: Tue, 16 Jan 2001 21:29:23 +0100
From: octave klaba <oles@ovh.net>
X-Mailer: Mozilla 4.73 [en] (Win98; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: oops 2.2.18
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
on 2.2.17 & 2.2.18 we have this kernel panic:
it begins with:
no vm86_info: BAD

ksymoops 2.3.7 on i686 2.2.18RAID.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18RAID/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
./ksymoops: Aucun fichier ou répertoire de ce type
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 4452460c
current->tss.cr3 = 09678000, %cr3 = 09678000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011d2be>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000019   ebx: 44524600   ecx: d7063fc0   edx: 00000000
esi: dffef920   edi: 00000286   ebp: 00000018   esp: c96ebe04
ds: 0018   es: 0018   ss: 0018
Process webalizer (pid: 24499, process nr: 188, stackpage=c96eb000)
Stack: d706361c 00000004 d706365c dbea773c c014a142 dffef920 d70635c0 d70635c0
       c014a1f1 d70635c0 0000003c d70635c0 c0158417 d70635c0 c81c2ff0 00002180
       00000002 c81c2f40 d70635ec d70635c0 c81c2f94 00241717 c0158722 c81c2f40
Call Trace: [<c014a142>] [<c014a1f1>] [<c0158417>] [<c0158722>] [<c01a6787>] [<c0159be9>] [<c015e950>]
       [<c015ed06>] [<c0151bb2>] [<c0151e99>] [<c014ba25>] [<c0114f39>] [<c0108b8b>] [<c0108858>]
Code: 39 43 0c 75 1d 8b 41 14 89 58 10 89 43 14 8b 06 8b 50 14 89

>>EIP; c011d2be <kmem_cache_free+ae/174>   <=====
Trace; c014a142 <kfree_skbmem+32/40>
Trace; c014a1f1 <__kfree_skb+a1/a8>
Trace; c0158417 <tcp_clean_rtx_queue+103/12c>
Trace; c0158722 <tcp_ack+142/3a4>
Trace; c01a6787 <__delay+13/24>
Trace; c0159be9 <tcp_rcv_established+439/5d8>
Trace; c015e950 <tcp_v4_do_rcv+38/140>
Trace; c015ed06 <tcp_v4_rcv+2ae/334>
Trace; c0151bb2 <ip_local_deliver+16a/1b8>
Trace; c0151e99 <ip_rcv+299/2c8>
Trace; c014ba25 <net_bh+181/1dc>
Trace; c0114f39 <do_bottom_half+45/64>
Trace; c0108b8b <do_IRQ+3b/40>
Trace; c0108858 <common_interrupt+18/20>
Code;  c011d2be <kmem_cache_free+ae/174>
00000000 <_EIP>:
Code;  c011d2be <kmem_cache_free+ae/174>   <=====
   0:   39 43 0c                  cmpl   %eax,0xc(%ebx)   <=====
Code;  c011d2c1 <kmem_cache_free+b1/174>
   3:   75 1d                     jne    22 <_EIP+0x22> c011d2e0 <kmem_cache_free+d0/174>
Code;  c011d2c3 <kmem_cache_free+b3/174>
   5:   8b 41 14                  movl   0x14(%ecx),%eax
Code;  c011d2c6 <kmem_cache_free+b6/174>
   8:   89 58 10                  movl   %ebx,0x10(%eax)
Code;  c011d2c9 <kmem_cache_free+b9/174>
   b:   89 43 14                  movl   %eax,0x14(%ebx)
Code;  c011d2cc <kmem_cache_free+bc/174>
   e:   8b 06                     movl   (%esi),%eax
Code;  c011d2ce <kmem_cache_free+be/174>
  10:   8b 50 14                  movl   0x14(%eax),%edx
Code;  c011d2d1 <kmem_cache_free+c1/174>
  13:   89 00                     movl   %eax,(%eax)

Aiee, killing interrupt handler

1 warning and 1 error issued.  Results may not be reliable.
-- 
Amicalement,
oCtAvE
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
