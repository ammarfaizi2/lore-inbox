Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266469AbUHBMoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266469AbUHBMoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 08:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUHBMoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 08:44:18 -0400
Received: from zero.aec.at ([193.170.194.10]:57868 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266469AbUHBMoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 08:44:09 -0400
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch for review] BSD accounting IO stats
References: <2oJkL-4sl-41@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 02 Aug 2004 14:44:03 +0200
In-Reply-To: <2oJkL-4sl-41@gated-at.bofh.it> (Guillaume Thouvenin's message
 of "Mon, 02 Aug 2004 13:40:11 +0200")
Message-ID: <m3r7qpsoa4.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin <guillaume.thouvenin@bull.net> writes:

> diff -uprN -X dontdiff linux-2.6.8-rc2/drivers/block/ll_rw_blk.c linux-2.6.8-rc2+BSDacct_IO/drivers/block/ll_rw_blk.c
> --- linux-2.6.8-rc2/drivers/block/ll_rw_blk.c	2004-07-18 06:57:42.000000000 +0200
> +++ linux-2.6.8-rc2+BSDacct_IO/drivers/block/ll_rw_blk.c	2004-07-27 09:17:33.149321480 +0200
> @@ -1949,10 +1949,12 @@ void drive_stat_acct(struct request *rq,
>  
>  	if (rw == READ) {
>  		disk_stat_add(rq->rq_disk, read_sectors, nr_sectors);
> +		current->rblk += nr_sectors;

This doesn't look very useful, because most writes which
are flushed delayed would get accounted to pdflushd.
Using such inaccurate data for accounting sounds quite dangerous
to me.

If you really wanted to do this i guess you would need to 
track the pid of the process and account it there. But the
process may be already gone, so it would better fit into
some other longer lived data structure (like the uid) 

Overall I don't think this accounting is worth it because
doing it right would be quite some overhead and doing it in
a simple way like this patch is too inaccurate.

-Andi

