Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVCVJH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVCVJH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVCVJEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:04:50 -0500
Received: from mail.dif.dk ([193.138.115.101]:65182 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262580AbVCVJES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 04:04:18 -0500
Date: Tue, 22 Mar 2005 10:05:59 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexander Gran <alex@zodiac.dnsalias.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.11-mm3] umount: Scheduling while atomic
In-Reply-To: <20050318172649.56480a4e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0503220956240.2495@dragon.hyggekrogen.localhost>
References: <200503190127.54669@zodiac.zodiac.dnsalias.org>
 <20050318172649.56480a4e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005, Andrew Morton wrote:

> Alexander Gran <alex@zodiac.dnsalias.org> wrote:
> >
> > while umounting an ext2 partition on a usb hdd I'm getting:
> >  scheduling while atomic: umount/0x10000001/14941
> >   [<c0451392>] schedule+0x5f2/0x600
> >   [<c0451cc7>] cond_resched+0x27/0x40
> >   [<c0140af1>] invalidate_mapping_pages+0x81/0xe0
> >   [<c015b27d>] kill_bdev+0xd/0x20
> >   [<c015b315>] __set_blocksize+0x85/0xa0
> >   [<c015bba0>] __bd_release+0x70/0x80
> >   [<c015c458>] __close_bdev_excl+0x8/0x10
> >   [<c015a100>] deactivate_super+0x50/0x80
> >   [<c016f82b>] sys_umount+0x3b/0x90
> >   [<c0148c20>] do_munmap+0x120/0x150
> >   [<c016f895>] sys_oldumount+0x15/0x20
> >   [<c010300b>] sysenter_past_esp+0x54/0x75
> 
> hm, yes, that was a bug in blockdev-fixes-race-between-mount-umount.patch,
> but that patch got dropped because Linus fixed things differently.
> 
I just got a similar one when shutting down my box with 2.6.11-mm4, 
rebooted it a few times, and it seems to happen 1 in 4 times.  last few 
messages during shutdown are here :  

Turning off swap.
Unmounting local file systems.
Scheduling while atomic: umount/0x10000001/12240
[<c0103997>] dump_stack+0x17/0x20
[<c02dd927>] schedule+0x587/0x650
[<c02de3fa>] cond_resched+0x2a/0x50
[<c014283a>] invalidate_mapping_pages+0xda/0xe0
[<c015d7e0>] kill_bdev+0x10/0x30
[<c015d885>] __set_blocksize+0x85/0xb0
[<c015e1c2>] __bd_release+0x62/0x70
[<c015eaeb>] __close_bdev_excl+0xb/0x14
[<c015c487>] deactivate_super+0x67/0x90
[<c01730a7>] sys_umount+0x37/0x80
[<c0173109>] sys_oldumount+0x19/0x20
[<c0102b15>] syscall_call+0x7/0xb
Remounting root filesystem read-only.
Synchronizing SCSI cache for disk sda:
Power down.


Now I'm of to try and see if 2.6.12-rc1-mm1 still does this.


-- 
Jesper Juhl


