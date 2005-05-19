Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVESVmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVESVmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 17:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVESVma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 17:42:30 -0400
Received: from chaos.egr.duke.edu ([152.3.195.82]:5765 "EHLO
	chaos.egr.duke.edu") by vger.kernel.org with ESMTP id S261268AbVESVmE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 17:42:04 -0400
Date: Thu, 19 May 2005 17:42:01 -0400 (EDT)
From: Joshua Baker-LePain <jlb17@duke.edu>
X-X-Sender: jlb@chaos.egr.duke.edu
To: Gregory Brauer <greg@wildbrain.com>
cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Jakob Oestergaard <jakob@unthought.net>, Chris Wedgwood <cw@f00f.org>
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
In-Reply-To: <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu>
Message-ID: <Pine.LNX.4.58.0505191740550.7094@chaos.egr.duke.edu>
References: <428511F8.6020303@wildbrain.com> <20050514184711.GA27565@taniwha.stupidest.org>
 <428B7D7F.9000107@wildbrain.com> <20050518175925.GA22738@taniwha.stupidest.org>
 <20050518195251.GY422@unthought.net> <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>
 <428BA8E4.2040108@wildbrain.com> <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu>
 <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And now I've got some OOPSes:

Unable to handle kernel NULL pointer dereference at virtual address 
00000000
 printing eip:
00000000
*pde = 37137001
Oops: 0000 [#1]
SMP 
Modules linked in: ipt_REJECT ipt_state ip_conntrack iptable_filter 
ip_tables nfsd exportfs lockd xfs md5 ipv6 parport_pc lp parport i2c_dev 
i2c_core sunrpc raid0 dm_mod button battery ac uhci_hcd hw_random e1000 
floppy ext3 jbd 3w_9xxx 3w_xxxx sd_mod scsi_mod
CPU:    2
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9-5.0.5.EL.XFSsmp) 
EIP is at 0x0
eax: ca9a8dac   ebx: c03f03e0   ecx: 00000000   edx: d8cc689c
esi: d8cc689c   edi: f2be7f04   ebp: 00000000   esp: f2be7ee8
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 3255, threadinfo=f2be6000 task=f0a5e830)
Stack: c0161332 ca9a8dac ffffffff e8f5608d 112f5575 f6b56f24 c01613a6 112f5575 
       00000005 e8f56088 ca9a8e1c ca9a8e1c ca9a8dac f6b56f24 e8f55804 f8c18aa8 
       e8f56088 f7fba800 f699c940 f7fba800 00000246 e8f4a000 e8f55800 e8f559d4 
Call Trace:
 [<c0161332>] __lookup_hash+0x70/0x89
 [<c01613a6>] lookup_one_len+0x54/0x63
 [<f8c18aa8>] nfsd_lookup+0x321/0x3ad [nfsd]
 [<f8c20061>] nfsd3_proc_lookup+0xa9/0xb3 [nfsd]
 [<f8c21fe4>] nfs3svc_decode_diropargs+0x0/0xfa [nfsd]
 [<f8c165d7>] nfsd_dispatch+0xba/0x16f [nfsd]
 [<f8b43446>] svc_process+0x420/0x6d6 [sunrpc]
 [<f8c163b7>] nfsd+0x1cc/0x332 [nfsd]
 [<f8c161eb>] nfsd+0x0/0x332 [nfsd]
 [<c01041f1>] kernel_thread_helper+0x5/0xb
Code:  Bad EIP value.
 <1>Unable to handle kernel NULL pointer dereference at virtual address 
00000000
 printing eip:
00000000
*pde = 1d5c4001
Oops: 0000 [#2]
SMP 
Modules linked in: ipt_REJECT ipt_state ip_conntrack iptable_filter 
ip_tables nfsd exportfs lockd xfs md5 ipv6 parport_pc lp parport i2c_dev 
i2c_core sunrpc raid0 dm_mod button battery ac uhci_hcd hw_random e1000 
floppy ext3 jbd 3w_9xxx 3w_xxxx sd_mod scsi_mod
CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9-5.0.5.EL.XFSsmp) 
EIP is at 0x0
eax: c325cc30   ebx: c03f03e0   ecx: 00000000   edx: f0ee79cc
esi: f0ee79cc   edi: e9d99f0c   ebp: 00000000   esp: e9d99ef0
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 3353, threadinfo=e9d98000 task=ea2130b0)
Stack: c0161332 c325cc30 ffffffff d61f10cf 002249be dad2017c c01613a6 002249be 
       00000003 d61f10cc c325cca0 c325cca0 c325cc30 dad2017c e88a9000 f8c18aa8 
       d61f10cc f7d74c00 f699ca00 c234b780 f7d74d60 ea3f7800 e88a9000 ea3f78e8 
Call Trace:
 [<c0161332>] __lookup_hash+0x70/0x89
 [<c01613a6>] lookup_one_len+0x54/0x63
 [<f8c18aa8>] nfsd_lookup+0x321/0x3ad [nfsd]
 [<f8c16c7c>] nfsd_proc_lookup+0x5f/0x71 [nfsd]
 [<f8c1e13d>] nfssvc_decode_diropargs+0x0/0xa7 [nfsd]
 [<f8c165d7>] nfsd_dispatch+0xba/0x16f [nfsd]
 [<f8b43446>] svc_process+0x420/0x6d6 [sunrpc]
 [<f8c163b7>] nfsd+0x1cc/0x332 [nfsd]
 [<f8c161eb>] nfsd+0x0/0x332 [nfsd]
 [<c01041f1>] kernel_thread_helper+0x5/0xb
Code:  Bad EIP value.


-- 
Joshua Baker-LePain
Department of Biomedical Engineering
Duke University
