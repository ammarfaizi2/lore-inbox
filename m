Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272739AbTHPK4Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 06:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272741AbTHPK4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 06:56:24 -0400
Received: from Sina.Sharif.EDU ([81.31.160.35]:53646 "EHLO sina.sharif.edu")
	by vger.kernel.org with ESMTP id S272739AbTHPK4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 06:56:22 -0400
Date: Sat, 16 Aug 2003 15:31:40 +0430 (IRST)
From: Behdad Esfahbod <behdad@bamdad.org>
To: linux-kernel@vger.kernel.org
Subject: devfs oops on module missing
Message-ID: <Pine.LNX.4.44.0308161011570.30273-100000@gilas.bamdad.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With 2.6.0-test3 and 2.6.0-test2, devfs mounting at boot time, 
devfsd 1.3.25 installed, no floppy drive, so floppy,ko would 
reject to load.  On boot time got this:

modprobe: FATAL: Error inserting floppy 
(/lib/modules/2.6.0-test3/kernel/drivers/block/floppy.ko): No such device

devfs_put(f7498780): poisoned pointer
------------[ cut here ]------------
kernel BUG at fs/devfs/base.c:922!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c01a2c68>]
EFLAGS: 00010286
EIP is at devfs_put+0xf8/0x105
eax: 0000000d   ebx: f7498780   ecx: c033c430   edx: 00000286
esi: c03420c0   edi: f7498780   ebp: 00000000   esp: f78fbec8
ds: 007b   es: 007b   ss: 0068
Process devfsd (pid: 18, thredinfo=f78fa000 task=f79d0c80)
Stack: c02fbac4 c02e6ece f7498780 00000000 c01a5772 f7498780 f7d0f41f 00000001
       f7d0f000 f791d4c8 00000082 f78fa000 c03420e8 f78b0800 f7498780 00000021
       00000000 00000021 00000000 000003ff 00000000 00000000 00000001 00000000
Call Trace:
 [<c01a5772>] devfsd_read+0x31f/0x4c4
 [<c011f68c>] default_wake_function+0x0/0x2e
 [<c011f68c>] default_wake_function+0x0/0x2e
 [<c0158ebe>] vfs_read+0xbc/0x127
 [<c011f434>] schedule+0x1b6/ox3be
 [<c0159149>] sus_read+0x42/0x63
 [<c01091b9>] sysenter_past_esp+0x52/0x71

Code: 0f 0b 9a 03 d2 ba 2f c0 e9 1b ff ff ff 55 57 56 53 83 ec 10



Removing the floppy.ko, well, solved this problem.

