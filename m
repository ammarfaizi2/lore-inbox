Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269099AbRIDVAd>; Tue, 4 Sep 2001 17:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269206AbRIDVAZ>; Tue, 4 Sep 2001 17:00:25 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:46858 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S269099AbRIDVAE>; Tue, 4 Sep 2001 17:00:04 -0400
Date: Tue, 4 Sep 2001 23:00:14 +0200
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at inode.c:682!
Message-ID: <20010904230014.A217@ping.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
X-Mailer: Mutt 1.0pre2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii

I haven't seen anybody report this problem yet ...

I'm using 2.4.9 + the ext3 patch.

I was doing a grep thru a directory at the time, but doing the
same again doesn't do anything now.

After that alot of processes got stuck in state D, including
things like init, su, login, I couldn't even begin to do a
shutdown, so I just pressed the reset button.

I attached the output of ksymoops.


Kurt


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.out"

ksymoops 2.4.1 on i586 2.4.9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at inode.c:682!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013eb2c>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001b   ebx: c39c22c8   ecx: c113e000   edx: 00000000
esi: c39c22c0   edi: c39c24a8   ebp: c113ffa8   esp: c113ff80
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c113f000)
Stack: c0278686 c0278702 000002aa 00000006 000000c0 0000003f 00000000 00000008 
       c0c0c7c8 c39e5608 00000001 c013ebc4 00000002 c012665b 00000006 000000c0 
       00000006 000000c0 c113e000 c0275351 c113e239 0008e000 c0126721 000000c0 
Call Trace: [<c013ebc4>] [<c012665b>] [<c0126721>] [<c0105448>] 
Code: 0f 0b 83 c4 0c 8b 53 04 8b 03 89 50 04 89 02 8b 53 fc 8b 43 

>>EIP; c013eb2c <prune_icache+94/114>   <=====
Trace; c013ebc4 <shrink_icache_memory+18/2c>
Trace; c012665b <do_try_to_free_pages+57/b4>
Trace; c0126721 <kswapd+69/ac>
Trace; c0105448 <kernel_thread+28/38>
Code;  c013eb2c <prune_icache+94/114>
00000000 <_EIP>:
Code;  c013eb2c <prune_icache+94/114>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013eb2e <prune_icache+96/114>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c013eb31 <prune_icache+99/114>
   5:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c013eb34 <prune_icache+9c/114>
   8:   8b 03                     mov    (%ebx),%eax
Code;  c013eb36 <prune_icache+9e/114>
   a:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013eb39 <prune_icache+a1/114>
   d:   89 02                     mov    %eax,(%edx)
Code;  c013eb3b <prune_icache+a3/114>
   f:   8b 53 fc                  mov    0xfffffffc(%ebx),%edx
Code;  c013eb3e <prune_icache+a6/114>
  12:   8b 43 00                  mov    0x0(%ebx),%eax

kernel BUG at inode.c:682!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013eb2c>]
EFLAGS: 00010282
eax: 0000001b   ebx: c39c22c8   ecx: c2a5e000   edx: c21875a0
esi: c39c22c0   edi: c39c24a8   ebp: c2a5fe9c   esp: c2a5fe74
ds: 0018   es: 0018   ss: 0018
Process grep (pid: 3843, stackpage=c2a5f000)
Stack: c0278686 c0278702 000002aa 00000006 000000d2 0000003f 00000000 00000000 
       c2a5fe94 c2a5fe94 00000001 c013ebc4 0000000a c012665b 00000006 000000d2 
       00000006 000000d2 c2a5e000 c02c60e8 00000000 00000010 c01267aa 000000d2 
Call Trace: [<c013ebc4>] [<c012665b>] [<c01267aa>] [<c0127390>] [<c01271c2>] 
   [<c011fa18>] [<c011fe3a>] [<c0120089>] [<c011ffc0>] [<c012c4b5>] [<c0106b03>] 
Code: 0f 0b 83 c4 0c 8b 53 04 8b 03 89 50 04 89 02 8b 53 fc 8b 43 

>>EIP; c013eb2c <prune_icache+94/114>   <=====
Trace; c013ebc4 <shrink_icache_memory+18/2c>
Trace; c012665b <do_try_to_free_pages+57/b4>
Trace; c01267aa <try_to_free_pages+22/2c>
Trace; c0127390 <__alloc_pages+1cc/278>
Trace; c01271c2 <_alloc_pages+16/18>
Trace; c011fa18 <generic_file_readahead+1c0/254>
Trace; c011fe3a <do_generic_file_read+38e/514>
Trace; c0120089 <generic_file_read+61/7c>
Trace; c011ffc0 <file_read_actor+0/68>
Trace; c012c4b5 <sys_read+95/cc>
Trace; c0106b03 <system_call+33/40>
Code;  c013eb2c <prune_icache+94/114>
00000000 <_EIP>:
Code;  c013eb2c <prune_icache+94/114>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013eb2e <prune_icache+96/114>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c013eb31 <prune_icache+99/114>
   5:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c013eb34 <prune_icache+9c/114>
   8:   8b 03                     mov    (%ebx),%eax
Code;  c013eb36 <prune_icache+9e/114>
   a:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013eb39 <prune_icache+a1/114>
   d:   89 02                     mov    %eax,(%edx)
Code;  c013eb3b <prune_icache+a3/114>
   f:   8b 53 fc                  mov    0xfffffffc(%ebx),%edx
Code;  c013eb3e <prune_icache+a6/114>
  12:   8b 43 00                  mov    0x0(%ebx),%eax

kernel BUG at inode.c:682!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013eb2c>]
EFLAGS: 00010286
eax: 0000001b   ebx: c39c22c8   ecx: c2a5e000   edx: c21875a0
esi: c39c22c0   edi: c39c24a8   ebp: c2a5fd8c   esp: c2a5fd64
ds: 0018   es: 0018   ss: 0018
Process grep (pid: 3844, stackpage=c2a5f000)
Stack: c0278686 c0278702 000002aa 00000006 000000d2 0000003f 00000000 00000000 
       c2a5fd84 c2a5fd84 00000001 c013ebc4 0000000a c012665b 00000006 000000d2 
       00000006 000000d2 c2a5e000 c02c60e8 00000000 00000010 c01267aa 000000d2 
Call Trace: [<c013ebc4>] [<c012665b>] [<c01267aa>] [<c0127390>] [<c01271c2>] 
   [<c011d07f>] [<c011d77e>] [<c010ff34>] [<c0110094>] [<c010ff34>] [<c0152b83>] 
   [<c012495a>] [<c0106c14>] [<c011fff3>] [<c011fcb6>] [<c0120089>] [<c011ffc0>] 
   [<c012c4b5>] [<c0106b03>] 
Code: 0f 0b 83 c4 0c 8b 53 04 8b 03 89 50 04 89 02 8b 53 fc 8b 43 

>>EIP; c013eb2c <prune_icache+94/114>   <=====
Trace; c013ebc4 <shrink_icache_memory+18/2c>
Trace; c012665b <do_try_to_free_pages+57/b4>
Trace; c01267aa <try_to_free_pages+22/2c>
Trace; c0127390 <__alloc_pages+1cc/278>
Trace; c01271c2 <_alloc_pages+16/18>
Trace; c011d07f <do_wp_page+153/238>
Trace; c011d77e <handle_mm_fault+8a/bc>
Trace; c010ff34 <do_page_fault+0/45c>
Trace; c0110094 <do_page_fault+160/45c>
Trace; c010ff34 <do_page_fault+0/45c>
Trace; c0152b83 <journal_dirty_metadata+1d7/1f4>
Trace; c012495a <kfree+202/290>
Trace; c0106c14 <error_code+34/40>
Trace; c011fff3 <file_read_actor+33/68>
Trace; c011fcb6 <do_generic_file_read+20a/514>
Trace; c0120089 <generic_file_read+61/7c>
Trace; c011ffc0 <file_read_actor+0/68>
Trace; c012c4b5 <sys_read+95/cc>
Trace; c0106b03 <system_call+33/40>
Code;  c013eb2c <prune_icache+94/114>
00000000 <_EIP>:
Code;  c013eb2c <prune_icache+94/114>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013eb2e <prune_icache+96/114>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c013eb31 <prune_icache+99/114>
   5:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c013eb34 <prune_icache+9c/114>
   8:   8b 03                     mov    (%ebx),%eax
Code;  c013eb36 <prune_icache+9e/114>
   a:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013eb39 <prune_icache+a1/114>
   d:   89 02                     mov    %eax,(%edx)
Code;  c013eb3b <prune_icache+a3/114>
   f:   8b 53 fc                  mov    0xfffffffc(%ebx),%edx
Code;  c013eb3e <prune_icache+a6/114>
  12:   8b 43 00                  mov    0x0(%ebx),%eax

kernel BUG at inode.c:682!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013eb2c>]
EFLAGS: 00010282
eax: 0000001b   ebx: c39c22c8   ecx: c2a5e000   edx: c21875a0
esi: c39c22c0   edi: c39c24a8   ebp: c2a5fdfc   esp: c2a5fdd4
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 3845, stackpage=c2a5f000)
Stack: c0278686 c0278702 000002aa 00000006 000000f0 0000003e 00000000 00000007 
       c39c7628 c3d2cde8 00000001 c013ebc4 00000003 c012665b 00000006 000000f0 
       00000006 000000f0 c2a5e000 c02c60c8 00000000 00000010 c01267aa 000000f0 
Call Trace: [<c013ebc4>] [<c012665b>] [<c01267aa>] [<c0127390>] [<c01271c2>] 
   [<c0127446>] [<c0123e8a>] [<c014d827>] [<c01242d9>] [<c013ed74>] [<c013f056>] 
   [<c014d98a>] [<c0135c87>] [<c013632f>] [<c0135a2e>] [<c0136906>] [<c01337f9>] 
   [<c0106b03>] 
Code: 0f 0b 83 c4 0c 8b 53 04 8b 03 89 50 04 89 02 8b 53 fc 8b 43 

>>EIP; c013eb2c <prune_icache+94/114>   <=====
Trace; c013ebc4 <shrink_icache_memory+18/2c>
Trace; c012665b <do_try_to_free_pages+57/b4>
Trace; c01267aa <try_to_free_pages+22/2c>
Trace; c0127390 <__alloc_pages+1cc/278>
Trace; c01271c2 <_alloc_pages+16/18>
Trace; c0127446 <__get_free_pages+a/18>
Trace; c0123e8a <kmem_cache_grow+ba/2fc>
Trace; c014d827 <ext3_find_entry+217/328>
Trace; c01242d9 <kmem_cache_alloc+171/188>
Trace; c013ed74 <get_new_inode+1c/164>
Trace; c013f056 <iget4+c2/d4>
Trace; c014d98a <ext3_lookup+52/78>
Trace; c0135c87 <real_lookup+53/c4>
Trace; c013632f <path_walk+527/748>
Trace; c0135a2e <getname+5e/9c>
Trace; c0136906 <__user_walk+3a/54>
Trace; c01337f9 <sys_newstat+15/6c>
Trace; c0106b03 <system_call+33/40>
Code;  c013eb2c <prune_icache+94/114>
00000000 <_EIP>:
Code;  c013eb2c <prune_icache+94/114>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013eb2e <prune_icache+96/114>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c013eb31 <prune_icache+99/114>
   5:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c013eb34 <prune_icache+9c/114>
   8:   8b 03                     mov    (%ebx),%eax
Code;  c013eb36 <prune_icache+9e/114>
   a:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013eb39 <prune_icache+a1/114>
   d:   89 02                     mov    %eax,(%edx)
Code;  c013eb3b <prune_icache+a3/114>
   f:   8b 53 fc                  mov    0xfffffffc(%ebx),%edx
Code;  c013eb3e <prune_icache+a6/114>
  12:   8b 43 00                  mov    0x0(%ebx),%eax

kernel BUG at inode.c:682!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013eb2c>]
EFLAGS: 00010286
eax: 0000001b   ebx: c39c22c8   ecx: c343e000   edx: c2187460
esi: c39c22c0   edi: c39c24a8   ebp: c343fe54   esp: c343fe2c
ds: 0018   es: 0018   ss: 0018
Process enlightenment (pid: 3635, stackpage=c343f000)
Stack: c0278686 c0278702 000002aa 00000006 000000f0 0000003f 00000000 00000003 
       c39c7448 c39c7808 00000001 c013ebc4 00000007 c012665b 00000006 000000f0 
       00000006 000000f0 c343e000 c02c60c8 00000000 00000010 c01267aa 000000f0 
Call Trace: [<c013ebc4>] [<c012665b>] [<c01267aa>] [<c0127390>] [<c01271c2>] 
   [<c0127446>] [<c0139bb7>] [<c024d1e2>] [<c021b2ad>] [<c0139d99>] [<c013a202>] 
   [<c010ade6>] [<c0106b03>] 
Code: 0f 0b 83 c4 0c 8b 53 04 8b 03 89 50 04 89 02 8b 53 fc 8b 43 

>>EIP; c013eb2c <prune_icache+94/114>   <=====
Trace; c013ebc4 <shrink_icache_memory+18/2c>
Trace; c012665b <do_try_to_free_pages+57/b4>
Trace; c01267aa <try_to_free_pages+22/2c>
Trace; c0127390 <__alloc_pages+1cc/278>
Trace; c01271c2 <_alloc_pages+16/18>
Trace; c0127446 <__get_free_pages+a/18>
Trace; c0139bb7 <__pollwait+33/90>
Trace; c024d1e2 <unix_poll+22/84>
Trace; c021b2ad <sock_poll+21/28>
Trace; c0139d99 <do_select+e5/1dc>
Trace; c013a202 <sys_select+34a/484>
Trace; c010ade6 <old_select+5e/74>
Trace; c0106b03 <system_call+33/40>
Code;  c013eb2c <prune_icache+94/114>
00000000 <_EIP>:
Code;  c013eb2c <prune_icache+94/114>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013eb2e <prune_icache+96/114>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c013eb31 <prune_icache+99/114>
   5:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c013eb34 <prune_icache+9c/114>
   8:   8b 03                     mov    (%ebx),%eax
Code;  c013eb36 <prune_icache+9e/114>
   a:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013eb39 <prune_icache+a1/114>
   d:   89 02                     mov    %eax,(%edx)
Code;  c013eb3b <prune_icache+a3/114>
   f:   8b 53 fc                  mov    0xfffffffc(%ebx),%edx
Code;  c013eb3e <prune_icache+a6/114>
  12:   8b 43 00                  mov    0x0(%ebx),%eax

kernel BUG at inode.c:682!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013eb2c>]
EFLAGS: 00010286
eax: 0000001b   ebx: c39c22c8   ecx: c0b70000   edx: c2187640
esi: c39c22c0   edi: c39c24a8   ebp: c0b71e28   esp: c0b71e00
ds: 0018   es: 0018   ss: 0018
Process X (pid: 3633, stackpage=c0b71000)
Stack: c0278686 c0278702 000002aa 00000006 000000d2 0000003e 00000000 00000006 
       c1ae6dc8 c1ae6468 00000001 c013ebc4 00000005 c012665b 00000006 000000d2 
       00000006 000000d2 c0b70000 c02c60e8 00000000 00000010 c01267aa 000000d2 
Call Trace: [<c013ebc4>] [<c012665b>] [<c01267aa>] [<c0127390>] [<c01271c2>] 
   [<c0127a75>] [<c011d388>] [<c011d3e5>] [<c011d760>] [<c010ff34>] [<c0110094>] 
   [<c010ff34>] [<c01de0f5>] [<c01e33e7>] [<c01df94b>] [<c01e3380>] [<c0107cec>] 
   [<c0109d68>] [<c0107e6d>] [<c0106c14>] 
Code: 0f 0b 83 c4 0c 8b 53 04 8b 03 89 50 04 89 02 8b 53 fc 8b 43 

>>EIP; c013eb2c <prune_icache+94/114>   <=====
Trace; c013ebc4 <shrink_icache_memory+18/2c>
Trace; c012665b <do_try_to_free_pages+57/b4>
Trace; c01267aa <try_to_free_pages+22/2c>
Trace; c0127390 <__alloc_pages+1cc/278>
Trace; c01271c2 <_alloc_pages+16/18>
Trace; c0127a75 <read_swap_cache_async+35/a0>
Trace; c011d388 <swapin_readahead+90/c8>
Trace; c011d3e5 <do_swap_page+25/190>
Trace; c011d760 <handle_mm_fault+6c/bc>
Trace; c010ff34 <do_page_fault+0/45c>
Trace; c0110094 <do_page_fault+160/45c>
Trace; c010ff34 <do_page_fault+0/45c>
Trace; c01de0f5 <ide_end_request+85/90>
Trace; c01e33e7 <ide_dma_intr+67/a8>
Trace; c01df94b <ide_intr+12b/14c>
Trace; c01e3380 <ide_dma_intr+0/a8>
Trace; c0107cec <handle_IRQ_event+30/5c>
Trace; c0109d68 <end_8259A_irq+18/1c>
Trace; c0107e6d <do_IRQ+8d/b0>
Trace; c0106c14 <error_code+34/40>
Code;  c013eb2c <prune_icache+94/114>
00000000 <_EIP>:
Code;  c013eb2c <prune_icache+94/114>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013eb2e <prune_icache+96/114>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c013eb31 <prune_icache+99/114>
   5:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c013eb34 <prune_icache+9c/114>
   8:   8b 03                     mov    (%ebx),%eax
Code;  c013eb36 <prune_icache+9e/114>
   a:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c013eb39 <prune_icache+a1/114>
   d:   89 02                     mov    %eax,(%edx)
Code;  c013eb3b <prune_icache+a3/114>
   f:   8b 53 fc                  mov    0xfffffffc(%ebx),%edx
Code;  c013eb3e <prune_icache+a6/114>
  12:   8b 43 00                  mov    0x0(%ebx),%eax


1 warning and 1 error issued.  Results may not be reliable.

--4Ckj6UjgE2iN1+kY--
