Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285015AbRLKMhS>; Tue, 11 Dec 2001 07:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285014AbRLKMhL>; Tue, 11 Dec 2001 07:37:11 -0500
Received: from mail012.syd.optusnet.com.au ([203.2.75.172]:55247 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S285015AbRLKMg4>; Tue, 11 Dec 2001 07:36:56 -0500
Date: Tue, 11 Dec 2001 23:36:18 +1100
From: Andrew Clausen <clausen@gnu.org>
To: Christoph Hellwig <hch@caldera.de>, Kevin Corry <corryk@us.ibm.com>,
        evms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: gendisk list access (was: [Evms-devel] Unresolved symbols)
Message-ID: <20011211233618.B982@gnu.org>
In-Reply-To: <OFCE7B6713.9A6E1AF1-ON85256B02.004FB1C4@raleigh.ibm.com> <20011112173217.A3404@caldera.de> <01120514525902.13647@boiler> <20011205225346.A7313@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011205225346.A7313@caldera.de>; from hch@caldera.de on Wed, Dec 05, 2001 at 10:53:46PM +0100
X-Accept-Language: en,pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 10:53:46PM +0100, Christoph Hellwig wrote:
>  - each block queue gets a pointer to be used for partitioning, this will
>    be opaque to the drivers.

Yuck!

Why do you want a reference to partitions?

IMHO: the whole major/minor thing is butt ugly for partitions.

Of course, I have no intention of implementing this, but I think:

* there should be an IDE major, and a SCSI major, etc.
(or perhaps just a hard disk major?  it's rather ugly exposing
the difference, but at times useful)

* so, if the IDE major was 2, then major2/minor0 is the first hard
disk, major2/minor1 the second, etc...

* partition tables get the same interface as LVM.  (partition tables
are really like VGs, that only permit one PV)

Actually, it's really already implemented (!).  Just use LVM2.
It would be trivial for me to get parted to tell LVM2 to recognize
partition tables.  (and also trivial, but slightly more painful,
to port the existing ptables in the kernel)

Also, this is 100% compatible with corry's desire to "let EVMS
handle it".

Andrew

PS sorry for the delay.  My server died a few hours before I left for
Brazil...
