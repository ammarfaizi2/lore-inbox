Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbTDCSiK 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 13:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263269AbTDCSiJ 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 13:38:09 -0500
Received: from willow.seitz.com ([146.145.147.180]:6408 "EHLO willow.seitz.com")
	by vger.kernel.org with ESMTP id S262621AbTDCSgo 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 13:36:44 -0500
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Thu, 3 Apr 2003 13:47:56 -0500
To: "Peter L. Ashford" <ashford@sdsc.edu>
Cc: Jonathan Vardy <jonathan@explainerdc.com>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: RAID 5 performance problems
Message-ID: <20030403184756.GA7971@willow.seitz.com>
References: <73300040777B0F44B8CE29C87A0782E101FA97B2@exchange.explainerdc.com> <Pine.GSO.4.30.0304030858080.20118-100000@multivac.sdsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0304030858080.20118-100000@multivac.sdsc.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC list trimmed]

On Thu, Apr 03, 2003 at 10:05:27AM -0800, Peter L. Ashford wrote:
> > 4 of the raid HD's are connected to the Promise controller and the other
> > raid HD is master on the second onboard IDE channel (udma2/ATA33)
> 
> I've NEVER heard that the FastTrak runs fast (I have been told that they
> run VERY slowly).

The FastTrack cards are identical to the UltraDMA cards from promise -
you can turn one into the other with a resistor and a firmware flash.

> I've benchmarked RAW disk speeds with an Ultra-100 and
> WD1200JB drives, and gotten 50MB/S from each disk, as opposed to your
> 26MB/S (there should be almost no difference for the BB drives).

Makes perfect sense - he's getting 50M/s to each channel, but it's split
over two drives, so drive throughput is about halved.

> Use one disk per channel
> (Master only), and move the system disk onto one of the Promise cards.

Absolutely correct - you should *never* run IDE RAID on a channel that
has both a master and slave.  When one disk on an IDE channel has an
error, the whole channel is reset - this makes both disks inaccessible,
and RAID5 now has two failed disks => you data is gone!  *ALWAYS* use
separate IDE channels.


-- 
Ross Vandegrift
ross@willow.seitz.com

A Pope has a Water Cannon.                               It is a Water Cannon.
He fires Holy-Water from it.                        It is a Holy-Water Cannon.
He Blesses it.                                 It is a Holy Holy-Water Cannon.
He Blesses the Hell out of it.          It is a Wholly Holy Holy-Water Cannon.
He has it pierced.                It is a Holey Wholly Holy Holy-Water Cannon.
He makes it official.       It is a Canon Holey Wholly Holy Holy-Water Cannon.
Batman and Robin arrive.                                       He shoots them.
