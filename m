Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbUB0PAu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 10:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbUB0PAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 10:00:50 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:2975 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262904AbUB0PAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 10:00:20 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 27 Feb 2004 15:37:17 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: file locking BUG
Message-ID: <20040227143702.GC15205@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Got a BUG today.  Happened while playing with user-mode-linux, which
uses locks for the image files presenting the virtual hard disks.

The UML kernel complained that it can't lock the disk:

  F_SETLK failed, file already locked by pid 24612
  Failed to lock '/work/uml/yast2/harddisk.img', err = 11

There is no process (any more) with pid 24612 through.  Checked the
kernel log on the host and found the BUG message below ...

  Gerd

------------[ cut here ]------------
kernel BUG at fs/locks.c:1727!
invalid operand: 0000 [#2]
CPU:    0
EIP:    0060:[<c016049c>]    Tainted: PF 
EFLAGS: 00010246
EIP is at locks_remove_flock+0x3c/0x60
eax: f6ea7ea8   ebx: d510cc98   ecx: d510cc14   edx: 00000000
esi: f634d980   edi: d510cc14   ebp: db8dfe80   esp: e97a7f40
ds: 007b   es: 007b   ss: 0068
Process linux (pid: 24748, threadinfo=e97a6000 task=f649d210)
Stack: f634d980 f7fec700 c014f4a2 f634d980 00000000 c76c5300 00000001 c014ca63 
       00000f7f 00000009 c76c5300 c011e16f c7158880 c71588a0 f649d210 00000100 
       c011ee9a c03e1760 c7158880 e77feec0 40001000 c03e1760 00000001 00000000 
Call Trace:
 [<c014f4a2>] __fput+0x22/0x100
 [<c014ca63>] filp_close+0x43/0x70
 [<c011e16f>] put_files_struct+0x4f/0xa0
 [<c011ee9a>] do_exit+0x14a/0xa10
 [<c011f787>] do_group_exit+0x27/0x70
 [<c0108e17>] syscall_call+0x7/0xb

Code: 0f 0b bf 06 f5 fb 2f c0 eb da 5b 5e c3 89 d8 e8 d0 fd ff ff 
 nfs warning: mount version older than kernel
