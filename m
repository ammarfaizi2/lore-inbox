Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbTLJWTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 17:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTLJWTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 17:19:32 -0500
Received: from 130.146.174.203.mel.ntt.net.au ([203.174.146.130]:44674 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP id S263946AbTLJWTa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 17:19:30 -0500
To: ext3-users@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: VFS: brelse: Trying to free free buffer
From: Daniel Pittman <daniel@rimspace.net>
Date: Thu, 11 Dec 2003 09:19:23 +1100
Message-ID: <87smjsgvtg.fsf@enki.rimspace.net>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this error in my log reports this morning, from the machine I use
as my firewall.  This is the first time it has occurred, but the machine
is running a very new kernel:

Linux fendrian.rimspace.net 2.6.0-test11-fendrian #1 Wed Dec 10 22:25:59 EST 2003 i486 GNU/Linux

The kernel was up to date as per the CVS repository at that point. This
was just before the CDROM_SEND_PACKET IOCTL fix went in.


There is a single ext3 partition on the machine, and it generally
doesn't do very much at all, especially not disk intensive stuff.

Please let me know if I can provide any more assistance in finding the
source of the problem, or resolving it.

Dec 11 04:03:55 fendrian kernel: VFS: brelse: Trying to free free buffer
Dec 11 04:03:55 fendrian kernel: buffer layer error at fs/buffer.c:1279
Dec 11 04:03:55 fendrian kernel: Call Trace:
Dec 11 04:03:56 fendrian kernel:  [__brelse+41/48] __brelse+0x29/0x30
Dec 11 04:03:56 fendrian kernel:  [bh_lru_install+124/176] bh_lru_install+0x7c/0xb0
Dec 11 04:03:56 fendrian kernel:  [__find_get_block+96/160] __find_get_block+0x60/0xa0
Dec 11 04:03:56 fendrian kernel:  [__getblk_slow+24/224] __getblk_slow+0x18/0xe0
Dec 11 04:03:56 fendrian kernel:  [__getblk+42/48] __getblk+0x2a/0x30
Dec 11 04:03:56 fendrian kernel:  [ext3_getblk+123/528] ext3_getblk+0x7b/0x210
Dec 11 04:03:56 fendrian kernel:  [submit_bio+61/112] submit_bio+0x3d/0x70
Dec 11 04:03:56 fendrian kernel:  [ll_rw_block+88/128] ll_rw_block+0x58/0x80
Dec 11 04:03:56 fendrian kernel:  [ext3_find_entry+288/976] ext3_find_entry+0x120/0x3d0
Dec 11 04:03:56 fendrian kernel:  [ext3_lookup+41/160] ext3_lookup+0x29/0xa0
Dec 11 04:03:56 fendrian kernel:  [__lookup_hash+108/160] __lookup_hash+0x6c/0xa0
Dec 11 04:03:56 fendrian kernel:  [open_namei+279/992] open_namei+0x117/0x3e0
Dec 11 04:03:56 fendrian kernel:  [filp_open+46/96] filp_open+0x2e/0x60
Dec 11 04:03:56 fendrian kernel:  [sys_open+59/112] sys_open+0x3b/0x70
Dec 11 04:03:56 fendrian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 11 04:03:56 fendrian kernel: 

    Daniel

-- 
> I have no life, and I must scream.
And in response, thus spake the Oracle:
} And there we have it, modern music summed up in one tidy sentence.
