Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWCLVfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWCLVfi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWCLVfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:35:38 -0500
Received: from pat.uio.no ([129.240.130.16]:55718 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932241AbWCLVfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:35:37 -0500
Subject: Re: [BUG] NFS(?) bug in 2.6.16-rc5-mm3
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: jfeise@feise.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4414777C.6020209@feise.com>
References: <4414777C.6020209@feise.com>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 16:35:17 -0500
Message-Id: <1142199317.8871.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.208, required 12,
	autolearn=disabled, AWL 1.60, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 11:33 -0800, Joe Feise wrote:
> In certain cases, when programmatically traversing a directory tree mounted
> through NFS, I get a kernel oops.
> Two examples are listed below.

Please could you retry without the cisco_ipsec module (and whatever else
is tainting the kernel).

Cheers,
  Trond

> -Joe
> 
> BUG: unable to handle kernel paging request at virtual address 0005023c
>  printing eip:
> c0169848
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> last sysfs file: /class/net/eth2/ifindex
> Modules linked in: pl2303 usbserial softdog cisco_ipsec snd_pcm_oss
> snd_mixer_oss snd_cs46xx gameport snd_raw
> midi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore
> snd_page_alloc zoran i2c_algo
> _bit videodev saa7111 i2c_core pegasus arc4 ppp_mppe ppp_deflate ppp_generic
> slhc usblp
> CPU:    0
> EIP:    0060:[<c0169848>]    Tainted: P      VLI
> EFLAGS: 00210202   (2.6.16-rc5-mm3 #9)
> EIP is at clear_inode+0x70/0x108
> eax: d8d81a00   ebx: d3f50860   ecx: d8d81a00   edx: 00050238
> esi: d3f50984   edi: 00000002   ebp: ffffe000   esp: f7d8bea8
> ds: 007b   es: 007b   ss: 0068
> Process kswapd0 (pid: 176, threadinfo=f7d8a000 task=f7d30030)
> Stack: <0>00200296 d3f50860 d8d81a00 c016a853 d3f50860 d3563a20 c016a8e9 d3563a14
>        c0167e41 f7d8a000 f7d8a000 00000097 000255a8 c17deac0 c0168230 c013c911
>        f7d8bf54 c013a0fd 00000000 012ad400 00000000 0002d036 000255a8 0000006a
> Call Trace:
>  <c016a853> generic_forget_inode+0x12a/0x15c   <c016a8e9> iput+0x53/0x65
>  <c0167e41> prune_dcache+0x12d/0x162   <c0168230> shrink_dcache_memory+0x14/0x37
>  <c013c911> shrink_slab+0x131/0x1f7   <c013a0fd> throttle_vm_writeout+0x1e/0x5d
>  <c013de1f> balance_pgdat+0x2a9/0x36c   <c013dfcf> kswapd+0xed/0x103
>  <c012805c> autoremove_wake_function+0x0/0x43   <c0102866> ret_from_fork+0x6/0x14
>  <c012805c> autoremove_wake_function+0x0/0x43   <c013dee2> kswapd+0x0/0x103
>  <c0100eed> kernel_thread_helper+0x5/0xb
> Code: 01 00 00 a8 08 0f 85 9b 00 00 00 f6 83 2c 01 00 00 20 0f 85 86 00 00 00 8b
> 83 90 00 00 00 85 c0 89 c1 7
> 4 31 8b 50 24 85 d2 74 1c <8b> 52 04 85 d2 74 15 31 d2 8b b4 93 e4 00 00 00 85
> f6 75 52 83
> ============================================================================
> BUG: unable to handle kernel paging request at virtual address 08ed08b5
>  printing eip:
> c016a8b3
> *pde = 00000000
> Oops: 0000 [#2]
> PREEMPT
> last sysfs file: /class/net/eth2/ifindex
> Modules linked in: pl2303 usbserial softdog cisco_ipsec snd_pcm_oss
> snd_mixer_oss snd_cs46xx gameport snd_raw
> midi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore
> snd_page_alloc zoran i2c_algo
> _bit videodev saa7111 i2c_core pegasus arc4 ppp_mppe ppp_deflate ppp_generic
> slhc usblp
> CPU:    0
> EIP:    0060:[<c016a8b3>]    Tainted: P      VLI
> EFLAGS: 00010202   (2.6.16-rc5-mm3 #9)
> EIP is at iput+0x1d/0x65
> eax: 08ed08a1   ebx: d3f50a00   ecx: d3f50a18   edx: d3f50a18
> esi: cf443aa0   edi: 00000045   ebp: ffffe000   esp: c821fb90
> ds: 007b   es: 007b   ss: 0068
> Process dvddump (pid: 4210, threadinfo=c821e000 task=f1599570)
> Stack: <0>cf443a94 c0167e41 c821e000 c821e000 0000010b 00041c58 c17deac0 c0168230
>        c013c911 00000000 0001d060 00000000 020e2c00 00000000 00027ae4 00041c58
>        000000d4 00000000 00000000 000000d0 00000040 c821fc5c c05a51f0 0000000a
> Call Trace:
>  <c0167e41> prune_dcache+0x12d/0x162   <c0168230> shrink_dcache_memory+0x14/0x37
>  <c013c911> shrink_slab+0x131/0x1f7   <c013dab9> try_to_free_pages+0xee/0x1ab
>  <c0138ea8> __alloc_pages+0x113/0x29c   <c014e03c> cache_grow+0x108/0x171
>  <c014d344> kmem_getpages+0x2f/0x95   <c014dff8> cache_grow+0xc4/0x171
>  <c014e20c> cache_alloc_refill+0x167/0x22c   <c014e4cb> kmem_cache_alloc+0x3f/0x41
>  <c016826e> d_alloc+0x1b/0x176   <c01688a6> d_lookup+0x19/0x39
>  <c022bd94> nfs_readdir_lookup+0xd8/0x34b   <c022ab91> nfs_do_filldir+0x5b/0x184
>  <c0163484> filldir64+0x0/0xdc   <c022afcb> nfs_readdir+0x311/0x7a2
>  <c0163484> filldir64+0x0/0xdc   <c0150006> sys_faccessat+0x45/0x132
>  <c015f233> __link_path_walk+0xc62/0xd4b   <c045a61b>
> rpcauth_lookup_credcache+0x7f/0x206
>  <c045a801> rpcauth_lookupcred+0x5f/0xb5   <c0286dea>
> radix_tree_gang_lookup_tag+0x49/0x61
>  <c028958c> __copy_to_user_ll+0x5b/0x69   <c02896a2> copy_to_user+0x36/0x53
>  <c015aa56> cp_new_stat64+0xfa/0x10e   <c0239d5f> nfs3_decode_dirent+0x0/0x1ac
>  <c0163484> filldir64+0x0/0xdc   <c0163214> vfs_readdir+0x94/0xa9
>  <c01635cd> sys_getdents64+0x6d/0xc0   <c0162799> do_fcntl+0x9e/0x155
>  <c0102997> syscall_call+0x7/0xb
> Code: 85 c9 75 05 e9 4a fd ff ff e9 93 fe ff ff 85 c0 53 89 c3 74 4c 8b 80 90 00
> 00 00 83 bb 24 01 00 00 20 8
> b 40 20 74 42 85 c0 74 07 <8b> 50 14 85 d2 75 31 8d 43 24 ba 80 84 68 c0 e8 8d
> a2 11 00 85
> 
> 

