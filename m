Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVBRL33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVBRL33 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 06:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVBRL32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 06:29:28 -0500
Received: from mail.physik.uni-muenchen.de ([192.54.42.129]:962 "EHLO
	mail.physik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S261332AbVBRL3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 06:29:15 -0500
From: Klaus Steinberger <Klaus.Steinberger@Physik.Uni-Muenchen.DE>
To: linux-kernel@vger.kernel.org
Subject: Re: [Oops] 2.6.10: PREEMPT SMP
Date: Fri, 18 Feb 2005 12:29:11 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200502181229.11316.Klaus.Steinberger@Physik.Uni-Muenchen.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

> Hmmm... I see it involves the key stuff I wrote.

Did you find out something about this bug? I did get the same crash on a 
heavily loaded NFS and Samba Server running Fedora Core 2 with 
kernel-2.6.10-1.12_FC2.

Here the OOPS:
Feb 18 09:58:08 mllrd02 kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 0000000c
Feb 18 09:58:08 mllrd02 kernel:  printing eip:
Feb 18 09:58:08 mllrd02 kernel: c01b48ec
Feb 18 09:58:08 mllrd02 kernel: *pde = 111b3001
Feb 18 09:58:08 mllrd02 kernel: Oops: 0000 [#1]
Feb 18 09:58:08 mllrd02 kernel: SMP
Feb 18 09:58:08 mllrd02 kernel: Modules linked in: nfsd exportfs nfs lockd 
parport_pc lp parport autofs4 sunrpc iptable_filter ip_tables tg3 floppy sg 
microcode ohci_hcd video button battery ac md5 ipv6 ext3 jbd dm_mod qla2300 
qla2xxx scsi_transport_fc aacraid(U) aic79xx sd_mod scsi_mod
Feb 18 09:58:08 mllrd02 kernel: CPU:    3
Feb 18 09:58:08 mllrd02 kernel: EIP:    0060:[<c01b48ec>]    Not tainted VLI
Feb 18 09:58:08 mllrd02 kernel: EFLAGS: 00010203   (2.6.10-1.12_FC2smp)
Feb 18 09:58:08 mllrd02 kernel: EIP is at __rb_rotate_left+0x8/0x36
Feb 18 09:58:08 mllrd02 kernel: eax: de05f940   ebx: c04265e4   ecx: de05f940   
edx: 00000000
Feb 18 09:58:08 mllrd02 kernel: esi: de05f940   edi: f652db80   ebp: c04265e4   
esp: eef86ed0
Feb 18 09:58:08 mllrd02 kernel: ds: 007b   es: 007b   ss: 0068
Feb 18 09:58:08 mllrd02 kernel: Process smbd (pid: 3204, threadinfo=eef86000 
task=f72e7020)
Feb 18 09:58:08 mllrd02 kernel: Stack: c5887700 c01b49fd f652db80 f652db80 
c5887708 000000b1 c0197650 c5887700
Feb 18 09:58:08 mllrd02 kernel:        0000000d eef86f54 eef86f61 ffffffea 
c0197704 00000015 00000000 000000b1
Feb 18 09:58:08 mllrd02 kernel:        c031f1e0 eef86f54 00000000 f5675a40 
000000b1 c019887d ffffffff 001f0000
Feb 18 09:58:08 mllrd02 kernel: Call Trace:
Feb 18 09:58:08 mllrd02 kernel:  [<c01b49fd>] rb_insert_color+0xad/0xcc
Feb 18 09:58:08 mllrd02 kernel:  [<c0197650>] key_user_lookup+0xd4/0x101
Feb 18 09:58:08 mllrd02 kernel:  [<c0197704>] key_alloc+0x53/0x2bf
Feb 18 09:58:08 mllrd02 kernel:  [<c019887d>] keyring_alloc+0x1a/0x48
Feb 18 09:58:08 mllrd02 kernel:  [<c0199dfb>] alloc_uid_keyring+0x2b/0x7b
Feb 18 09:58:08 mllrd02 kernel:  [<c0125fa2>] alloc_uid+0xb6/0x143
Feb 18 09:58:08 mllrd02 kernel:  [<c0129489>] set_user+0xb/0x8c
Feb 18 09:58:08 mllrd02 kernel:  [<c012988b>] sys_setresuid+0x105/0x1a4
Feb 18 09:58:08 mllrd02 kernel:  [<c0103ccb>] syscall_call+0x7/0xb
Feb 18 09:58:08 mllrd02 kernel: Code: 59 83 bc 82 04 01 00 00 00 75 ea 41 83 
f9 01 76 ed 31 c0 5b c3 57 b9 45 00 00 00 89 c7 31 c0 f3 ab 5f c3 53 89 c1 89 
d3 8b 50 08 <8b> 42 0c 85 c0 89 41 08 74 02 89 08 89 4a 0c 8b 01 85 c0 89 02


Sincerly,
Klaus


-- 
Klaus Steinberger         Maier-Leibnitz Labor
Phone: (+49 89)289 14287  Am Coulombwall 6, D-85748 Garching, Germany
FAX:   (+49 89)289 14280  EMail: Klaus.Steinberger@Physik.Uni-Muenchen.DE
URL: http://www.physik.uni-muenchen.de/~k2/

In a world without Walls and Fences, who needs Windows and Gates
