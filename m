Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUIGHXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUIGHXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 03:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267520AbUIGHXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 03:23:17 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:5358 "EHLO
	acheron.informatik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S267519AbUIGHXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 03:23:05 -0400
Message-ID: <413D6140.6020208@bio.ifi.lmu.de>
Date: Tue, 07 Sep 2004 09:20:32 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: oops with 2.6.8.1 (kswapd?)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just detected a kernel oops in my /var/log/messages, but I've no idea
what caused it... I didn't do anything special, or ran out of memory
or swap space or sth.

Here are the messages and the output of ksymoops. Does it tell someone
what could be wrong?

Sep  7 08:54:25 galois kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000005
Sep  7 08:54:25 galois kernel:  printing eip:
Sep  7 08:54:25 galois kernel: c013ba0e
Sep  7 08:54:25 galois kernel: *pde = 00000000
Sep  7 08:54:25 galois kernel: Oops: 0002 [#1]
Sep  7 08:54:25 galois kernel: Modules linked in: fglrx ipt_LOG ipt_limit iptable_filter ip_tables snd_seq_oss snd_pcm_oss snd_mixer_oss snd_seq_midi 
snd_seq_midi_event snd_seq snd_ens1371 snd_via82xx ipv6 snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd 
soundcore l2cap hci_vhci hci_uart hci_usb bluetooth via_ircc irda crc_ccitt ehci_hcd uhci_hcd usbcore it87 i2c_sensor i2c_isa i2c_core ide_cd subfs 
nls_iso8859_1 nls_cp437 vfat fat dm_mod
Sep  7 08:54:25 galois kernel: CPU:    0
Sep  7 08:54:25 galois kernel: EIP:    0060:[free_block+110/224]    Tainted: PF
Sep  7 08:54:25 galois kernel: EIP:    0060:[<c013ba0e>]    Tainted: PF
Sep  7 08:54:25 galois kernel: EFLAGS: 00010012   (2.6.8-1.3-bio-default)
Sep  7 08:54:25 galois kernel: EIP is at free_block+0x6e/0xe0
Sep  7 08:54:25 galois kernel: eax: 00000001   ebx: c32bf000   ecx: c32bf040   edx: d0fc2000
Sep  7 08:54:25 galois kernel: esi: c196c5e0   edi: 00000006   ebp: 0000001b   esp: c19d9e9c
Sep  7 08:54:25 galois kernel: ds: 007b   es: 007b   ss: 0068
Sep  7 08:54:25 galois kernel: Process kswapd0 (pid: 37, threadinfo=c19d8000 task=c19605e0)
Sep  7 08:54:25 galois kernel: Stack: c196c5fc c19fa050 c19fa050 c196c5e0 f694a580 c19ee660 c013bab6 0000001b
Sep  7 08:54:25 galois kernel:        c19fa040 c19fa040 00000286 f694a580 00000080 c013bd37 f694a614 c19d9f04
Sep  7 08:54:25 galois kernel:        00000015 c0162a04 f694a614 c0162c5f ca7dbb5c ca7dbb54 0000d95c c016300c
Sep  7 08:54:25 galois kernel: Call Trace:
Sep  7 08:54:25 galois kernel:  [cache_flusharray+54/192] cache_flusharray+0x36/0xc0
Sep  7 08:54:25 galois kernel:  [<c013bab6>] cache_flusharray+0x36/0xc0
Sep  7 08:54:25 galois kernel:  [kmem_cache_free+39/48] kmem_cache_free+0x27/0x30
Sep  7 08:54:25 galois kernel:  [<c013bd37>] kmem_cache_free+0x27/0x30
Sep  7 08:54:25 galois kernel:  [destroy_inode+68/80] destroy_inode+0x44/0x50
Sep  7 08:54:25 galois kernel:  [<c0162a04>] destroy_inode+0x44/0x50
Sep  7 08:54:25 galois kernel:  [dispose_list+31/144] dispose_list+0x1f/0x90
Sep  7 08:54:25 galois kernel:  [<c0162c5f>] dispose_list+0x1f/0x90
Sep  7 08:54:25 galois kernel:  [prune_icache+348/480] prune_icache+0x15c/0x1e0
Sep  7 08:54:25 galois kernel:  [<c016300c>] prune_icache+0x15c/0x1e0
Sep  7 08:54:25 galois kernel:  [shrink_icache_memory+53/96] shrink_icache_memory+0x35/0x60
Sep  7 08:54:25 galois kernel:  [<c01630c5>] shrink_icache_memory+0x35/0x60
Sep  7 08:54:25 galois kernel:  [shrink_slab+295/384] shrink_slab+0x127/0x180
Sep  7 08:54:25 galois kernel:  [<c013d5e7>] shrink_slab+0x127/0x180
Sep  7 08:54:25 galois kernel:  [balance_pgdat+479/656] balance_pgdat+0x1df/0x290
Sep  7 08:54:25 galois kernel:  [<c013e8ef>] balance_pgdat+0x1df/0x290
Sep  7 08:54:25 galois kernel:  [kswapd+181/208] kswapd+0xb5/0xd0
Sep  7 08:54:25 galois kernel:  [<c013ea55>] kswapd+0xb5/0xd0
Sep  7 08:54:25 galois kernel:  [autoremove_wake_function+0/48] autoremove_wake_function+0x0/0x30
Sep  7 08:54:25 galois kernel:  [<c011a220>] autoremove_wake_function+0x0/0x30
Sep  7 08:54:25 galois kernel:  [autoremove_wake_function+0/48] autoremove_wake_function+0x0/0x30
Sep  7 08:54:25 galois kernel:  [<c011a220>] autoremove_wake_function+0x0/0x30
Sep  7 08:54:25 galois kernel:  [kswapd+0/208] kswapd+0x0/0xd0
Sep  7 08:54:25 galois kernel:  [<c013e9a0>] kswapd+0x0/0xd0
Sep  7 08:54:25 galois kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
Sep  7 08:54:25 galois kernel:  [<c010424d>] kernel_thread_helper+0x5/0x18
Sep  7 08:54:25 galois kernel: Code: 89 50 04 8b 43 0c c7 03 00 01 10 00 29 c1 c7 43 04 00 02 20


Output of ksymoops:
Sep  7 08:54:25 galois kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000005
Sep  7 08:54:25 galois kernel: c013ba0e
Sep  7 08:54:25 galois kernel: *pde = 00000000
Sep  7 08:54:25 galois kernel: Oops: 0002 [#1]
Sep  7 08:54:25 galois kernel: CPU:    0
Sep  7 08:54:25 galois kernel: EIP:    0060:[free_block+110/224]    Tainted: PF
Sep  7 08:54:25 galois kernel: EIP:    0060:[<c013ba0e>]    Tainted: PF
Sep  7 08:54:25 galois kernel: EFLAGS: 00010012   (2.6.8-1.3-bio-default)
Sep  7 08:54:25 galois kernel: eax: 00000001   ebx: c32bf000   ecx: c32bf040   edx: d0fc2000
Sep  7 08:54:25 galois kernel: esi: c196c5e0   edi: 00000006   ebp: 0000001b   esp: c19d9e9c
Sep  7 08:54:25 galois kernel: ds: 007b   es: 007b   ss: 0068
Sep  7 08:54:25 galois kernel: Stack: c196c5fc c19fa050 c19fa050 c196c5e0 f694a580 c19ee660 c013bab6 0000001b
Sep  7 08:54:25 galois kernel:        c19fa040 c19fa040 00000286 f694a580 00000080 c013bd37 f694a614 c19d9f04
Sep  7 08:54:25 galois kernel:        00000015 c0162a04 f694a614 c0162c5f ca7dbb5c ca7dbb54 0000d95c c016300c
Sep  7 08:54:25 galois kernel: Call Trace:
Sep  7 08:54:25 galois kernel:  [<c013bab6>] cache_flusharray+0x36/0xc0
Sep  7 08:54:25 galois kernel:  [<c013bd37>] kmem_cache_free+0x27/0x30
Sep  7 08:54:25 galois kernel:  [<c0162a04>] destroy_inode+0x44/0x50
Sep  7 08:54:25 galois kernel:  [<c0162c5f>] dispose_list+0x1f/0x90
Sep  7 08:54:25 galois kernel:  [<c016300c>] prune_icache+0x15c/0x1e0
Sep  7 08:54:25 galois kernel:  [<c01630c5>] shrink_icache_memory+0x35/0x60
Sep  7 08:54:25 galois kernel:  [<c013d5e7>] shrink_slab+0x127/0x180
Sep  7 08:54:25 galois kernel:  [<c013e8ef>] balance_pgdat+0x1df/0x290
Sep  7 08:54:25 galois kernel:  [<c013ea55>] kswapd+0xb5/0xd0
Sep  7 08:54:25 galois kernel:  [<c011a220>] autoremove_wake_function+0x0/0x30
Sep  7 08:54:25 galois kernel:  [<c011a220>] autoremove_wake_function+0x0/0x30
Sep  7 08:54:25 galois kernel:  [<c013e9a0>] kswapd+0x0/0xd0
Sep  7 08:54:25 galois kernel:  [<c010424d>] kernel_thread_helper+0x5/0x18
Sep  7 08:54:25 galois kernel: Code: 89 50 04 8b 43 0c c7 03 00 01 10 00 29 c1 c7 43 04 00 02 20


 >>EIP; c013ba0e <free_block+6e/e0>   <=====

 >>ebx; c32bf000 <__crc_neigh_delete+458ce7/629d2b>
 >>ecx; c32bf040 <__crc_neigh_delete+458d27/629d2b>
 >>edx; d0fc2000 <__crc_audit_log_format+e79b4/114d66>
 >>esi; c196c5e0 <__crc_tcf_action_dump+e091/20db2d>
 >>esp; c19d9e9c <__crc_tcf_action_dump+7b94d/20db2d>

Trace; c013bab6 <cache_flusharray+36/c0>
Trace; c013bd37 <kmem_cache_free+27/30>
Trace; c0162a04 <destroy_inode+44/50>
Trace; c0162c5f <dispose_list+1f/90>
Trace; c016300c <prune_icache+15c/1e0>
Trace; c01630c5 <shrink_icache_memory+35/60>
Trace; c013d5e7 <shrink_slab+127/180>
Trace; c013e8ef <balance_pgdat+1df/290>
Trace; c013ea55 <kswapd+b5/d0>
Trace; c011a220 <autoremove_wake_function+0/30>
Trace; c011a220 <autoremove_wake_function+0/30>
Trace; c013e9a0 <kswapd+0/d0>
Trace; c010424d <kernel_thread_helper+5/18>

Code;  c013ba0e <free_block+6e/e0>
00000000 <_EIP>:
Code;  c013ba0e <free_block+6e/e0>   <=====
    0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c013ba11 <free_block+71/e0>
    3:   8b 43 0c                  mov    0xc(%ebx),%eax
Code;  c013ba14 <free_block+74/e0>
    6:   c7 03 00 01 10 00         movl   $0x100100,(%ebx)
Code;  c013ba1a <free_block+7a/e0>
    c:   29 c1                     sub    %eax,%ecx
Code;  c013ba1c <free_block+7c/e0>
    e:   c7 43 04 00 02 20 00      movl   $0x200200,0x4(%ebx)



cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
