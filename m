Return-Path: <linux-kernel-owner+w=401wt.eu-S1750857AbXACPUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbXACPUZ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbXACPUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:20:25 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:36510 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbXACPUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:20:24 -0500
Date: Wed, 3 Jan 2007 17:18:23 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Steve Wise <swise@opengridcomputing.com>
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH  v4 01/13] Linux RDMA Core Changes
Message-ID: <20070103151823.GR6019@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1167836172.4187.9.camel@stevo-desktop> <20070103150013.GO6019@mellanox.co.il> <1167836841.4187.18.camel@stevo-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167836841.4187.18.camel@stevo-desktop>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > No, it won't need 2 transitions - just an extra function call,
> > > > so it won't hurt performance - it would improve performance.
> > > > 
> > > > ib_uverbs_req_notify_cq would call
> > > > 
> > > > 	ib_uverbs_req_notify_cq()
> > > > 	{
> > > > 			ib_set_cq_udata(cq, udata)
> > > > 			ib_req_notify_cq(cq, cmd.solicited_only ?
> > > > 				IB_CQ_SOLICITED : IB_CQ_NEXT_COMP);
> > > > 	}
> > > > 
> > > 
> > > ib_set_cq_udata() would transition into the kernel to pass in the
> > > consumer's index.  In addition, ib_req_notify_cq would also transition
> > > into the kernel since its not a bypass function for chelsio.
> > 
> > We misunderstand each other.
> > 
> > ib_uverbs_req_notify_cq is in drivers/infiniband/core/uverbs_cmd.c -
> > all this code runs inside the IB_USER_VERBS_CMD_REQ_NOTIFY_CQ command,
> > so there is a single user to kernel transition.
> > 
> 
> Oh I see. 
> 
> This seems like a lot of extra code to avoid passing one extra arg to
> the driver's req_notify_cq verb.  I'd appreciate other folk's input on
> how important they think this is.  
>
> If you insist, then I'll run some tests specifically in kernel mode and
> see how this affects mthca's req_notify performance.

This might be an interesting datapoint.

-- 
MST
