Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131789AbRBAVTN>; Thu, 1 Feb 2001 16:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131873AbRBAVTD>; Thu, 1 Feb 2001 16:19:03 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:11278 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S131789AbRBAVS4>; Thu, 1 Feb 2001 16:18:56 -0500
Message-Id: <200102012117.f11LHiF21938@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Steve Lord <lord@sgi.com>, "Stephen C . Tweedie" <sct@redhat.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains 
In-Reply-To: Message from Christoph Hellwig <hch@caldera.de> 
   of "Thu, 01 Feb 2001 21:59:24 +0100." <20010201215924.A17509@caldera.de> 
Date: Thu, 01 Feb 2001 15:17:44 -0600
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Feb 01, 2001 at 02:56:47PM -0600, Steve Lord wrote:
> > And if you are writing to a striped volume via a filesystem which can do
> > it's own I/O clustering, e.g. I throw 500 pages at LVM in one go and LVM
> > is striped on 64K boundaries.
> 
> But usually I want to have pages 0-63, 128-191, etc together, because they ar
> e
> contingous on disk, or?

I was just giving an example of how kiobufs might need splitting up more often
than you think, crossing a stripe boundary is one obvious case. Yes you do
want to keep the pages which are contiguous on disk together, but you will
often get requests which cover multiple stripes, otherwise you don't really
get much out of stripes and may as well just concatenate drives.

Ideally the file is striped across the various disks in the volume, and one
large write (direct or from the cache) gets scattered across the disks. All
the I/O's run in parallel (and on different controllers if you have the 
budget).

Steve

> 
> 	Christoph
> 
> -- 
> Of course it doesn't work. We've performed a software upgrade.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
