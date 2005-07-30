Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263141AbVG3U0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbVG3U0m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbVG3UYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:24:07 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:20194 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263141AbVG3UX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:23:56 -0400
Subject: Re: [ANNOUNCE 0/7] Open-iSCSI/Linux-iSCSI-5 High-Performance
	Initiator
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: itn780@yahoo.com, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@lst.de>
In-Reply-To: <20050730.125312.78734701.davem@davemloft.net>
References: <429E15CD.2090202@yahoo.com> <1122744762.5055.10.camel@mulgrave>
	 <20050730.125312.78734701.davem@davemloft.net>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 15:23:20 -0500
Message-Id: <1122755000.5055.31.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-30 at 12:53 -0700, David S. Miller wrote:
> From: James Bottomley <James.Bottomley@SteelEye.com>
> Date: Sat, 30 Jul 2005 12:32:42 -0500
> 
> > FIB has taken your netlink number, so I changed it to 32
> 
> MAX_LINKS is 32, so there is no way this reassignment would
> work.

Actually, I saw this and increased MAX_LINKS as well.  I was going to
query all of this on the net-dev mailing list if we'd managed to get the
code compileable.

> You have to pick something in the range 0 --> 32, and as is
> no surprise, there are no numbers available :-)
> 
> Since ethertap has been deleted, 16-->31 could be made allocatable
> once more, but I simply do not want to do that and have the flood
> gates open up for folks allocating random netlink numbers.
> 
> Instead, we need to take one of those netlink numbers, and turn
> it into a multiplexable layer that can support an arbitrary
> number of sub-netlink types.  Said protocol would need some
> shim header that just says the "sub-netlink" protocol number,
> something as simple as just a "u32", this gets pulled off the
> front of the netlink packet and then it's passed on down to the
> real protocol.

I'll let the iSCSI people try this ...

Alternatively, if they don't fancy it, I think the kobject_uevent
mechanism (which already has a netlink number) looks like it might be
amenable for use for most of the things they want to do.

James


