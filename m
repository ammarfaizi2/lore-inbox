Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267513AbTAQPGQ>; Fri, 17 Jan 2003 10:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267524AbTAQPGQ>; Fri, 17 Jan 2003 10:06:16 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:18574 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S267513AbTAQPGO>; Fri, 17 Jan 2003 10:06:14 -0500
Message-ID: <3E281CE2.6030903@oracle.com>
Date: Fri, 17 Jan 2003 16:10:26 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 broke CONFIG_PACKET=m ?
References: <15911.56825.330331.454711@harpo.it.uu.se>
In-Reply-To: <15911.56825.330331.454711@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 2.5.59 with CONFIG_PACKET=m oopes when af_packet.ko is insmodded:
> 
> Unable to handle kernel paging request at virtual address 2220c021
>  printing eip:
> c0124011
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0060:[<c0124011>]    Not tainted
> EFLAGS: 00010097
> EIP is at __find_symbol+0x3d/0x7c
> eax: c020f70e   ebx: 00000536   ecx: 00000000   edx: c028b600
> esi: 2220c021   edi: e8889558   ebp: e8889558   esp: e67c5ecc
> ds: 007b   es: 007b   ss: 0068
> Process insmod (pid: 482, threadinfo=e67c4000 task=e6c80ce0)
> Stack: e8888f34 e8889a40 00000038 e8883f50 c0124960 e8889558 e67c5ef4 00000001 
>        e8888f34 e8889374 e67c5f28 c0124b2a e8883f50 00000016 e8889374 e8889558 
>        e8889a40 e8883f50 0000000c 00000017 e8889a40 00000000 0000007c c01253a4 
> Call Trace:
>  [<c0124960>] resolve_symbol+0x20/0x4c
>  [<c0124b2a>] simplify_symbols+0x82/0xe4
>  [<c01253a4>] load_module+0x5c4/0x7ec
>  [<c012562b>] sys_init_module+0x5f/0x194
>  [<c0108887>] syscall_call+0x7/0xb
> 
> Code: ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 0e 
>  
> The same oops also happended when the box tried to load some NFS server module.
> 
> 2.5.58 modular had no problems, and 2.5.59 monolithic also works.

Really. My 2.5.58 doesn't autoload modules anymore, as 2.5.59,
  and when I tried using PPP in 2.5.59 I first got

----------------------------------------------------------------
This system lacks kernel support for PPP.  This could be because
  the PPP kernel module could not be loaded, or because PPP was
  not included in the kernel configuration.  If PPP was included
  as a module, try `/sbin/modprobe -v ppp'.  If that fails, check
  that ppp.o exists in /lib/modules/`uname -r`/net.
See README.linux file in the ppp distribution for more details.
----------------------------------------------------------------

Then I tried modprobe'ing ppp_generic... double boom !


Unable to handle kernel paging request at virtual address e3a0c036
  printing eip:
c012d336
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c012d336>]    Not tainted
EFLAGS: 00010097
EIP is at __find_symbol+0x46/0x90
eax: 00000789   ebx: c03f6ae0   ecx: 00000000   edx: d086c875
esi: e3a0c036   edi: d086c875   ebp: c035a5a2   esp: c8de5ec4
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4341, threadinfo=c8de4000 task=cc90b860)
Stack: c036b8f0 00000789 c8de4000 0000002e d086c8e0 d08685e4 c012df3c d086c875
        c8de5eec 00000001 c1360320 d086c624 0000002e 00000037 c012e20a d08685e4
        00000012 d086c6b4 d086c875 d086c8e0 00000000 d086c6b4 d0867000 d086c8e0
Call Trace:
  [<c012df3c>] resolve_symbol+0x3c/0x90
  [<c012e20a>] simplify_symbols+0xba/0x120
  [<c012e9b7>] load_module+0x477/0x8d0
  [<c012ee9c>] sys_init_module+0x8c/0x1e0
  [<c01095df>] syscall_call+0x7/0xb

Code: ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 74 24
  <6>note: modprobe[4341] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
  [<c01186eb>] schedule+0x30b/0x310
  [<c013e85a>] cond_resched_lock+0x1a/0x20
  [<c013cd1b>] unmap_vmas+0x13b/0x230
  [<c0140a58>] exit_mmap+0x78/0x190
  [<c011a204>] mmput+0x54/0xb0
  [<c011db7c>] do_exit+0xfc/0x2e0
  [<c0109d15>] die+0x85/0x90
  [<c0116f9a>] do_page_fault+0x14a/0x45e
  [<c0184473>] ext3_dirty_inode+0x93/0x140
  [<c0131c79>] do_generic_mapping_read+0x229/0x410
  [<c016a6f6>] __mark_inode_dirty+0x106/0x110
  [<c0164a46>] update_atime+0xa6/0xc0
  [<c0132164>] __generic_file_aio_read+0x1d4/0x210
  [<c0131ea0>] file_read_actor+0x0/0xf0
  [<c0116e50>] do_page_fault+0x0/0x45e
  [<c0109789>] error_code+0x2d/0x38
  [<c012d336>] __find_symbol+0x46/0x90
  [<c012df3c>] resolve_symbol+0x3c/0x90
  [<c012e20a>] simplify_symbols+0xba/0x120
  [<c012e9b7>] load_module+0x477/0x8d0
  [<c012ee9c>] sys_init_module+0x8c/0x1e0
  [<c01095df>] syscall_call+0x7/0xb


This happened with Rusty's 0.9.8 utils. Currently I'm writing
  under 2.4.21-pre3 and 0.9.9pre utils - PPP loads just fine.

--alessandro

  "And though it don't seem fair, for every smile that plays
    a tear must fall somewhere"
        (Bruce Springsteen, "The Price You Pay", live 31/12/1980)

