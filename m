Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143796AbRAHPiP>; Mon, 8 Jan 2001 10:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143992AbRAHPiF>; Mon, 8 Jan 2001 10:38:05 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:52484 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S143796AbRAHPhv>; Mon, 8 Jan 2001 10:37:51 -0500
Date: Mon, 08 Jan 2001 10:37:38 -0500
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@redhat.com>
cc: Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <52950000.978968258@tiny>
In-Reply-To: <Pine.GSO.4.21.0101080855120.4061-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, January 08, 2001 09:02:46 AM -0500 Alexander Viro
<viro@math.psu.edu> wrote:

> Alan, consider applying the patch below.
> Contents:
[snip]
> +	do {
> +		if (buffer_mapped(bh)) {
> +			bh->b_end_io = end_buffer_io_async;
> +			atomic_inc(&bh->b_count);
> +			set_bit(BH_Uptodate, &bh->b_state);
> +			set_bit(BH_Dirty, &bh->b_state);
> +			submit_bh(WRITE, bh);
> +		}
> +		bh = bh->b_this_page;
> +	}
          ^^^^^^^^^^^^^

This doesn't look right...

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
