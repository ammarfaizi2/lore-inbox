Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVJaJfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVJaJfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 04:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVJaJfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 04:35:31 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:47302 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932362AbVJaJfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 04:35:22 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.14: Oops in iput, from prune_dcache, during umount on system shutdown (bttv?)
Date: Mon, 31 Oct 2005 10:35:16 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510311035.16605.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux version 2.6.14 (root@baldrick) (gcc version 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)) #1 Sun Oct 30 12:30:39 CET 2005
x86

This is the second time I've had this problem; I don't know if it
is significant, but each time I'd been watching tv using the
bttv drivers.

I had to copy this off the screen, and some had scrolled off:

EIP: 0060:[<c0178df9>] Not tainted VLI
EFLAGS: 00010206 (2.6.14)
EIP is at iput+0x19/0x80
eax: 06f5f000	ebx: c717a090	ecx: c717a0a8	edx: c717a0a8
esi: c717a090	edi: 000003e4	ebp: 000027bf	esp: dbe37edc
ds: 007b	es: 007b	ss: 0068

Process umount (pid: 14441, threadinfo=dbe36000, task=dc307540)
Stack: c71776f4   c7176888   c717bb30   ...
Call trace:
c017634e   prune_dcache+0x13e/0x170
c0176638   shrink_dcache_parent+0x18/0x30
c01643a7   generic_shutdown_super+0x27/0x120
00164f5d   kill_block_super+0x2d/0x50
c01642d7   deactivate_super+0x67/0x90
c017b08f   sys_umount+0x36/0xa0
c017b107   sys_oldumount+0x17/0x20
c010304b   sysenter_past_esp+0x54/0x75
Code: ff ff 89 44 24 04 e9 97 fe ff ff 8d ...
/etc/rc0.d/S40umountfs: line 21: 14441 Segmentation fault
umount -tnoproc, noprocfs, nodevfs, nosysfs, nousbfs, nousbdevfs, nodevpts -d -a -r
