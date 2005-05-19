Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVESWEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVESWEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 18:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVESWEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 18:04:05 -0400
Received: from mail.wildbrain.com ([209.130.193.228]:31958 "EHLO
	hermes.wildbrain.com") by vger.kernel.org with ESMTP
	id S261282AbVESWDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:03:55 -0400
Message-ID: <428D0D1E.9070607@wildbrain.com>
Date: Thu, 19 May 2005 15:03:10 -0700
From: Gregory Brauer <greg@wildbrain.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
CC: Joshua Baker-LePain <jlb17@duke.edu>,
       Jakob Oestergaard <jakob@unthought.net>, Chris Wedgwood <cw@f00f.org>
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
References: <428511F8.6020303@wildbrain.com> <20050514184711.GA27565@taniwha.stupidest.org> <428B7D7F.9000107@wildbrain.com> <20050518175925.GA22738@taniwha.stupidest.org> <20050518195251.GY422@unthought.net> <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu> <428BA8E4.2040108@wildbrain.com> <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu> <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu> <Pine.LNX.4.58.0505191740550.7094@chaos.egr.duke.edu> <Pine.LNX.4.58.0505191746470.7094@chaos.egr.duke.edu>
In-Reply-To: <Pine.LNX.4.58.0505191746470.7094@chaos.egr.duke.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-WB-MailScanner: Found to be clean
X-WB-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-2.291, required 5, BAYES_00 -2.60, TW_DF 0.08,
	TW_FC 0.08, TW_JB 0.08, TW_UH 0.08)
X-MailScanner-From: greg@wildbrain.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Baker-LePain wrote:
> On Thu, 19 May 2005 at 5:42pm, Joshua Baker-LePain wrote
> 
> 
>>And now I've got some OOPSes:
> 
> 
> But, looking at 'em (instead of just blindly sending 'em along), I don't 
> see XFS anywhere in them.  The "interesting" thing is that, of the 
> nfs_fsstress logs in /tmp on all the clients, only the NFSv3 over TCP log 
> is showing errors on any of the clients.

As noted, you seem to have stumbled upon some other bug.

We have another data point to report, this time with 
kernel-smp-2.6.10-1.741_FC3.  The one difference here worth noting
is that when this error was triggered with this kernel, the machine
did not lock up hard as with 2.6.11.1 and 2.6.11.10.  You could
still log into the machine, but processes that attempted to access
the XFS filesystem would hang.

Greg


May 19 13:44:20 violet kernel: xfs_iget_core: ambiguous vns: 
vp/0xed506a90, invp/0xed506798
May 19 13:44:20 violet kernel: ------------[ cut here ]------------
May 19 13:44:20 violet kernel: kernel BUG at fs/xfs/support/debug.c:106!
May 19 13:44:20 violet kernel: invalid operand: 0000 [#1]
May 19 13:44:20 violet kernel: SMP
May 19 13:44:20 violet kernel: Modules linked in: nfsd exportfs lockd 
md5 ipv6 parport_pc lp parport sunrpc xfs dm_mod video button battery ac 
uhci_hcd hw_random i2c_i801 i2c_core e1000 floppy ext3 jbd raid0 3w_xxxx 
sd_mod scsi_mod
May 19 13:44:20 violet kernel: CPU:    0
May 19 13:44:20 violet kernel: EIP:    0060:[<f8a2951e>]    Not tainted VLI
May 19 13:44:20 violet kernel: EFLAGS: 00010246   (2.6.10-1.741_FC3smp)
May 19 13:44:20 violet kernel: EIP is at cmn_err+0x8d/0x9b [xfs]
May 19 13:44:20 violet kernel: eax: 00000000   ebx: f8a2b743   ecx: 
f8a3faa4   edx: 00000200
May 19 13:44:20 violet kernel: esi: f8a2e17d   edi: f8a4205e   ebp: 
00000000   esp: f6bdfbb4
May 19 13:44:20 violet kernel: ds: 007b   es: 007b   ss: 0068
May 19 13:44:20 violet kernel: Process nfsd (pid: 4054, 
threadinfo=f6bdf000 task=f6bcf530)
May 19 13:44:20 violet kernel: Stack: 00000293 ed5067bc f73dc3d0 
503b6809 00000000 f8a02731 00000000 f8a2b743
May 19 13:44:20 violet kernel:        ed506a90 ed506798 f747ea00 
00000000 f74d7000 ed506798 cf8fbc2c ed5067bc
May 19 13:44:20 violet kernel:        c03a5340 ed506798 f6bdf000 
f8a02be7 503b6809 00000000 00000000 00000008
May 19 13:44:20 violet kernel: Call Trace:
May 19 13:44:20 violet kernel:  [<f8a02731>] xfs_iget_core+0x12d/0x55f [xfs]
May 19 13:44:20 violet kernel:  [<f8a02be7>] xfs_iget+0x84/0x139 [xfs]
May 19 13:44:20 violet kernel:  [<f8a1a7cc>] xfs_vget+0x43/0xae [xfs]
May 19 13:44:20 violet kernel:  [<f8a28c53>] vfs_vget+0x1a/0x1d [xfs]
May 19 13:44:20 violet kernel:  [<f8a288f1>] linvfs_get_dentry+0x3b/0x6c 
[xfs]
May 19 13:44:20 violet kernel:  [<f892c02d>] 
find_exported_dentry+0x2d/0x5a5 [exportfs]
May 19 13:44:20 violet kernel:  [<c01b4ca1>] copy_to_user+0x49/0x51
May 19 13:44:20 violet kernel:  [<c0269614>] memcpy_toiovec+0x27/0x47
May 19 13:44:20 violet kernel:  [<c0269b2a>] 
skb_copy_datagram_iovec+0x4f/0x1e1
May 19 13:44:20 violet kernel:  [<c02678b0>] release_sock+0xf/0x4f
May 19 13:44:20 violet kernel:  [<c028a98b>] tcp_recvmsg+0x61e/0x659
May 19 13:44:20 violet kernel:  [<c02679ae>] sock_common_recvmsg+0x30/0x46
May 19 13:44:20 violet kernel:  [<c0264bbc>] sock_recvmsg+0xef/0x10c
May 19 13:44:20 violet kernel:  [<c0118922>] recalc_task_prio+0x128/0x133
May 19 13:44:20 violet kernel:  [<c01189b5>] activate_task+0x88/0x95
May 19 13:44:20 violet kernel:  [<c0118e2a>] try_to_wake_up+0x222/0x22d
May 19 13:44:20 violet kernel:  [<c011a350>] __wake_up_common+0x36/0x51
May 19 13:44:20 violet kernel:  [<c011a394>] __wake_up+0x29/0x3c
May 19 13:44:20 violet kernel:  [<f896e3de>] 
svc_sock_enqueue+0x1d6/0x212 [sunrpc]
May 19 13:44:20 violet kernel:  [<f8b9ba95>] 
svc_expkey_lookup+0x1fc/0x330 [nfsd]
May 19 13:44:20 violet kernel:  [<f892c84b>] export_decode_fh+0x61/0x6d 
[exportfs]
May 19 13:44:20 violet kernel:  [<f8b977a0>] nfsd_acceptable+0x0/0xba [nfsd]
May 19 13:44:20 violet kernel:  [<f892c7ea>] export_decode_fh+0x0/0x6d 
[exportfs]
May 19 13:44:20 violet kernel:  [<f8b97ba1>] fh_verify+0x347/0x4be [nfsd]
May 19 13:44:20 violet kernel:  [<f8b977a0>] nfsd_acceptable+0x0/0xba [nfsd]
May 19 13:44:20 violet kernel:  [<f8970f4b>] 
svcauth_unix_accept+0x207/0x27a [sunrpc]
May 19 13:44:20 violet kernel:  [<c02bafb6>] schedule_timeout+0x9a/0xae
May 19 13:44:20 violet kernel:  [<f8b9914f>] nfsd_access+0x1f/0xd8 [nfsd]
May 19 13:44:20 violet kernel:  [<f8b9f0f5>] nfsd3_proc_access+0x86/0x8e 
[nfsd]
May 19 13:44:20 violet kernel:  [<f8ba07d7>] 
nfs3svc_decode_accessargs+0x0/0x7a [nfsd]
May 19 13:44:20 violet kernel:  [<f8b96540>] nfsd_dispatch+0xba/0x16e [nfsd]
May 19 13:44:20 violet kernel:  [<f896dfcb>] svc_process+0x331/0x56e 
[sunrpc]
May 19 13:44:20 violet kernel:  [<f8b9633b>] nfsd+0x190/0x2db [nfsd]
May 19 13:44:20 violet kernel:  [<f8b961ab>] nfsd+0x0/0x2db [nfsd]
May 19 13:44:20 violet kernel:  [<c01021f5>] kernel_thread_helper+0x5/0xb
May 19 13:44:20 violet kernel: Code: 68 20 20 a4 f8 ff 34 ad c0 fa a3 f8 
68 7d e1 a2 f8 e8 54 4a 6f c7 8b 54 24 0c b8 a4 fa a3 f8 e8 f0 21 89 c7 
83 c4 0c 85 ed 75 08 <0f> 0b 6a 00 64 e1 a2 f8 58 5b 5e 5f 5d c3 55 89 
c5 83 e5 07 57
