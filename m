Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWELXFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWELXFI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWELXFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:05:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10717 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751184AbWELXFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:05:05 -0400
Date: Fri, 12 May 2006 16:04:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Erik Mouw <erik@harddisk-recovery.com>, Or Gerlitz <or.gerlitz@gmail.com>,
       linux-scsi@vger.kernel.org, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
In-Reply-To: <20060512225101.GU27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0605121559490.3866@g5.osdl.org>
References: <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com>
 <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org>
 <20060512203416.GA17120@flint.arm.linux.org.uk> <20060512214354.GP27946@ftp.linux.org.uk>
 <20060512215520.GH17120@flint.arm.linux.org.uk> <20060512220807.GR27946@ftp.linux.org.uk>
 <Pine.LNX.4.64.0605121519420.3866@g5.osdl.org> <20060512222816.GS27946@ftp.linux.org.uk>
 <20060512224804.GT27946@ftp.linux.org.uk> <20060512225101.GU27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, Al Viro wrote:
> 
> PS: it _is_ OK to trigger than puppy from add_disk()/del_gendisk() and in
> between.  I'm not sure if anyone needs it for anything, though.  Triggering
> it from bdev_uevent() is definitely bogus.

Wouldn't it be perfectly ok if we just made sure to keep the disk device 
refcount elevated by the _mount_?

Ie Russell's patch to elevate it around everything didn't work, but 
elevating the bdev->bd_disk reference count by a mount, and dropping it on 
umount (after doing the umount event) should be ok. No?

		Linus
