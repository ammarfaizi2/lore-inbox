Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131494AbQLGRFP>; Thu, 7 Dec 2000 12:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131493AbQLGRFF>; Thu, 7 Dec 2000 12:05:05 -0500
Received: from hera.cwi.nl ([192.16.191.1]:47533 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131478AbQLGREz>;
	Thu, 7 Dec 2000 12:04:55 -0500
Date: Thu, 7 Dec 2000 17:34:28 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Jan Niehusmann <jan@gondor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: attempt to access beyond end of device
Message-ID: <20001207173428.A23936@veritas.com>
In-Reply-To: <20001207165659.A1167@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001207165659.A1167@gondor.com>; from jan@gondor.com on Thu, Dec 07, 2000 at 04:56:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 04:56:59PM +0100, Jan Niehusmann wrote:
> ll_rw_blk.c: generic_make_request() contains the following code:
> 
> if (maxsector < count || maxsector - count < sector) {
> 	bh->b_state &= (1 << BH_Lock) | (1 << BH_Mapped);
> 	if (blk_size[major][MINOR(bh->b_rdev)]) {
> 
> 		/* This may well happen - the kernel calls bread()
> 		   without checking the size of the device, e.g.,
> 		   when mounting a device. */
> 		printk(KERN_INFO
> 		       "attempt to access beyond end of device\n");
> 		printk(KERN_INFO "%s: rw=%d, want=%d, limit=%d\n",
> 		       kdevname(bh->b_rdev), rw,
> 		       (sector + count)>>1,
> 		       blk_size[major][MINOR(bh->b_rdev)]);
> 	}
> 	bh->b_end_io(bh, 0);
> 	return;
> }
> 
> 
> That means that if blk_size[major][MINOR(bh->b_rdev)] == 0, the request
> is canceled but no message is printed. Shouldn't there be a warning message?

Maybe that code fragment is mine. If so, then at some point
in time I decided that the answer to your question is no.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
