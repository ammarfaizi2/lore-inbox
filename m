Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUHBQ76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUHBQ76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUHBQ76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:59:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:44210 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264550AbUHBQ7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:59:44 -0400
Date: Mon, 2 Aug 2004 09:57:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch for review] BSD accounting IO stats
Message-Id: <20040802095742.0c62bea8.akpm@osdl.org>
In-Reply-To: <410E26FC.208@bull.net>
References: <410E26FC.208@bull.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
>
> diff -uprN -X dontdiff linux-2.6.8-rc2/drivers/block/ll_rw_blk.c linux-2.6.8-rc2+BSDacct_IO/drivers/block/ll_rw_blk.c
>  --- linux-2.6.8-rc2/drivers/block/ll_rw_blk.c	2004-07-18 06:57:42.000000000 +0200
>  +++ linux-2.6.8-rc2+BSDacct_IO/drivers/block/ll_rw_blk.c	2004-07-27 09:17:33.149321480 +0200
>  @@ -1949,10 +1949,12 @@ void drive_stat_acct(struct request *rq,
>   
>   	if (rw == READ) {
>   		disk_stat_add(rq->rq_disk, read_sectors, nr_sectors);
>  +		current->rblk += nr_sectors;
>   		if (!new_io)
>   			disk_stat_inc(rq->rq_disk, read_merges);
>   	} else if (rw == WRITE) {
>   		disk_stat_add(rq->rq_disk, write_sectors, nr_sectors);
>  +		current->wblk += nr_sectors;
>   		if (!new_io)
>   			disk_stat_inc(rq->rq_disk, write_merges);
>   	}

The `wblk' accounting will be quite wrong - most writes will be accounted
to pdflush, kjournald, etc.
