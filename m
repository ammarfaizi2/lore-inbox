Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968428AbWLEQ1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968428AbWLEQ1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968429AbWLEQ1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:27:13 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:34815 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968428AbWLEQ1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:27:12 -0500
Subject: Re: [openib-general] [PATCH  v2 04/13] Connection Manager
From: Steve Wise <swise@opengridcomputing.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, netdev@vger.kernel.org,
       Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <1165334529.16087.69.camel@stevo-desktop>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
	 <20061202224958.27014.65970.stgit@dell3.ogc.int>
	 <20061204110825.GA26251@2ka.mipt.ru> <ada8xhnk6kv.fsf@cisco.com>
	 <1165249251.32724.26.camel@stevo-desktop> <45754DE3.1020505@ens-lyon.org>
	 <1165334529.16087.69.camel@stevo-desktop>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 10:27:12 -0600
Message-Id: <1165336032.16087.89.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 10:02 -0600, Steve Wise wrote:
> On Tue, 2006-12-05 at 11:45 +0100, Brice Goglin wrote:
> > Steve Wise wrote:
> > > There is no SW TCP stack in this driver.  The HW supports RDMA over
> > > TCP/IP/10GbE in HW and this is required for zero-copy RDMA over Ethernet
> > > (aka iWARP).  The device is a 10 GbE device, not Infiniband.
> > 
> > Then, I wonder why the driver goes in drivers/infiniband/ :)
> 
> drivers/infiniband support both IB and IWARP transports.
> 
> > Is there really no way to only keep the actual hw infiniband there, move
> > iwarp/rdma drivers in drivers/net/something/ and the core stuff in
> > net/something/ ?
> > 
> 
> Sure, this _could_ be done, but what I think you're missing is that
> applications use the interface exported by drivers/infiniband over both
> IB -and- IWARP transports.  The application can be written to not care
> which transport is used.   Examples of apps that can run over both
> transports using the same common interface: 
> 
> user mode: MVAPICH2, OMPI, IMPI, HPMPI, 
> kernel mode: NFS-RDMA, iSER.  
> 
> Note that the include directory used by drivers/infiniband is now
> include/rdma.  Perhaps drivers/infiniband should be renamed to
> drivers/rdma as well at some point...


By the way, FYI:  The Chelsio T3 device support is split into 2 driver
modules: the Ethernet driver and the RDMA driver.  The Ethernet driver
lives in drivers/net/cxgb3 while the RDMA driver lives in
drivers/infiniband/hw/cxgb3.  The Ethernet driver can be used
stand-alone as a 10GbE high-performance NIC driver.  The RDMA driver has
a config-time dependency on the Ethernet driver.

The 2nd version of the Ethernet driver was posted yesterday.  See:

http://www.spinics.net/lists/netdev/msg20464.html



Steve.

