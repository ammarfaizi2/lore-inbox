Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968371AbWLEFOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968371AbWLEFOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968370AbWLEFOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:14:16 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:39492 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968368AbWLEFOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:14:14 -0500
Date: Tue, 5 Dec 2006 08:13:57 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Steve Wise <swise@opengridcomputing.com>
Cc: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2 04/13] Connection Manager
Message-ID: <20061205051356.GA26845@2ka.mipt.ru>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int> <20061202224958.27014.65970.stgit@dell3.ogc.int> <20061204110825.GA26251@2ka.mipt.ru> <ada8xhnk6kv.fsf@cisco.com> <1165249251.32724.26.camel@stevo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1165249251.32724.26.camel@stevo-desktop>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 05 Dec 2006 08:14:00 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 10:20:51AM -0600, Steve Wise (swise@opengridcomputing.com) wrote:
> >  > This and a lot of other changes in this driver definitely says you
> >  > implement your own stack of protocols on top of infiniband hardware.
> > 
> > ...but I do know this driver is for 10-gig ethernet HW.
> > 
> 
> There is no SW TCP stack in this driver.  The HW supports RDMA over
> TCP/IP/10GbE in HW and this is required for zero-copy RDMA over Ethernet
> (aka iWARP).  The device is a 10 GbE device, not Infiniband.  The
> Ethernet driver, upon which the rdma driver depends, acts both like a
> traditional Ethernet NIC for the Linux stack as well as a TCP offload
> device for the RDMA driver allowing establishment of RDMA connections.
> The Connection Manager (patch 04/13) sends/receives messages from the
> Ethernet driver that sets up HW TCP connections for doing RDMA.  While
> this is indeed implementing TCP offload, it is _not_ integrating it with
> the sockets layer nor the linux stack and offloading sockets
> connections.  Its only supporting offload connections for the RDMA
> driver to do iWARP.   The Ammasso device is another example of this
> (drivers/infiniband/hw/amso1100).  Deep iSCSI adapters are another
> example of this.

So what will happen when application will create a socket, bind it to
that NIC, and then try to establish a TCP connection? How NIC will
decide that received packets are from socket but not for internal TCP
state machine handled by that device?

As a side note, does all iwarp devices _require_ to have very
limited TCP engine implemented it in its hardware, or it is possible
to work with external SW stack?
 
> Steve.

-- 
	Evgeniy Polyakov
