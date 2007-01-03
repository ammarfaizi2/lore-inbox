Return-Path: <linux-kernel-owner+w=401wt.eu-S1750850AbXACPHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbXACPHX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbXACPHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:07:23 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:56915 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750836AbXACPHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:07:21 -0500
Subject: Re: [PATCH  v4 01/13] Linux RDMA Core Changes
From: Steve Wise <swise@opengridcomputing.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20070103150013.GO6019@mellanox.co.il>
References: <1167836172.4187.9.camel@stevo-desktop>
	 <20070103150013.GO6019@mellanox.co.il>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 09:07:21 -0600
Message-Id: <1167836841.4187.18.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-03 at 17:00 +0200, Michael S. Tsirkin wrote:
> > > 
> > > No, it won't need 2 transitions - just an extra function call,
> > > so it won't hurt performance - it would improve performance.
> > > 
> > > ib_uverbs_req_notify_cq would call
> > > 
> > > 	ib_uverbs_req_notify_cq()
> > > 	{
> > > 			ib_set_cq_udata(cq, udata)
> > > 			ib_req_notify_cq(cq, cmd.solicited_only ?
> > > 				IB_CQ_SOLICITED : IB_CQ_NEXT_COMP);
> > > 	}
> > > 
> > 
> > ib_set_cq_udata() would transition into the kernel to pass in the
> > consumer's index.  In addition, ib_req_notify_cq would also transition
> > into the kernel since its not a bypass function for chelsio.
> 
> We misunderstand each other.
> 
> ib_uverbs_req_notify_cq is in drivers/infiniband/core/uverbs_cmd.c -
> all this code runs inside the IB_USER_VERBS_CMD_REQ_NOTIFY_CQ command,
> so there is a single user to kernel transition.
> 

Oh I see. 

This seems like a lot of extra code to avoid passing one extra arg to
the driver's req_notify_cq verb.  I'd appreciate other folk's input on
how important they think this is.  

If you insist, then I'll run some tests specifically in kernel mode and
see how this affects mthca's req_notify performance.

Steve.





