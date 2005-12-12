Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVLLMoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVLLMoa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 07:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVLLMoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 07:44:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:805 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751182AbVLLMo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 07:44:29 -0500
Date: Mon, 12 Dec 2005 13:45:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [DOC PATCH] block/stat.txt
Message-ID: <20051212124553.GW26185@suse.de>
References: <20051211010339.GA26568@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211010339.GA26568@hexapodia.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10 2005, Andy Isaacson wrote:
> I couldn't find any docs explaining the contents of
> /sys/block/<dev>/stat, so I wrote up the following.  I'm not completely
> sure it's accurate - Jens, could you give a yea or nay on this?
> 
> In particular, the counts of read/write IOs and read/write sectors are
> incremented in different places - it looks like they both increment as
> the request is being finished, but I'm not completely sure of that.

Overall it looks very nice, you basically all of it right. And thanks
for doing it btw, it's a good addition to the documentation. A few small
comments follows:


> +Name            units         description
> +----            -----         -----------
> +read I/Os       requests      number of read I/Os processed
> +read merges     requests      number of read I/Os merged with in-queue I/O
> +read sectors    blocks        number of sectors read

The unit here should just read 'sectors', blocks usually refers to a
file system block.

> +read I/Os, write I/Os
> +=====================
> +
> +These values increment when an I/O request completes.
> +
> +read merges, write merges
> +=========================
> +
> +These values increment when an I/O request is merged with an
> +already-queued I/O request.

Both correct, good!

> +read sectors, write sectors
> +===========================
> +
> +These values count the number of blocks read from or written to this
> +block device.  The "blocks" in question are the standard UNIX 512-byte
> +blocks, not any device-specific block size.  The counters are
> +incremented when the I/O completes.

These standard 512-b blocks we just call sectors in Linux.

> +in_flight
> +=========
> +
> +This value counts the number of currently-queued I/O requests.

A little confusing - it's the number of in flight io at the
driver/device end, that is after the block layer. One could read the
above as total in flight (total queued in the queue for the device),
which is a very different number.

-- 
Jens Axboe

