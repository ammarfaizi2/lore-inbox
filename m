Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317419AbSFCQt1>; Mon, 3 Jun 2002 12:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317420AbSFCQt0>; Mon, 3 Jun 2002 12:49:26 -0400
Received: from ma-northadams1b-111.bur.adelphia.net ([24.52.166.111]:10371
	"EHLO ma-northadams1b-111.bur.adelphia.net") by vger.kernel.org
	with ESMTP id <S317419AbSFCQtY>; Mon, 3 Jun 2002 12:49:24 -0400
Date: Mon, 3 Jun 2002 12:54:38 -0400
From: Eric Buddington <eric@ma-northadams1b-111.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18: oops in kmem_cache_free (involving reiserfs)
Message-ID: <20020603125438.B30151@ma-northadams1b-111.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an unpatched 2.4.18 kernel on a Duron 950, configured with
everything modular. My Hauppage TV/capture card sometimes causes
partial lockups or reboots; I don't know if this could be related to
that.

-Eric

---------------------
ksymoops 2.4.3 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /packages/linux/2.4.18/athlon/boot/System.map (specified)

cpu: 0, clocks: 1991182, slice: 995591
Warning: unable to open an initial console.
8139too Fast Ethernet driver 0.9.24
Unable to handle kernel paging request at virtual address 003f2000
c012b72e
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012b72e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: c0578000   ebx: c0010000   ecx: 00000006   edx: 003f2000
esi: cdfecdd4   edi: 00000202   ebp: c12bcacc   esp: c344bd34
ds: 0018   es: 0018   ss: 0018
Process yuv2lav (pid: 4412, stackpage=c344b000)
Stack: c00103c0 c00103c0 c00103c0 c01347b2 cdfecdd4 c00103c0 c0136596 c00103c0 
       c00103c0 00000000 00000000 c010a308 c1181ec8 c00103c0 00001000 c00103c0 
       00000000 c0134acb c12bcacc 00000000 c12bcacc c929d624 0000061a 00000000 
Call Trace: [<c01347b2>] [<c0136596>] [<c010a308>] [<c0134acb>] [<c0125a99>] 
   [<c0125ab4>] [<c0125bbb>] [<c013e3f1>] [<c0180810>] [<c0125c8b>] [<c0123e6b>] 
   [<c0145c34>] [<c0180f07>] [<c0124175>] [<c0145da2>] [<c013123f>] [<c013c5f6>] 
   [<c0125633>] [<c01320e4>] [<c0132429>] [<c0106d2b>] 
Code: 89 02 8b 46 08 8d 56 08 89 58 04 89 03 89 53 04 89 5e 08 eb 
>>EIP; c012b72e <kmem_cache_free+5e/90>   <=====
Trace; c01347b2 <__put_unused_buffer_head+22/50>
Trace; c0136596 <try_to_free_buffers+b6/100>
Trace; c010a308 <call_do_IRQ+6/e>
Trace; c0134aca <discard_bh_page+6a/80>
Trace; c0125a98 <do_flushpage+28/30>
Trace; c0125ab4 <truncate_complete_page+14/50>
Trace; c0125bba <truncate_list_pages+ca/160>
Trace; c013e3f0 <page_getlink+20/70>
Trace; c0180810 <reiserfs_readpage+0/20>
Trace; c0125c8a <truncate_inode_pages+3a/70>
Trace; c0123e6a <vmtruncate+9a/140>
Trace; c0145c34 <inode_setattr+24/d0>
Trace; c0180f06 <reiserfs_setattr+c6/10c>
Trace; c0124174 <do_no_page+34/130>
Trace; c0145da2 <notify_change+52/160>
Trace; c013123e <do_truncate+3e/60>
Trace; c013c5f6 <open_namei+336/5b0>
Trace; c0125632 <do_brk+1f2/220>
Trace; c01320e4 <filp_open+34/60>
Trace; c0132428 <sys_open+38/a0>
Trace; c0106d2a <system_call+32/38>
Code;  c012b72e <kmem_cache_free+5e/90>
00000000 <_EIP>:
Code;  c012b72e <kmem_cache_free+5e/90>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012b730 <kmem_cache_free+60/90>
   2:   8b 46 08                  mov    0x8(%esi),%eax
Code;  c012b732 <kmem_cache_free+62/90>
   5:   8d 56 08                  lea    0x8(%esi),%edx
Code;  c012b736 <kmem_cache_free+66/90>
   8:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  c012b738 <kmem_cache_free+68/90>
   b:   89 03                     mov    %eax,(%ebx)
Code;  c012b73a <kmem_cache_free+6a/90>
   d:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c012b73e <kmem_cache_free+6e/90>
  10:   89 5e 08                  mov    %ebx,0x8(%esi)
Code;  c012b740 <kmem_cache_free+70/90>
  13:   eb 00                     jmp    15 <_EIP+0x15> c012b742 <kmem_cache_free+72/90>

