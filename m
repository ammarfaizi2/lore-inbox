Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130042AbRBASZA>; Thu, 1 Feb 2001 13:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130291AbRBASYv>; Thu, 1 Feb 2001 13:24:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1040 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130042AbRBASYj>; Thu, 1 Feb 2001 13:24:39 -0500
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
To: hch@caldera.de (Christoph Hellwig)
Date: Thu, 1 Feb 2001 18:25:16 +0000 (GMT)
Cc: sct@redhat.com (Stephen C. Tweedie), bsuparna@in.ibm.com,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <20010201191403.B448@caldera.de> from "Christoph Hellwig" at Feb 01, 2001 07:14:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OOQ2-0004nq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> array_len, io_count, the presence of wait_queue AND end_io, and the lack of
> scatter gather in one kiobuf struct (you always need an array), and AFAICS
> that is what the networking guys dislike.

You need a completion pointer. Its arguable whether you want the wait_queue
in the default structure or as part of whatever its contained in and handled
by the completion pointer.

And I've actually bothered to talk to the networking people and they dont have
a problem with the completion pointer.

> Now one could say: just let the networkers use their own kind of buffers
> (and that's exactly what is done in the zerocopy patches), but that again leds
> to inefficient buffer passing and ungeneric IO handling.

Careful.  This is the line of reasoning which also says

Aeroplanes are good for travelling long distances
Cars are better for getting to my front door
Therefore everyone should drive a 747 home

It is quite possible that the right thing to do is to do conversions in the
cases it happens. That might seem a good reason for having offset/length
pairs on each block, because streaming from the network to disk you may well
get a collection of partial pages of data you need to write to disk. 
Unfortunately the reality of DMA support on almost (but not quite) all
disk controllers is that you don't get that degree of scatter gather.

My I2O controllers and I think the fusion controllers could indeed benefit
and cope with being given a pile of randomly located 1480 byte chunks of 
data and being asked to put them on disk.

I do seriously doubt there are any real world situations this is useful.




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
