Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267923AbRHASly>; Wed, 1 Aug 2001 14:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267937AbRHASlp>; Wed, 1 Aug 2001 14:41:45 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:62180 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S267923AbRHASlg>; Wed, 1 Aug 2001 14:41:36 -0400
Importance: Normal
Subject: Re: [PATCH] register_inet6addr_notifier
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OFA376540F.BE06ACC0-ONC1256A9B.0062A90E@de.ibm.com>
From: "Utz Bacher" <utz.bacher@de.ibm.com>
Date: Wed, 1 Aug 2001 20:41:29 +0200
X-MIMETrack: Serialize by Router on D12ML009/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 01/08/2001 20:41:35
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alexey,

> Very interesting. I am very curious, what kind of "offload" is possible
> with current stack are possible. Even if you know addresses. :-)

it's the same kind of offload we use in IPv4 -- we set the
net_device->flags to IFF_NOARP and can then talk IP to the card. That
means,
the card does ARP and the tasks of hard_header etc. itself. We register
ourselves to get informed as soon as an IP address has been added/removed
and can tell that information to the card. As soon as the card knows about
the IP addresses of the device in the stack, it can respond to ARP queries
of other nodes.

Now hardware header generation and ARP don't cost a lot of performance, but
this whole story gets in particular interesting, as an S/390 can share a
single card between partitions on the same physical box (and that's very
common; obvious by looking at the price tag of the card :-). The card
peeks into incoming packets and according to the destination address, it
passes the packets on to the right partition(s).

We have the problem, that we won't be informed about any address changes
in IPv6 other than somehow polling for them.
(un)register_inet6addr_notifier would help us here.

> What's about the patch... Do you understand that currently
> it is impossible to call notifiers for adding/deletion of each IPv6
address
> in an intelligible context? Not seeing uses of such notifiers,
> it is difficult to approve such feature because of danger of misuse
> now and even worse misuse in (near) future, when context will change.

Yes, we are fully aware, that we cannot call the notifier functions
ourselves
resp. cannot expect any useful result by doing so. We are only interested
in
being always up to date wrt. IP addresses.

Regards,
Utz

Linux for S/390 and zSeries
:wq

