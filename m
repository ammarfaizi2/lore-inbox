Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266537AbSL2Lcc>; Sun, 29 Dec 2002 06:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbSL2Lcc>; Sun, 29 Dec 2002 06:32:32 -0500
Received: from omega.deltanet.ro ([193.231.96.6]:28302 "HELO
	brucan.deltanet.ro") by vger.kernel.org with SMTP
	id <S266537AbSL2Lcb>; Sun, 29 Dec 2002 06:32:31 -0500
Date: Sun, 29 Dec 2002 13:40:48 +0200
From: Petru Paler <petru@paler.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.53: VFS: brelse: Trying to free free buffer
Message-ID: <20021229114048.GA334@atwa>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this in the syslog today:

VFS: brelse: Trying to free free buffer
buffer layer error at fs/buffer.c:1182
Call Trace:
 [<c014c345>] __brelse+0x35/0x40
 [<c0180efe>] ext3_htree_fill_tree+0x14e/0x240
 [<c017a809>] ext3_dx_readdir+0x99/0x1e0
 [<c015b390>] filldir64+0x0/0xf0
 [<c017a3f5>] ext3_readdir+0x465/0x490
 [<c015b390>] filldir64+0x0/0xf0
 [<c01d5258>] __blk_put_request+0xd8/0x110
 [<c01d320f>] elv_queue_empty+0x1f/0x30
 [<c01e8d8c>] choose_drive+0x1c/0x190
 [<c01e844a>] ide_do_request+0x3a/0x290
 [<c015b0ca>] vfs_readdir+0x8a/0x90
 [<c015b390>] filldir64+0x0/0xf0
 [<c015b505>] sys_getdents64+0x85/0xc4
 [<c015b390>] filldir64+0x0/0xf0
 [<c010b598>] do_IRQ+0xd8/0x160
 [<c01094e3>] syscall_call+0x7/0xb

Kernel is 2.5.53 (pulled from bk, so it might have a changeset or two
applied after 2.5.53) compiled with all debug options enabled. The
filesystem is on an IDE drive, ext3 with htree enabled. I'm not very
sure how the error came up, I think it was during copying something from
a CD-ROM. Do let me know if there is any other info I should provide.


Petru
