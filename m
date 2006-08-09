Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWHIUBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWHIUBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWHIUBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:01:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751324AbWHIUBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:01:53 -0400
Date: Wed, 9 Aug 2006 13:01:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 - ext3 locking issue?
Message-Id: <20060809130151.f1ff09eb.akpm@osdl.org>
In-Reply-To: <200608091906.k79J6Zrc009211@turing-police.cc.vt.edu>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<200608091906.k79J6Zrc009211@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2006 15:06:35 -0400
Valdis.Kletnieks@vt.edu wrote:

> On Sun, 06 Aug 2006 03:08:09 PDT, Andrew Morton said:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> 
> Yum managed to get wedged: 'echo t > /proc/sysrq-trigger' says:
> 
> [ 4514.840000] yum           D D5C32AA0     0  4747   4430                     (NOTLB)
> [ 4514.840000]        d5c3dda4 d5c3dd78 00000007 d5c32aa0 bd3ddd00 00000338 00000000 d5c32bc0
> [ 4514.840000]        c1601628 d5c3dd9c 64600300 0000001f d5c3ddd8 d5c3ddd8 c1601628 d5c3ddac
> [ 4514.840000]        c034fef8 d5c3ddb4 c0136e8e d5c3ddcc c0350026 c0136e58 d5c3ddd8 00000000
> [ 4514.840000] Call Trace:
> [ 4514.840000]  [<c034fef8>] io_schedule+0x25/0x44
> [ 4514.840000]  [<c0136e8e>] sync_page+0x36/0x3a
> [ 4514.840000]  [<c0350026>] __wait_on_bit_lock+0x30/0x58
> [ 4514.840000]  [<c0136e44>] __lock_page+0x51/0x59
> [ 4514.840000]  [<c013f099>] truncate_inode_pages_range+0x1de/0x230
> [ 4514.840000]  [<c013f0f7>] truncate_inode_pages+0xc/0x11
> [ 4514.840000]  [<c018ea12>] ext3_delete_inode+0x16/0xbd
> [ 4514.840000]  [<c016798f>] generic_delete_inode+0xb6/0x130
> [ 4514.840000]  [<c0167a1b>] generic_drop_inode+0x12/0x166
> [ 4514.840000]  [<c01673f1>] iput+0x67/0x6a
> [ 4514.840000]  [<c0165662>] dentry_iput+0x97/0xcc
> [ 4514.840000]  [<c016613d>] dput+0x183/0x19c
> [ 4514.840000]  [<c015f64f>] sys_renameat+0x17a/0x1d3
> [ 4514.840000]  [<c015f6ba>] sys_rename+0x12/0x14
> [ 4514.840000]  [<c0102849>] sysenter_past_esp+0x56/0x79
> 
> A careful check of the dmesg doesn't reveal anything particularly helpful,
> like an oops or other relevant kernel message.

Usually this means that there's an IO request in flight and it got lost
somewhere.  Device driver bug, IO scheduler bug, etc.  Conceivably a
lost interrupt (hardware bug, PCI setup bug, etc).

Which device driver and which IO sched are you using?
