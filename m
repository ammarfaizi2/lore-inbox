Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287532AbSAJGfE>; Thu, 10 Jan 2002 01:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287535AbSAJGep>; Thu, 10 Jan 2002 01:34:45 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:51854 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S287532AbSAJGe2>; Thu, 10 Jan 2002 01:34:28 -0500
Date: Thu, 10 Jan 2002 08:34:13 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Jani Forssell <jani.forssell@viasys.com>
Subject: Re: Via KT133 pci corruption: stock 2.4.18pre2 oopses as well
Message-ID: <20020110083413.S1200@niksula.cs.hut.fi>
In-Reply-To: <20020108215818.J1331@niksula.cs.hut.fi> <E16O2fD-0007Vn-00@the-village.bc.nu> <20020108221315.U1200@niksula.cs.hut.fi> <20020109144549.L1331@niksula.cs.hut.fi>, <20020109144549.L1331@niksula.cs.hut.fi>; <20020109172604.N1331@niksula.cs.hut.fi> <3C3CAF85.8BD5E2E1@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3CAF85.8BD5E2E1@zip.com.au>; from akpm@zip.com.au on Wed, Jan 09, 2002 at 01:00:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 01:00:53PM -0800, you [Andrew Morton] claimed:
> Ville Herva wrote:
> > 
> > >>EIP; c0131ce0 <sync_page_buffers+10/b0>   <=====
> 
> Looks like a corrupted `next' pointer in the page's buffer_head
> ring.  Your report is identical to Todd Eigenschink's repeatable
> oops.  http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.3/0689.html
<snip> 
> I am able to trigger this in around ten minutes on 2.4.13 and
> later kernels.  However 2.4.13-pre6 ran the test for nine hours
> and did not fail.

Out of curiosity: what kind of load do you use to trigger it?

> I've put the 2.4.13-pre6 -> 2.4.13 diff at http://www.zip.com.au/~akpm/1.gz

Seems your diff didn't include some bits (Maintainers changes and something
else.)

Anyhow, I compiled 2.4.13pre6 and it collapsed in just a few minutes. My
best guess is that network card pci dma is somehow fubar, and it writes
stuff to where it shouldn't.


Unable to handle kernel paging request at virtual address 86061d0e
c012f354
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f354>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 86061cee   ebx: cb4aba40   ecx: 68158c40   edx: 0000aa25
esi: cb4aba40   edi: 00000001   ebp: 00000001   esp: ceb45b48
ds: 0018   es: 0018   ss: 0018
Process ping (pid: 4134, stackpage=ceb45000)
Stack: 00000001 cb4aba40 c012fc93 cb4aba40 ceb45ba8 00000000 c012fcca cb4aba40 
       c017cdc3 cb4aba40 cb4ab7c0 000003f0 cb4ab7c0 c1324000 00000008 c1405e50 
       0000dc2f cb4aba40 c0131766 00000001 00000001 ceb45ba8 00000000 cb4aba40 
Call Trace: [<c012fc93>] [<c012fcca>] [<c017cdc3>] [<c0131766>] [<c01318a3>] 
   [<c0127a69>] [<c0127d4f>] [<c0127d9d>] [<c01286e5>] [<c012893f>] [<c0128688>]
   [<c01289ba>] [<c0126922>] [<c0126bef>] [<c01e4c2b>] [<c01e4311>] [<c01f59c3>]
   [<c01f5d3e>] [<c020c250>] [<c020c5cf>] [<c020c250>] [<c0212f70>] [<c0212fa9>]
   [<c01e1f01>] [<c0212f70>] [<c01e3177>] [<c0193800>] [<c0193a3e>] [<c0193a20>]
   [<c018f2e0>] [<c018f32a>] [<c018f696>] [<c0193a3e>] [<c018faba>] [<c0193a50>]
   [<c01e360c>] [<c0106ebb>] 
Code: 89 48 20 c1 e2 02 be 24 0b 2c c0 89 41 24 39 1c 32 75 0a 31 

>>EIP; c012f354 <__remove_from_lru_list+14/60>   <=====
Trace; c012fc93 <__refile_buffer+33/60>
Trace; c012fcca <refile_buffer+a/10>
Trace; c017cdc3 <ll_rw_block+1a3/1c0>
Trace; c0131766 <sync_page_buffers+46/a0>
Trace; c01318a3 <try_to_free_buffers+e3/110>
Trace; c0127a69 <shrink_cache+129/2b0>
Trace; c0127d4f <shrink_caches+5f/90>
Trace; c0127d9d <try_to_free_pages+1d/50>
Trace; c01286e5 <balance_classzone+55/170>
Trace; c012893f <__alloc_pages+13f/1b0>
Trace; c0128688 <_alloc_pages+18/20>
Trace; c01289ba <__get_free_pages+a/20>
Trace; c0126922 <kmem_cache_grow+a2/200>
Trace; c0126bef <kmalloc+bf/e0>
Trace; c01e4c2b <alloc_skb+cb/180>
Trace; c01e4311 <sock_alloc_send_skb+71/110>
Trace; c01f59c3 <ip_build_xmit_slow+193/4c0>
Trace; c01f5d3e <ip_build_xmit+4e/350>
Trace; c020c250 <raw_getfrag+0/30>
Trace; c020c5cf <raw_sendmsg+28f/300>
Trace; c020c250 <raw_getfrag+0/30>
Trace; c0212f70 <inet_sendmsg+0/40>
Trace; c0212fa9 <inet_sendmsg+39/40>
Trace; c01e1f01 <sock_sendmsg+81/b0>
Trace; c0212f70 <inet_sendmsg+0/40>
Trace; c01e3177 <sys_sendmsg+197/1f0>
Trace; c0193800 <hpt370_rw_proc+0/10>
Trace; c0193a3e <hpt370_dmaproc+1e/30>
Trace; c0193a20 <hpt370_dmaproc+0/30>
Trace; c018f2e0 <start_request+190/240>
Trace; c018f32a <start_request+1da/240>
Trace; c018f696 <ide_do_request+296/2e0>
Trace; c0193a3e <hpt370_dmaproc+1e/30>
Trace; c018faba <ide_intr+7a/140>
Trace; c0193a50 <ide_dma_intr+0/c0>
Trace; c01e360c <sys_socketcall+1cc/1f0>
Trace; c0106ebb <system_call+33/38>
Code;  c012f354 <__remove_from_lru_list+14/60>
00000000 <_EIP>:
Code;  c012f354 <__remove_from_lru_list+14/60>   <=====
   0:   89 48 20                  mov    %ecx,0x20(%eax)   <=====
Code;  c012f357 <__remove_from_lru_list+17/60>
   3:   c1 e2 02                  shl    $0x2,%edx
Code;  c012f35a <__remove_from_lru_list+1a/60>
   6:   be 24 0b 2c c0            mov    $0xc02c0b24,%esi
Code;  c012f35f <__remove_from_lru_list+1f/60>
   b:   89 41 24                  mov    %eax,0x24(%ecx)
Code;  c012f362 <__remove_from_lru_list+22/60>
   e:   39 1c 32                  cmp    %ebx,(%edx,%esi,1)
Code;  c012f365 <__remove_from_lru_list+25/60>
  11:   75 0a                     jne    1d <_EIP+0x1d> c012f371 <__remove_from_lru_list+31/60>
Code;  c012f367 <__remove_from_lru_list+27/60>
  13:   31 00                     xor    %eax,(%eax)


 <1>Unable to handle kernel paging request at virtual address b8f2ed62
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f4f1>]    Not tainted
EFLAGS: 00010282
eax: b8f2ed5e   ebx: cb4ab9c0   ecx: 000002f0   edx: ff2eca38
esi: cb4abd40   edi: cb4ab9c0   ebp: c127e940   esp: ceb43d34
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 4133, stackpage=ceb43000)
Stack: c0131812 cb4ab9c0 00000000 c127e940 000002f0 00002298 c0127a69 c127e940 
       000002f0 00000020 000002f0 00000006 00002299 00000020 000002f0 c0127d4f 
       00000000 00000006 00000020 00000000 000002f0 00019f2e c0127d9d 00000000 
Call Trace: [<c0131812>] [<c0127a69>] [<c0127d4f>] [<c0127d9d>] [<c01286e5>] 
   [<c012893f>] [<c0128688>] [<c01289ba>] [<c0126922>] [<c0126b19>] [<c012fdc3>]
   [<c012fe4b>] [<c0130097>] [<c01305c8>] [<c01288d8>] [<c0121b76>] [<c0132fef>]
   [<c0132f80>] [<c0121c15>] [<c01220c4>] [<c0122327>] [<c01226b5>] [<c01225e0>]
   [<c012dffe>] [<c0106ebb>] 
Code: 89 50 04 89 02 c3 89 f6 8d bc 27 00 00 00 00 8b 54 24 04 31 

>>EIP; c012f4f1 <__remove_inode_queue+11/20>   <=====
Trace; c0131812 <try_to_free_buffers+52/110>
Trace; c0127a69 <shrink_cache+129/2b0>
Trace; c0127d4f <shrink_caches+5f/90>
Trace; c0127d9d <try_to_free_pages+1d/50>
Trace; c01286e5 <balance_classzone+55/170>
Trace; c012893f <__alloc_pages+13f/1b0>
Trace; c0128688 <_alloc_pages+18/20>
Trace; c01289ba <__get_free_pages+a/20>
Trace; c0126922 <kmem_cache_grow+a2/200>
Trace; c0126b19 <kmem_cache_alloc+99/b0>
Trace; c012fdc3 <get_unused_buffer_head+33/80>
Trace; c012fe4b <create_buffers+1b/130>
Trace; c0130097 <create_empty_buffers+17/50>
Trace; c01305c8 <block_read_full_page+58/290>
Trace; c01288d8 <__alloc_pages+d8/1b0>
Trace; c0121b76 <add_to_page_cache_unique+66/70>
Trace; c0132fef <blkdev_readpage+f/20>
Trace; c0132f80 <blkdev_get_block+0/40>
Trace; c0121c15 <page_cache_read+95/c0>
Trace; c01220c4 <generic_file_readahead+104/150>
Trace; c0122327 <do_generic_file_read+1e7/4a0>
Trace; c01226b5 <generic_file_read+75/90>
Trace; c01225e0 <file_read_actor+0/60>
Trace; c012dffe <sys_read+8e/d0>
Trace; c0106ebb <system_call+33/38>
Code;  c012f4f1 <__remove_inode_queue+11/20>
00000000 <_EIP>:
Code;  c012f4f1 <__remove_inode_queue+11/20>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c012f4f4 <__remove_inode_queue+14/20>
   3:   89 02                     mov    %eax,(%edx)
Code;  c012f4f6 <__remove_inode_queue+16/20>
   5:   c3                        ret    
Code;  c012f4f7 <__remove_inode_queue+17/20>
   6:   89 f6                     mov    %esi,%esi
Code;  c012f4f9 <__remove_inode_queue+19/20>
   8:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi
Code;  c012f500 <inode_has_buffers+0/20>
   f:   8b 54 24 04               mov    0x4(%esp,1),%edx
Code;  c012f504 <inode_has_buffers+4/20>
  13:   31 00                     xor    %eax,(%eax)



-- v --

v@iki.fi
