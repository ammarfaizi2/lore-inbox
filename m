Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWCJPyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWCJPyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWCJPyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:54:19 -0500
Received: from [194.90.237.34] ([194.90.237.34]:26784 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1751656AbWCJPyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:54:18 -0500
Date: Fri, 10 Mar 2006 17:54:34 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Roland Dreier <rdreier@cisco.com>, akpm@osdl.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       davem@davemloft.net
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
Message-ID: <20060310155434.GB12778@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain> <adalkvjfbo0.fsf@cisco.com> <1141947581.10693.45.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141947581.10693.45.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 10 Mar 2006 15:56:42.0859 (UTC) FILETIME=[39C56BB0:01C6445B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Bryan O'Sullivan <bos@pathscale.com>:
> Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
> 
> On Thu, 2006-03-09 at 15:20 -0800, Roland Dreier wrote:
> 
> > I've never understood what forces you to maintain two separate SMAs.
> > Why can't you pick one of the two SMAs and use that unconditionally?
> 
> Three reasons.
> 
>       * OpenSM wasn't usable when we wrote our SMA.  We have customers
>         using ours now, so we have to support it.

Presumably you mean the ib_mad SMA - OpenSM is not an SMA.
I don't understand this. You don't talk to an SMA directly -
its jobs is to receive and send management packets that the card
gets from a subnet manager. So what do customers care which SMA
implementation is used, as long as it formats the management packets
correctly?

If you want to extend the SMA in non-standard ways, you can
snoop and send management packets by loading ib_umad.

>       * Our SMA does some setup for the layered ethernet emulation
>         driver.

You are doing this from userspace, right? But you can already send/receive MADs
from userspace by loading ib_umad.  What is there that is not sufficient for
your purposes?

By the way, this might also be a clean way for you to get at the port info
node info and port counters atomically like you wanted to in another thread:
post a management packet to the local device, get a packet back.
No need for extra sysfs files.

>       * Our SMA works without an IB stack of any kind present.

The stack is pretty slim, AFAIK it mostly consists of an SMA implementation.
So where's the benefit in avoiding it? Just link against ib_mad, it will
get loaded atomatically.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
