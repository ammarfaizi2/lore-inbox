Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbTEDHQh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 03:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTEDHQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 03:16:36 -0400
Received: from [12.47.58.20] ([12.47.58.20]:17958 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263540AbTEDHQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 03:16:36 -0400
Date: Sun, 4 May 2003 00:30:21 -0700
From: Andrew Morton <akpm@digeo.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] how to fix is_local_disk()?
Message-Id: <20030504003021.077e8819.akpm@digeo.com>
In-Reply-To: <20030504090003.A7285@lst.de>
References: <20030504090003.A7285@lst.de>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 May 2003 07:28:57.0056 (UTC) FILETIME=[D2B70E00:01C3120E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> In drivers/char/sysrq.c we have this nice piece of code:
> 

Suggest you chainsaw the whole lot and simply do a wakeup_bdflush(0) from
interrupt context.

The only functional change I can see with this is that it could cause pdflush
to get stuck if there are dead NFS/SMBFS/etc mounts.

But if that happens, we need to fix it anyway.  Those filesystems should
avoid getting stuck if called with writeback_control.sync_mode != WB_SYNC_ALL,
especially if current_is_pdflush() returns true.

