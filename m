Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263825AbTEOHnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 03:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263863AbTEOHnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 03:43:05 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:6108 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263825AbTEOHnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 03:43:04 -0400
Date: Thu, 15 May 2003 00:57:18 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: disk corruption in 2.5.66-bk5 - 2.5.69
Message-Id: <20030515005718.7cc41827.akpm@digeo.com>
In-Reply-To: <200305150258.h4F2wbR27255@freya.yggdrasil.com>
References: <200305150258.h4F2wbR27255@freya.yggdrasil.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 07:55:49.0233 (UTC) FILETIME=[6630FE10:01C31AB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> wrote:
>
> 	linux-2.5.66-bk5 changed blkdev_put in fs/block_dev.c
>  to only call sync_blockdev if bdev->bd_openers drops to zero.
>  For me, this has resulted in disk corruption when lilo runs
>  under kernels 2.5.66-bk5 through 2.5.69, even if I run
>  "sync" repeatedly after running lilo.

Works OK here with a simple test:

	sleep 10000 < /dev/hda5 &
	cat < some-file > /dev/hda5
	sync
	<press reset>
	cmp some-file /dev/hda5

LILO does a global sync itself before quitting.  Check to see if there's a
lot of writeout happening.  See if there's writeout happening when you run
sync manually.

Maybe take a copy of /dev/hda1 into a regular file, then reboot, then
compare with what's on the disk.

Check that /proc/meminfo:Dirty goes to zero after `sync'.


