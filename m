Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRBBLwW>; Fri, 2 Feb 2001 06:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbRBBLwM>; Fri, 2 Feb 2001 06:52:12 -0500
Received: from ns.caldera.de ([212.34.180.1]:14605 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129460AbRBBLwE>;
	Fri, 2 Feb 2001 06:52:04 -0500
Date: Fri, 2 Feb 2001 12:51:35 +0100
From: Christoph Hellwig <hch@caldera.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: bsuparna@in.ibm.com, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010202125135.A12245@caldera.de>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	bsuparna@in.ibm.com, linux-kernel@vger.kernel.org,
	kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <20010201193221.D11607@redhat.com> <200102012046.VAA16746@ns.caldera.de> <20010201212508.G11607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010201212508.G11607@redhat.com>; from sct@redhat.com on Thu, Feb 01, 2001 at 09:25:08PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 09:25:08PM +0000, Stephen C. Tweedie wrote:
> > No.  Just allow passing the multiple of the devices blocksize over
> > ll_rw_block.
> 
> That was just one example: you need the sub-ios just as much when
> you split up an IO over stripe boundaries in LVM or raid0, for
> example.

IIRC that's why you designed (and I thought of independandly) clone-kiobufs.

> Secondly, ll_rw_block needs to die anyway: you can expand
> the blocksize up to PAGE_SIZE but not beyond, whereas something like
> ll_rw_kiobuf can submit a much larger IO atomically (and we have
> devices which don't start to deliver good throughput until you use
> IO sizes of 1MB or more).

Completly agreed.

> If I've got a vector (page X, offset 0, length PAGE_SIZE) and I want
> to split it in two, I have to make two new vectors (page X, offset 0,
> length n) and (page X, offset n, length PAGE_SIZE-n).  That implies
> copying both vectors.
> 
> If I have a page vector with a single offset/length pair, I can build
> a new header with the same vector and modified offset/length to split
> the vector in two without copying it.

You just say in the higher-level structure ignore from x to y even if
they have an offset in their own vector.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
