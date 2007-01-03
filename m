Return-Path: <linux-kernel-owner+w=401wt.eu-S1750821AbXACOZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbXACOZt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 09:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbXACOZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 09:25:49 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:43423 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750818AbXACOZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 09:25:48 -0500
Subject: Re: [PATCH  v4 01/13] Linux RDMA Core Changes
From: Steve Wise <swise@opengridcomputing.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20061224084925.GD15106@mellanox.co.il>
References: <20061214135233.21159.78613.stgit@dell3.ogc.int>
	 <20061214135303.21159.61880.stgit@dell3.ogc.int>
	 <20061224084925.GD15106@mellanox.co.il>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 08:25:48 -0600
Message-Id: <1167834348.4187.3.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -1373,7 +1374,7 @@ int ib_peek_cq(struct ib_cq *cq, int wc_
> >  static inline int ib_req_notify_cq(struct ib_cq *cq,
> >  				   enum ib_cq_notify cq_notify)
> >  {
> > -	return cq->device->req_notify_cq(cq, cq_notify);
> > +	return cq->device->req_notify_cq(cq, cq_notify, NULL);
> >  }
> >  
> >  /**
> 
> Can't say I like this adding overhead in data path operations (and note this
> can't be optimized out). And kernel consumers work without passing it in, so it
> hurts kernel code even for Chelsio. Granted, the cost is small here, but these
> things do tend to add up.
> 
> It seems all Chelsio needs is to pass in a consumer index - so, how about a new
> entry point? Something like void set_cq_udata(struct ib_cq *cq, struct ib_udata *udata)?
> 

Adding a new entry point would hurt chelsio's user mode performance if
if then requires 2 kernel transitions to rearm the cq.  

Passing in user data is sort of SOP for these sorts of verbs.  

How much does passing one more param cost for kernel users?  



