Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263781AbUEMFZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbUEMFZg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 01:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUEMFZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 01:25:36 -0400
Received: from d64-180-152-77.bchsia.telus.net ([64.180.152.77]:1029 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S263781AbUEMFZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 01:25:33 -0400
Date: Wed, 12 May 2004 22:20:27 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: oops w/ 2.6.6-rc3 dcache
Message-ID: <20040513052027.GA11997@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

will upgrade kernel to latest bk pull now, but in case this isn't a known
issue.

debian/stable, IBM T30 laptop

ksymoops 2.4.9 on i686 2.6.6-rc3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.6-rc3/ (specified)
     -m /boot/System.map-2.6.6-rc3 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
May 12 22:10:03 hasenpfeffer kernel: Unable to handle kernel paging request at virtual address ffffeb23
May 12 22:10:03 hasenpfeffer kernel: c0156cbb
May 12 22:10:03 hasenpfeffer kernel: *pde = 00002067
May 12 22:10:03 hasenpfeffer kernel: Oops: 0003 [#1]
May 12 22:10:03 hasenpfeffer kernel: CPU:    0
May 12 22:10:03 hasenpfeffer kernel: EIP:    0060:[<c0156cbb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
May 12 22:10:03 hasenpfeffer kernel: EFLAGS: 00010212   (2.6.6-rc3) 
May 12 22:10:03 hasenpfeffer kernel: eax: c02aae84   ebx: 00000080   ecx: c41e8810   edx: ffffeb23
May 12 22:10:03 hasenpfeffer kernel: esi: c41e8e80   edi: 000001c9   ebp: 00000026   esp: cf8bbc18
May 12 22:10:03 hasenpfeffer kernel: ds: 007b   es: 007b   ss: 0068
May 12 22:10:03 hasenpfeffer kernel: Stack: 00000080 000001c9 000001c9 00000000 c0157261 00000080 c01339d0 00000080 
May 12 22:10:03 hasenpfeffer kernel:        000001d0 cf8bbcac 000001d0 c02a9ca4 cf8bbde4 00e28780 00000000 00007ea6 
May 12 22:10:03 hasenpfeffer kernel:        cff5eadc c01349b8 00000040 000001d0 c02a9ca4 00000009 cf8bbca8 000001d0 
May 12 22:10:03 hasenpfeffer kernel: Call Trace: [<c0157261>]  [<c01339d0>]  [<c01349b8>]  [<c012eb11>]  [<c0130aa2>]  [<c0130cec>]  [<c012b62e>]  [<c012bb67>]  [<c012b8d4>]  [<c012bc53>]  [<c011d22f>]  [<c011e5c0>]  [<c01099b3>]  [<c01099dc>]  [<c014320c>]  [<c01433ed>]  [<c0103bcf>] 
May 12 22:10:03 hasenpfeffer kernel: Code: 89 02 89 09 89 49 04 a1 88 ae 2a c0 0f 18 00 90 ff 0d 90 ae 


>>EIP; c0156cbb <prune_dcache+27/1d4>   <=====

>>eax; c02aae84 <dentry_unused+0/8>
>>ecx; c41e8810 <pg0+3ee4810/3fcfa000>
>>edx; ffffeb23 <__kernel_rt_sigreturn+6e3/????>
>>esi; c41e8e80 <pg0+3ee4e80/3fcfa000>
>>esp; cf8bbc18 <pg0+f5b7c18/3fcfa000>

Trace; c0157261 <shrink_dcache_memory+15/20>
Trace; c01339d0 <shrink_slab+108/16c>
Trace; c01349b8 <try_to_free_pages+b8/174>
Trace; c012eb11 <__alloc_pages+1d5/2c0>
Trace; c0130aa2 <do_page_cache_readahead+102/1ac>
Trace; c0130cec <page_cache_readahead+1a0/1dc>
Trace; c012b62e <do_generic_mapping_read+b2/358>
Trace; c012bb67 <__generic_file_aio_read+1bb/1dc>
Trace; c012b8d4 <file_read_actor+0/d8>
Trace; c012bc53 <generic_file_read+7b/98>
Trace; c011d22f <kill_proc_info+47/50>
Trace; c011e5c0 <sys_kill+54/5c>
Trace; c01099b3 <restore_i387_fxsave+67/78>
Trace; c01099dc <restore_i387+18/84>
Trace; c014320c <vfs_read+a0/d0>
Trace; c01433ed <sys_read+31/4c>
Trace; c0103bcf <syscall_call+7/b>

Code;  c0156cbb <prune_dcache+27/1d4>
00000000 <_EIP>:
Code;  c0156cbb <prune_dcache+27/1d4>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c0156cbd <prune_dcache+29/1d4>
   2:   89 09                     mov    %ecx,(%ecx)
Code;  c0156cbf <prune_dcache+2b/1d4>
   4:   89 49 04                  mov    %ecx,0x4(%ecx)
Code;  c0156cc2 <prune_dcache+2e/1d4>
   7:   a1 88 ae 2a c0            mov    0xc02aae88,%eax
Code;  c0156cc7 <prune_dcache+33/1d4>
   c:   0f 18 00                  prefetchnta (%eax)
Code;  c0156cca <prune_dcache+36/1d4>
   f:   90                        nop    
Code;  c0156ccb <prune_dcache+37/1d4>
  10:   ff 0d 90 ae 00 00         decl   0xae90

