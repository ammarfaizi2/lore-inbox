Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937066AbWLDQUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937066AbWLDQUy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937071AbWLDQUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:20:53 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:33702 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937066AbWLDQUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:20:52 -0500
Subject: Re: [PATCH  v2 04/13] Connection Manager
From: Steve Wise <swise@opengridcomputing.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <ada8xhnk6kv.fsf@cisco.com>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
	 <20061202224958.27014.65970.stgit@dell3.ogc.int>
	 <20061204110825.GA26251@2ka.mipt.ru>  <ada8xhnk6kv.fsf@cisco.com>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 10:20:51 -0600
Message-Id: <1165249251.32724.26.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 07:45 -0800, Roland Dreier wrote:
>  > Could you convince network core developers that it is not own TCP
>  > implementation which will mess with existing one?
> 
> I'm not qualified to comment on this...
> 

I don't understand your question?

>  > This and a lot of other changes in this driver definitely says you
>  > implement your own stack of protocols on top of infiniband hardware.
> 
> ...but I do know this driver is for 10-gig ethernet HW.
> 

There is no SW TCP stack in this driver.  The HW supports RDMA over
TCP/IP/10GbE in HW and this is required for zero-copy RDMA over Ethernet
(aka iWARP).  The device is a 10 GbE device, not Infiniband.  The
Ethernet driver, upon which the rdma driver depends, acts both like a
traditional Ethernet NIC for the Linux stack as well as a TCP offload
device for the RDMA driver allowing establishment of RDMA connections.
The Connection Manager (patch 04/13) sends/receives messages from the
Ethernet driver that sets up HW TCP connections for doing RDMA.  While
this is indeed implementing TCP offload, it is _not_ integrating it with
the sockets layer nor the linux stack and offloading sockets
connections.  Its only supporting offload connections for the RDMA
driver to do iWARP.   The Ammasso device is another example of this
(drivers/infiniband/hw/amso1100).  Deep iSCSI adapters are another
example of this.


Steve.


