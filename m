Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSFME4h>; Thu, 13 Jun 2002 00:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316644AbSFME4g>; Thu, 13 Jun 2002 00:56:36 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:28341 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S313698AbSFME4g>; Thu, 13 Jun 2002 00:56:36 -0400
Date: Wed, 12 Jun 2002 21:57:52 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
To: Oliver Neukum <oliver@neukum.name>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Message-id: <3D082650.6020702@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
In-Reply-To: <20020611.202553.28822742.davem@redhat.com>
 <52zny049r7.fsf@topspin.com> <3D079D44.4000701@pacbell.net>
 <200206122158.55375.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>That'd certainly be a better approach for supporting sglist in the
>>usb-storage code than the alternatives I've heard so far.
>
> Could you elaborate ? This sounds interesting.

It's been discussed on linux-usb-devel more than once.

It's really a secondary or tertiary consideration.  The top
performance issue for usb-storage in USB 2.0 is that it doesn't
yet use bulk queueing for its requests ... which means that it
wastes at least half the bandwidth available to it (staying in
the low tens of MByte/sec vs twenties or even higher). [*]

The sglist issue is a "how to create fewer DMA mappings" issue.
There are specific sglist DMA mapping calls, but they can't
be used without adding to the usbcore API ... either sglist,
usable only by usb-storage AFAICT, or something more general
like dma_addr_t.

In any case it's an optimization issue that doesn't seem like it
should be at the front of anyone's list for some time.

- Dave

[*] Yes, patches have been available to fix it.  Not updated
     after the block I/O changes in 2.5, but not hard to do so.

     Worth updating and integrating after the HCD stuff settles
     down so we can make sure that all three major HCDs do the
     bulk queuing correctly in both success and failure paths.

