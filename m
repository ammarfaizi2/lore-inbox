Return-Path: <linux-kernel-owner+w=401wt.eu-S1762435AbWLJXES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762435AbWLJXES (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 18:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762436AbWLJXES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 18:04:18 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:37254 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762421AbWLJXER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 18:04:17 -0500
Subject: Re: [PATCH  v3 13/13] Kconfig/Makefile
From: Steve WIse <swise@opengridcomputing.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061210145602.d2a8bb98.randy.dunlap@oracle.com>
References: <20061210223244.27166.36192.stgit@dell3.ogc.int>
	 <20061210223916.27166.82130.stgit@dell3.ogc.int>
	 <20061210145602.d2a8bb98.randy.dunlap@oracle.com>
Content-Type: text/plain
Date: Sun, 10 Dec 2006 17:04:14 -0600
Message-Id: <1165791854.25243.11.camel@linux-q667.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +++ b/drivers/infiniband/hw/cxgb3/Kconfig
> > @@ -0,0 +1,27 @@
> > +config INFINIBAND_CXGB3
> > +	tristate "Chelsio RDMA Driver"
> > +	depends on CHELSIO_T3 && INFINIBAND
> > +	select GENERIC_ALLOCATOR
> > +	---help---
> > +	  This is an iWARP/RDMA driver for the Chelsio T3 1GbE and
> > +	  10GbE adapters.
> > +
> > +          For general information about Chelsio and our products, visit
> > +          our website at <http://www.chelsio.com>.
> > +
> > +          For customer support, please visit our customer support page at
> > +          <http://www.chelsio.com/support.htm>.
> > +
> > +          Please send feedback to <linux-bugs@chelsio.com>.
> > +
> > +          To compile this driver as a module, choose M here: the module
> > +          will be called iw_cxgb3.
> 
> Please indent all of that the same amount.
> Kconfig help text should be indented 1 tab + 2 spaces,
> like the first 2 lines are.
> 

Will do.

> 
> > diff --git a/drivers/infiniband/hw/cxgb3/locking.txt b/drivers/infiniband/hw/cxgb3/locking.txt
> > new file mode 100644
> > index 0000000..e5e9991
> > --- /dev/null
> > +++ b/drivers/infiniband/hw/cxgb3/locking.txt
> > @@ -0,0 +1,25 @@
> > +cq lock:
> > +	- spin lock
> > +	- used to synchronize the t3_cq
> > +
> > +qp lock:
> > +	- spin lock
> > +	- used to synchronize updates to the qp state, attrs, and the t3_wq.
> > +	- touched on interrupt and process context
> > +	
> > +rnicp lock:
> > +	- spin lock
> > +	- touched on interrupt and process context
> > +	- used around lookup tables mapping CQID and QPID to a structure.
> > +	- used also to bump the refcnt atomically with the lookup.
> > +
> > +poll:
> > +	lock+disable on cq lock
> > +		lock qp lock for each cqe that is polled around the call
> > +		to cxio_poll_cq().
> > +	
> > +post: 
> > +	lock+disable qp lock
> > +
> > +global mutex iwch_mutex:
> > +	used to maintain global device list.
> 
> Should be in Documentation/infiniband/.
> Docs go in the Documentation/ dir, not in drivers/ dir.
> 

I think I'll just remove this file.  I don't think its that useful...


Steve.



