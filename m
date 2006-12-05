Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967586AbWLEPqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967586AbWLEPqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937556AbWLEPqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:46:19 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:39990 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937498AbWLEPqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:46:18 -0500
Subject: Re: [PATCH  v2 04/13] Connection Manager
From: Steve Wise <swise@opengridcomputing.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061205152736.GA2274@2ka.mipt.ru>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
	 <20061202224958.27014.65970.stgit@dell3.ogc.int>
	 <20061204110825.GA26251@2ka.mipt.ru> <ada8xhnk6kv.fsf@cisco.com>
	 <20061205050725.GA26033@2ka.mipt.ru> <ada3b7uhqlk.fsf@cisco.com>
	 <20061205051657.GB26845@2ka.mipt.ru> <aday7pmgbf6.fsf@cisco.com>
	 <1165331676.16087.29.camel@stevo-desktop>
	 <20061205152736.GA2274@2ka.mipt.ru>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 09:46:18 -0600
Message-Id: <1165333578.16087.60.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 18:27 +0300, Evgeniy Polyakov wrote:
> On Tue, Dec 05, 2006 at 09:14:36AM -0600, Steve Wise (swise@opengridcomputing.com) wrote:
> > Chelsio doesn't implement TCP stack in the driver.  Just like Ammasso,
> > it sends messages to the HW to setup connections.  It differs from
> > Ammasso in at least 2 ways:
> > 
> > 1) Ammasso does the MPA negotiations in FW/HW.  Chelsio does it in the
> > RDMA driver.  So there is code in the Chelsio driver to handle MPA
> > startup negotiation (the exchange of 2 packets over the TCP connection
> > while its still in streaming more).  BTW: This code _could_ be moved
> > into the core IWCM if we find it could be used by other rnic devices
> > (don't know yet).
> > 
> > 2) Ammasso implments a 100% deep adapter.  It does ARP, routing, IP,
> > TCP, and IWARP protocols all in firmware/hw.  It had 2 mac addresses
> > simulating 2 ethernet ports.  One exclusively for RDMA connections, and
> > one for host stack traffic.  Chelsio implements a shallower adapter that
> > only does TCP in HW.  ARP, for instance, is handled by the native stack
> > and the rdma driver uses netevents to maintain arp tables in the HW for
> > use by the offloaded TCP connections.
> 
> So breifly saying - there is TCP stack implementation (including ARP and
> routing and other parts) in hardware/firmware/driver which is guaranteed
> to not be visible to host other than in form of high-level dataflow.
> Am I right here?

For Ammasso, yes.  

