Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129988AbQJaBIn>; Mon, 30 Oct 2000 20:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129993AbQJaBId>; Mon, 30 Oct 2000 20:08:33 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:30213 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129988AbQJaBIZ>; Mon, 30 Oct 2000 20:08:25 -0500
Date: Tue, 31 Oct 2000 02:08:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Al Peat <al_kernel@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard_sector / hard_nr_sectors
Message-ID: <20001031020818.A29519@athlon.random>
In-Reply-To: <20001030185639.93318.qmail@web10105.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001030185639.93318.qmail@web10105.mail.yahoo.com>; from al_kernel@yahoo.com on Mon, Oct 30, 2000 at 10:56:39AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 10:56:39AM -0800, Al Peat wrote:
>   I was wondering if someone could give me a quick
> overview of the differences between sector/nr_sectors
> and hard_sector/hard_nr_sectors in blk_dev.h's request
> structure, or point me to some
> documentation/discussion on this?

The reason hard_nr_sectors is been introduced is that it allows all device
drivers to handle merged I/O requests transparently. In 2.4.x we do merging at
the highlevel layer unconditionally and so it was necessary to avoid breakage
of lowlevel drivers.

This way device drivers can limit themself to look at
current_request->buffer/current_nr_sectors/sector... and to call end_request(1)
once the I/O is completed (end_that_request_first will take care of updating
current->sector/nr_sector for the next pass of the request_fn without the need
of ugly changes to the lowlevel drivers).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
