Return-Path: <linux-kernel-owner+w=401wt.eu-S1753864AbWLWXoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbWLWXoG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 18:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753932AbWLWXoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 18:44:06 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37087 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753864AbWLWXoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 18:44:05 -0500
Date: Sun, 24 Dec 2006 00:43:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Cc: marcel@holtmann.org, maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: ext3-related crash in 2.6.20-rc1
Message-ID: <20061223234305.GA1809@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I got this nasty oops while playing with debugger. Not sure if that is
related; it also might be something with bluetooth; I already know it
corrupts memory during suspend, perhaps it corrupts memory in some
error path?

 

								Pavel


l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
PM: Removing info for bluetooth:acl00803715A329
e1000: eth0: e1000_watchdog: NIC Link is Down
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
e1000: eth0: e1000_watchdog: NIC Link is Down
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
------------[ cut here ]------------
kernel BUG at fs/buffer.c:1235!
invalid opcode: 0000 [#1]
SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c01933c2>]    Not tainted VLI
EFLAGS: 00010046   (2.6.20-rc1 #379)
EIP is at __find_get_block+0x1b2/0x1c0
eax: 00000086   ebx: 00001000   ecx: 00000000   edx: 006780b2
esi: 0033d60d   edi: 00001000   ebp: 000000cf   esp: c9135c90
ds: 007b   es: 007b   ss: 0068
Process phone (pid: 1161, ti=c9134000 task=f7949030 task.ti=c9134000)
Stack: 006780b2 00000000 f7ec2820 00000003 ad40ad40 f7d8f5ba c0652a48 00000000 
       f88da000 00000012 0000000f f65c9000 f65c9230 c016c9df c016c3c4 00001000 
       0033d60d 00001000 000000cf c01933ef 00001000 5a0ff380 0000007f f65c9234 
Call Trace:
 [<c01933ef>] __getblk+0x1f/0x290
 [<c01db680>] __ext3_get_inode_loc+0x120/0x3a0
 [<c01db9d7>] ext3_reserve_inode_write+0x27/0x80
 [<c01dbe1a>] ext3_mark_inode_dirty+0x1a/0x40
 [<c01dc2c9>] ext3_dirty_inode+0x79/0xb0
 [<c018c854>] __mark_inode_dirty+0x34/0x1c0
 [<c0154934>] __generic_file_aio_write_nolock+0x244/0x590
 [<c0154cd9>] generic_file_aio_write+0x59/0xd0
 [<c01da050>] ext3_file_write+0x30/0xc0
 [<c0170ad7>] do_sync_write+0xc7/0x130
 [<c0171266>] vfs_write+0xa6/0x160
 [<c0171b21>] sys_write+0x41/0x70
 [<c010304c>] syscall_call+0x7/0xb
 [<b7f18d2e>] 0xb7f18d2e
 =======================
Code: 00 8b 7c 24 18 f3 a5 fb 8b 44 24 10 85 c0 0f 84 2c ff ff ff 8b 44 24 10 e8 5c ca ff ff e9 1e ff ff ff 89 d8 e8 50 ca ff ff eb 8d <0f> 0b eb fe 0f 0b eb fe 0f 0b eb fe 89 f6 55 57 56 53 83 ec 48 
EIP: [<c01933c2>] __find_get_block+0x1b2/0x1c0 SS:ESP 0068:c9135c90
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
