Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318072AbSFTAVb>; Wed, 19 Jun 2002 20:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318073AbSFTAVa>; Wed, 19 Jun 2002 20:21:30 -0400
Received: from holomorphy.com ([66.224.33.161]:18108 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318072AbSFTAV3>;
	Wed, 19 Jun 2002 20:21:29 -0400
Date: Wed, 19 Jun 2002 17:21:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.5.23 mpage io vs queue_max_sectors
Message-ID: <20020620002105.GL25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been haunting me for a while on a 4 cpu Sequent S-quad with
4GB of RAM, and a tray of 12 9GB DCHS09X's attached to a QLogicISP1020.
People keep saying "hands off" ... so here I am passing the buck.

Kernel BUG at ll_rw_blk.c:1639          
CPU:    0 
EIP:    0010:[<c0246e59>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000286                        
eax: 0000001f   ebx: f78b0360   ecx: 00000001   edx: c038e2d0
esi: 00000060   edi: f7956018   ebp: c3bc7af0   esp: c3bc7ad8
ds: 0018   es: 0018   ss: 0018                               
Stack: c0348a28 c0348b65 00000667 f78b0360 00000060 00000000 c3bc7b08 c0246f8f 
       f78b0360 00000001 f78b0360 0000000c c3bc7b18 c015c8f5 00000000 f78b0360 
       c3bc7ba8 c015cc0e 00000000 f78b0360 c376bdc8 0000000b f78b0360 00017062 
Call Trace: [<c0246f8f>] [<c015c8f5>] [<c015cc0e>] [<c020fe53>] [<c012cb67>]   
   [<c012cb9c>] [<c015ccac>] [<c0182260>] [<c0182645>] [<c0182260>] [<c013c780>]
   [<c013c907>] [<c013ca02>] [<c012d369>] [<c012d971>] [<c012d7f8>] [<c0147d98>]
   [<c015e338>] [<c015e050>] [<c0147940>] [<c014894f>] [<c0148b8b>] [<c0107753>]
   [<c0108cab>] [<c01051a6>] [<c01072dc>] 
Code: 83 c4 0c 8d 74 26 00 8b 45 08 8b 58 08 3b 5b 44 74 50 0f b7 


>>EIP; c0246e59 <generic_make_request+101/184>   <=====

>>ebx; f78b0360 <END_OF_CODE+3740527c/????>
>>edx; c038e2d0 <log_wait+4/c>
>>edi; f7956018 <END_OF_CODE+374aaf34/????>
>>ebp; c3bc7af0 <END_OF_CODE+371ca0c/????>
>>esp; c3bc7ad8 <END_OF_CODE+371c9f4/????>

Trace; c0246f8f <submit_bio+8f/a0>
Trace; c015c8f5 <mpage_bio_submit+31/38>
Trace; c015cc0e <do_mpage_readpage+292/2d0>
Trace; c020fe53 <radix_tree_insert+17/2c>
Trace; c012cb67 <add_to_page_cache_unique+47/88>
Trace; c012cb9c <add_to_page_cache_unique+7c/88>
Trace; c015ccac <mpage_readpages+60/ac>
Trace; c0182260 <ext2_get_block+0/39c>
Trace; c0182645 <ext2_readpages+19/20>
Trace; c0182260 <ext2_get_block+0/39c>
Trace; c013c780 <read_pages+20/88>
Trace; c013c907 <do_page_cache_readahead+11f/154>
Trace; c013ca02 <page_cache_readahead+c6/f0>
Trace; c012d369 <do_generic_file_read+a1/34c>
Trace; c012d971 <generic_file_read+81/12c>
Trace; c012d7f8 <file_read_actor+0/f8>
Trace; c0147d98 <kernel_read+4c/5c>
Trace; c015e338 <load_elf_binary+2e8/b60>
Trace; c015e050 <load_elf_binary+0/b60>
Trace; c0147940 <copy_strings+1b0/230>
Trace; c014894f <search_binary_handler+9f/1a8>
Trace; c0148b8b <do_execve+133/1a4>
Trace; c0107753 <sys_execve+2f/5c>
Trace; c0108cab <syscall_call+7/b>
Trace; c01051a6 <init+136/1b2>
Trace; c01072dc <kernel_thread+28/38>

Code;  c0246e59 <generic_make_request+101/184>
00000000 <_EIP>:
Code;  c0246e59 <generic_make_request+101/184>   <=====
   0:   83 c4 0c                  add    $0xc,%esp   <=====
Code;  c0246e5c <generic_make_request+104/184>
   3:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c0246e60 <generic_make_request+108/184>
   7:   8b 45 08                  mov    0x8(%ebp),%eax
Code;  c0246e63 <generic_make_request+10b/184>
   a:   8b 58 08                  mov    0x8(%eax),%ebx
Code;  c0246e66 <generic_make_request+10e/184>
   d:   3b 5b 44                  cmp    0x44(%ebx),%ebx
Code;  c0246e69 <generic_make_request+111/184>
  10:   74 50                     je     62 <_EIP+0x62> c0246ebb <generic_make_request+163/184>
Code;  c0246e6b <generic_make_request+113/184>
  12:   0f b7 00                  movzwl (%eax),%eax

 <0>Kernel panic: Attempted to kill init!
