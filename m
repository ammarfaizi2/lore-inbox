Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVERRix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVERRix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 13:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVERRix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 13:38:53 -0400
Received: from mail.wildbrain.com ([209.130.193.228]:8588 "EHLO
	hermes.wildbrain.com") by vger.kernel.org with ESMTP
	id S262191AbVERRiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:38:21 -0400
Message-ID: <428B7D7F.9000107@wildbrain.com>
Date: Wed, 18 May 2005 10:38:07 -0700
From: Gregory Brauer <greg@wildbrain.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
CC: Chris Wedgwood <cw@f00f.org>
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
References: <428511F8.6020303@wildbrain.com> <20050514184711.GA27565@taniwha.stupidest.org>
In-Reply-To: <20050514184711.GA27565@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-WB-MailScanner: Found to be clean
X-WB-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-2.445, required 5, BAYES_00 -2.60, TW_JB 0.08,
	TW_UH 0.08)
X-MailScanner-From: greg@wildbrain.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Fri, May 13, 2005 at 01:45:44PM -0700, Gregory Brauer wrote:
> 
> 
>>I have seen some references to a similar bug in other kernel list
>>posts from October 2004 and am trying to figure out if this is the
>>same problem, or something new related to the xfs_iget_core patch in
>>2.6.11.  This seems to be a very hard to reproduce bug, but we've
>>seen this problem twice in a week of testing under Fedora
>>Core 3 on the following kernel:
> 
> 
> does disabling CONFIG_4K_STACKS help?

No.  Here is the oops for a kernel.org kernel 2.6.11.10 compiled
with the same config file that FC3 uses for their kernel
(2.6.11-1.14_FC3) except with the CONFIG_4KSTACKS=y line
commented out.  This one died after about 8 hours of testing.



May 18 02:59:47 violet kernel: xfs_iget_core: ambiguous vns:
vp/0xf53f8ac8, invp/0xe49ccc4c
May 18 02:59:47 violet kernel: ------------[ cut here ]------------
May 18 02:59:47 violet kernel: kernel BUG at fs/xfs/support/debug.c:106!
May 18 02:59:47 violet kernel: invalid operand: 0000 [#1]
May 18 02:59:47 violet kernel: SMP
May 18 02:59:47 violet kernel: Modules linked in: nfsd lockd md5 ipv6
parport_pc lp parport sunrpc xfs exportfs dm_mod video button battery ac
uhci_h
cd hw_random i2c_i801 i2c_core e1000 bonding floppy ext3 jbd raid0
3w_xxxx sd_mod scsi_mod
May 18 02:59:47 violet kernel: CPU:    0
May 18 02:59:47 violet kernel: EIP:    0060:[<f9206de5>]    Not tainted VLI
May 18 02:59:47 violet kernel: EFLAGS: 00010246   (2.6.11.10)
May 18 02:59:47 violet kernel: EIP is at cmn_err+0xa5/0xd0 [xfs]
May 18 02:59:47 violet kernel: eax: 00000000   ebx: f920a178   ecx:
f921e484   edx: 00000200
May 18 02:59:47 violet kernel: esi: f92099f8   edi: f921fa1e   ebp:
00000000   esp: f643db48
May 18 02:59:47 violet kernel: ds: 007b   es: 007b   ss: 0068
May 18 02:59:47 violet kernel: Process nfsd (pid: 6177,
threadinfo=f643c000 task=f6ab4560)
May 18 02:59:47 violet kernel: Stack: f92099f8 f92099bf f921f9e0
00000282 f643c000 f920a178 00000000 dc8444ac
May 18 02:59:47 violet kernel:        f91d5fe4 00000000 f920a178
f53f8ac8 e49ccc4c f71d7c00 f92053b3 ed7c01f4
May 18 02:59:47 violet kernel:        00000000 e49ccc70 ed7c01f0
00000000 f707f400 e49ccc4c dc8444ac e49ccc70
May 18 02:59:47 violet kernel: Call Trace:
May 18 02:59:47 violet kernel:  [<f91d5fe4>] xfs_iget_core+0x514/0x610 [xfs]
May 18 02:59:47 violet kernel:  [<f92053b3>]
linvfs_alloc_inode+0x23/0x30 [xfs]
May 18 02:59:47 violet kernel:  [<f91d61b4>] xfs_iget+0xd4/0x170 [xfs]
May 18 02:59:47 violet kernel:  [<f91f3f2b>] xfs_vget+0x6b/0xf0 [xfs]
May 18 02:59:47 violet kernel:  [<c02c25d1>] alloc_skb+0x41/0xf0
May 18 02:59:47 violet kernel:  [<f920613d>] vfs_vget+0x2d/0x40 [xfs]
May 18 02:59:47 violet kernel:  [<f919c659>] linvfs_get_dentry+0x39/0x70
[xfs]
May 18 02:59:47 violet kernel:  [<f88ea02d>]
find_exported_dentry+0x2d/0x630 [exportfs]
May 18 02:59:47 violet kernel:  [<c02e890c>] ip_append_data+0x57c/0x850
May 18 02:59:47 violet kernel:  [<c0305759>] udp_sendmsg+0x2f9/0x6d0
May 18 02:59:47 violet kernel:  [<f897f627>]
e1000_xmit_frame+0x557/0x8e0 [e1000]
May 18 02:59:47 violet kernel:  [<c03274c2>] packet_rcv_spkt+0xd2/0x260
May 18 02:59:47 violet kernel:  [<c02d8330>] qdisc_restart+0x20/0x230
May 18 02:59:47 violet kernel:  [<c02c85fb>] dev_queue_xmit+0x26b/0x300
May 18 02:59:47 violet kernel:  [<c02e6f9a>] ip_finish_output+0xda/0x290
May 18 02:59:47 violet kernel:  [<c02be4e8>] sock_sendmsg+0x118/0x150
May 18 02:59:47 violet kernel:  [<c02e9280>]
ip_push_pending_frames+0x240/0x490
May 18 02:59:47 violet kernel:  [<c0138730>]
autoremove_wake_function+0x0/0x50
May 18 02:59:47 violet kernel:  [<c03052e9>]
udp_push_pending_frames+0x139/0x270
May 18 02:59:47 violet kernel:  [<c011d158>] recalc_task_prio+0x88/0x150
May 18 02:59:47 violet kernel:  [<f8ae151a>]
svc_expkey_lookup+0x40a/0x430 [nfsd]
May 18 02:59:47 violet kernel:  [<f919c5b3>] linvfs_decode_fh+0x63/0xd0
[xfs]
May 18 02:59:47 violet kernel:  [<f8adbf50>] nfsd_acceptable+0x0/0x100
[nfsd]
May 18 02:59:47 violet kernel:  [<f919c550>] linvfs_decode_fh+0x0/0xd0 [xfs]
May 18 02:59:47 violet kernel:  [<f8adc228>] fh_verify+0x1d8/0x5a0 [nfsd]
May 18 02:59:47 violet kernel:  [<f8adbf50>] nfsd_acceptable+0x0/0x100
[nfsd]
May 18 02:59:47 violet kernel:  [<f8add053>] nfsd_lookup+0x43/0x4d0 [nfsd]
May 18 02:59:47 violet kernel:  [<f8adaf44>] nfsd_proc_lookup+0x54/0xa0
[nfsd]
May 18 02:59:47 violet kernel:  [<f8ae3d30>]
nfssvc_decode_diropargs+0x0/0xd0 [nfsd]
May 18 02:59:47 violet kernel:  [<f8ada5ba>] nfsd_dispatch+0x8a/0x210 [nfsd]
May 18 02:59:47 violet kernel:  [<f8c1afb6>] svc_authenticate+0x86/0xd0
[sunrpc]
May 18 02:59:47 violet kernel:  [<f8c18641>] svc_process+0x551/0x640
[sunrpc]
May 18 02:59:47 violet kernel:  [<c01172bc>]
smp_call_function_interrupt+0x3c/0x60
May 18 02:59:47 violet kernel:  [<c0104b04>]
call_function_interrupt+0x1c/0x24
May 18 02:59:47 violet kernel:  [<f8ada3b0>] nfsd+0x190/0x310 [nfsd]
May 18 02:59:47 violet kernel:  [<f8ada220>] nfsd+0x0/0x310 [nfsd]
May 18 02:59:47 violet kernel:  [<c0102345>] kernel_thread_helper+0x5/0x10
May 18 02:59:47 violet kernel: Code: b8 e0 f9 21 f9 89 44 24 08 8b 04 ad
a0 e4 21 f9 89 44 24 04 e8 ed cd f1 c6 8b 54 24 0c b8 84 e4 21 f9 e8 bf 4d 1
2 c7 85 ed 75 08 <0f> 0b 6a 00 df 99 20 f9 8b 5c 24 10 8b 74 24 14 8b 7c
24 18 8b


Greg
