Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTKXUGo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 15:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTKXUGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 15:06:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:47785 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263861AbTKXUGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 15:06:40 -0500
Date: Mon, 24 Nov 2003 12:07:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk contents lost with 2.6
Message-Id: <20031124120714.75aa91fd.akpm@osdl.org>
In-Reply-To: <20031124174934.GA32112@suse.de>
References: <20031124174934.GA32112@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> wrote:
>
> Good morning,
> 
> is it only me or is the file really gone with 2.6?
> 
> umount -v /mnt
> /sbin/mkfs.ext2 /dev/ram3
> mount -v /dev/ram3 /mnt
> cp /etc/hosts /mnt
> sync
> umount -v /mnt
> mount -v /dev/ram3 /mnt
> ls -l /mnt/hosts
> umount -v /mnt
> 
> 
> works ok with 2.4.
> 

Yup.  Because the kernel considers the ramdisk as being "memory backed" it
doesn't do writeback into the blockdev pagecache.  If you remove the
memory-backed flag, ramdisk contributes to dirty memory in undesirable
ways.  That memory-backed flag is too overloaded and needs to be split up.

It's something I need to fix, but nobody seemed to be hurting from it up to
now so I figured it could wait until after 2.6.0.

