Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVCSB1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVCSB1P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 20:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVCSB1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 20:27:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:60326 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262385AbVCSB1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 20:27:04 -0500
Date: Fri, 18 Mar 2005 17:26:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.11-mm3] umount: Scheduling while atomic
Message-Id: <20050318172649.56480a4e.akpm@osdl.org>
In-Reply-To: <200503190127.54669@zodiac.zodiac.dnsalias.org>
References: <200503190127.54669@zodiac.zodiac.dnsalias.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Gran <alex@zodiac.dnsalias.org> wrote:
>
> while umounting an ext2 partition on a usb hdd I'm getting:
>  scheduling while atomic: umount/0x10000001/14941
>   [<c0451392>] schedule+0x5f2/0x600
>   [<c0451cc7>] cond_resched+0x27/0x40
>   [<c0140af1>] invalidate_mapping_pages+0x81/0xe0
>   [<c015b27d>] kill_bdev+0xd/0x20
>   [<c015b315>] __set_blocksize+0x85/0xa0
>   [<c015bba0>] __bd_release+0x70/0x80
>   [<c015c458>] __close_bdev_excl+0x8/0x10
>   [<c015a100>] deactivate_super+0x50/0x80
>   [<c016f82b>] sys_umount+0x3b/0x90
>   [<c0148c20>] do_munmap+0x120/0x150
>   [<c016f895>] sys_oldumount+0x15/0x20
>   [<c010300b>] sysenter_past_esp+0x54/0x75

hm, yes, that was a bug in blockdev-fixes-race-between-mount-umount.patch,
but that patch got dropped because Linus fixed things differently.

