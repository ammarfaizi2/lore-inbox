Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSLYLuK>; Wed, 25 Dec 2002 06:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSLYLuK>; Wed, 25 Dec 2002 06:50:10 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:41379 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261305AbSLYLuJ>; Wed, 25 Dec 2002 06:50:09 -0500
Date: Wed, 25 Dec 2002 12:58:20 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Mikael Olenfalk <mikael@netgineers.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alot of DMA errors in 2.4.18, 2.4.20 and 2.5.52
Message-ID: <20021225115820.GB7348@louise.pinerecords.com>
References: <1040815160.533.6.camel@devcon-x>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040815160.533.6.camel@devcon-x>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For some funny reason, a 2.4.20 kernel refuses to set the DMA-level on
> the new disks (all connected to a UDMA5-capable Ultra100 TX2 controller)
> to UDMA5,4,3 and settles it for UDMA2, which is the highest possibility
> for the OLD onboard-controller (but NOT for the promise card).

You need to boot 2.4.19 and 2.4.20 with 'ideX=ata66' where X is the
number of the channel where you wish to use transfer modes above UDMA2.
For instance, "ide0=ata66 ide1=ata66" will do the trick for the first two
channels.  This is a well-known bug in the PDC driver that has never been
fixed.  And don't worry, 2.4.21 will most likely feature a PDC driver that
won't work at all (read Andre Hedrick's posts from last week), but if you
say 2.5.52 mostly works then you might be lucky as 2.5 IDE is basically
the same codebase as 2.4.21-pre.

> The errors was (2.4.20):
> 
> <DATE> webber kernel: hdg: dma_intr: status=0x51
> <DATE> webber kernel: hdg: end_request: I/O error, dev 22:00 (hdg)
> sector 58033224
> <DATE> webber kernel: hdg: dma_intr: status=0x51
> <DATE> webber kernel: hdg: dma_intr: error=0x40 LBAsect=58033238,
> sector=58033232
> <DATE> webber kernel: end_request: I/O error, dev 22:00 (hdg), sector
> 58033232

Hmmm, I can't help you with these.

-- 
Tomas Szepe <szepe@pinerecords.com>
