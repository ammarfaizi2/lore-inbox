Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279286AbRJWGmh>; Tue, 23 Oct 2001 02:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279285AbRJWGm1>; Tue, 23 Oct 2001 02:42:27 -0400
Received: from fe010.worldonline.dk ([212.54.64.195]:3079 "HELO
	fe010.worldonline.dk") by vger.kernel.org with SMTP
	id <S279284AbRJWGmM>; Tue, 23 Oct 2001 02:42:12 -0400
Date: Tue, 23 Oct 2001 08:42:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Shailabh Nagar <nagar@us.ibm.com>
Cc: Reto Baettig <baettig@scs.ch>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Preliminary results of using multiblock raw I/O
Message-ID: <20011023084238.C638@suse.de>
In-Reply-To: <OFFAE32CC3.4ECEDDFD-ON85256AED.005F4B1F@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFFAE32CC3.4ECEDDFD-ON85256AED.005F4B1F@pok.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22 2001, Shailabh Nagar wrote:
> 
> 
> Unlike the SGI patch, the multiple block size patch continues to use buffer
> heads. So the biggest atomic transfer request that can be seen by a device
> driver with the multiblocksize patch is still 1 page.

Not so. Given a 1MB contigious request broken into 256 pages, even if
submitted in these chunks it will be merged into the biggest possible
request the lower level driver can handle. This is typically 127kB, for
SCSI it can be as much as 512kB currently and depending on the SCSI
driver even more maybe.

I haven't seen the SGI rawio patch, but I'm assuming it used kiobufs to
pass a single unit of 1 meg down at the time. Yes currently we do incur
significant overhead compared to that approach.

> Getting bigger transfers would require a single buffer head to be able to
> point to a multipage buffer or not use buffer heads at all.
> The former would obviously be a major change and suitable only for 2.5
> (perhaps as part of the much-awaited rewrite of the block I/O

Ongoing effort.

> subsystem).The use of multipage transfers using a single buffer head would
> also help non-raw I/O transfers. I don't know if anyone is working along
> those lines.

It is being worked on.

-- 
Jens Axboe

