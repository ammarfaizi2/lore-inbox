Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbTH1SBB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264109AbTH1SBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:01:00 -0400
Received: from ip-64-7-1-79.dsl.lax.megapath.net ([64.7.1.79]:61948 "EHLO
	ip-64-7-1-79.dsl.lax.megapath.net") by vger.kernel.org with ESMTP
	id S264117AbTH1SAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:00:52 -0400
Date: Thu, 28 Aug 2003 11:00:50 -0700 (PDT)
From: <lk@trolloc.com>
X-X-Sender: <bpape@ip-64-7-1-79.dsl.lax.megapath.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel BUG at ll_rw_blk.c:946, 2.4.21-pre6-ac2
Message-ID: <Pine.LNX.4.33.0308281100330.19223-100000@ip-64-7-1-79.dsl.lax.megapath.net>
X-keyboard: Happy Hacking Keyboard Lite
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops output is below.  I don't know if the root of the problem is in 
the ext3 code (which hasn't changed between this kernel and 2.4.23-rc1), 
or if it's actually in the elevator code, which definitely has changed.

The system uptime was almost 60 days before the crash, so I thought this 
crash report might still be of some use.

compiled with: gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
Machine config: SMP 2.4G Xeon, 2G memory


ksymoops 2.4.9 on i686 2.4.21-rc6-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-rc6-ac2/ (default)
     -m /usr/src/linux-2.4.21-rc6-ac2/System.map (specified)
     -i

kernel BUG at ll_rw_blk.c:946!
invalid operand: 0000
CPU:    2
EIP:    0010:[<c01a6cd2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000800   ebx: 00000001   ecx: ebf1b200   edx: 00002000
esi: 00000008   edi: 000f133e   ebp: 00000008   esp: e5745b8c
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 22786, stackpage=e5745000)
Stack: f88661b7 c62cac80 c62cac80 00001000 f7034294 f7034200 c62cac80 f7034294 
       00002000 f71ade40 d247c460 00000000 00000008 00000008 e5745c10 ebf1b200 
       00000008 000f133e 00000008 c01a73ba f71ade18 00000001 ebf1b200 f8866863 
Call Trace:    [<f88661b7>] [<c01a73ba>] [<f8866863>] [<c01a746b>] [<c01a7586>]
  [<f885530c>] [<f8853110>] [<f8852f31>] [<f884f70c>] [<f89adddc>] [<c020cbc6>]
  [<c0201200>] [<c021dc32>] [<c021c758>] [<c021db70>] [<f8870c60>] [<f88569b0>]
  [<f88560bc>] [<f8852bad>] [<f884e25a>] [<f884e37b>] [<f884e445>] [<c0149ba9>]
  [<f884fc4c>] [<f886c061>] [<f8861294>] [<f88647b0>] [<f8870ae0>] [<f8870ae0>]
  [<f8a3ee40>] [<f8861210>] [<f8a3f501>] [<f8870ae0>] [<f8a17856>] [<f8a46711>]
  [<f8a478e9>] [<f8a4d634>] [<f8a3a62e>] [<f8a4cc78>] [<f8a3a560>] [<f8a174bf>]
  [<f8a4d634>] [<f8a4cc98>] [<f8a3a3ff>] [<c01074fe>] [<f8a3a1e0>]
Code: 0f 0b b2 03 e4 d0 27 c0 8b 54 24 58 8b 35 90 a5 35 c0 8b 4c 


>>EIP; c01a6cd2 <__make_request+92/6a0>   <=====

>>ecx; ebf1b200 <_end+2bb6f6a0/38461500>
>>esp; e5745b8c <_end+2539a02c/38461500>

Trace; f88661b7 <[ext3]ext3_do_update_inode+177/3e0>
Trace; c01a73ba <generic_make_request+da/130>
Trace; f8866863 <[ext3]ext3_mark_iloc_dirty+43/70>
Trace; c01a746b <submit_bh+5b/80>
Trace; c01a7586 <ll_rw_block+f6/1d0>
Trace; f885530c <[jbd]journal_update_superblock+5c/a0>
Trace; f8853110 <[jbd]cleanup_journal_tail+a0/120>
Trace; f8852f31 <[jbd]log_do_checkpoint+21/160>
Trace; f884f70c <[jbd]journal_dirty_metadata+15c/1f0>
Trace; f89adddc <[e1000]e1000_xmit_frame+12c/260>
Trace; c020cbc6 <qdisc_restart+16/1a0>
Trace; c0201200 <dev_queue_xmit+290/350>
Trace; c021dc32 <ip_finish_output2+a2/110>
Trace; c021c758 <ip_output+68/b0>
Trace; c021db70 <output_maybe_reroute+0/20>
Trace; f8870c60 <[ext3]ext3_sops+0/50>
Trace; f88569b0 <[jbd]__ksymtab_journal_abort+0/8>
Trace; f88560bc <[jbd]__jbd_kmalloc+2c/80>
Trace; f8852bad <[jbd]log_wait_for_space+8d/a0>
Trace; f884e25a <[jbd]start_this_handle+ba/190>
Trace; f884e37b <[jbd]new_handle+4b/70>
Trace; f884e445 <[jbd]journal_start+a5/c0>
Trace; c0149ba9 <fsync_buffers_list+e9/1d0>
Trace; f884fc4c <[jbd]journal_force_commit+3c/90>
Trace; f886c061 <[ext3]ext3_force_commit+51/80>
Trace; f8861294 <[ext3]ext3_sync_file+84/b0>
Trace; f88647b0 <[ext3]ext3_writepage+0/370>
Trace; f8870ae0 <[ext3]ext3_file_operations+0/60>
Trace; f8870ae0 <[ext3]ext3_file_operations+0/60>
Trace; f8a3ee40 <[nfsd]nfsd_sync+70/b0>
Trace; f8861210 <[ext3]ext3_sync_file+0/b0>
Trace; f8a3f501 <[nfsd]nfsd_commit+a1/b0>
Trace; f8870ae0 <[ext3]ext3_file_operations+0/60>
Trace; f8a17856 <[sunrpc]svc_sock_enqueue+1b6/240>
Trace; f8a46711 <[nfsd]nfsd3_proc_commit+a1/130>
Trace; f8a478e9 <[nfsd]nfs3svc_decode_commitargs+29/c0>
Trace; f8a4d634 <[nfsd]nfsd_procedures3+2f4/320>
Trace; f8a3a62e <[nfsd]nfsd_dispatch+ce/1e5>
Trace; f8a4cc78 <[nfsd]nfsd_version3+0/10>
Trace; f8a3a560 <[nfsd]nfsd_dispatch+0/1e5>
Trace; f8a174bf <[sunrpc]svc_process+45f/590>
Trace; f8a4d634 <[nfsd]nfsd_procedures3+2f4/320>
Trace; f8a4cc98 <[nfsd]nfsd_program+0/28>
Trace; f8a3a3ff <[nfsd]nfsd+21f/380>
Trace; c01074fe <arch_kernel_thread+2e/40>
Trace; f8a3a1e0 <[nfsd]nfsd+0/380>

Code;  c01a6cd2 <__make_request+92/6a0>
00000000 <_EIP>:
Code;  c01a6cd2 <__make_request+92/6a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01a6cd4 <__make_request+94/6a0>
   2:   b2 03                     mov    $0x3,%dl
Code;  c01a6cd6 <__make_request+96/6a0>
   4:   e4 d0                     in     $0xd0,%al
Code;  c01a6cd8 <__make_request+98/6a0>
   6:   27                        daa    
Code;  c01a6cd9 <__make_request+99/6a0>
   7:   c0 8b 54 24 58 8b 35      rorb   $0x35,0x8b582454(%ebx)
Code;  c01a6ce0 <__make_request+a0/6a0>
   e:   90                        nop    
Code;  c01a6ce1 <__make_request+a1/6a0>
   f:   a5                        movsl  %ds:(%esi),%es:(%edi)
Code;  c01a6ce2 <__make_request+a2/6a0>
  10:   35 c0 8b 4c 00            xor    $0x4c8bc0,%eax





