Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbWCUVIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbWCUVIj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbWCUVIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:08:38 -0500
Received: from fmr17.intel.com ([134.134.136.16]:34534 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S965123AbWCUVIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:08:37 -0500
Message-ID: <44206B53.8020701@ichips.intel.com>
Date: Tue, 21 Mar 2006 13:08:35 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Sean Hefty <sean.hefty@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 4/6 v2] IB: address translation to
 map	IP toIB addresses (GIDs)
References: <ORSMSX401FRaqbC8wSA0000000d@orsmsx401.amr.corp.intel.com> <adabqvza53f.fsf@cisco.com>
In-Reply-To: <adabqvza53f.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  > +struct workqueue_struct *rdma_wq;
>  > +EXPORT_SYMBOL(rdma_wq);
> 
> Sean, I don't think I saw an answer when I asked you this before.  Why
> is ib_addr exporting a workqueue?  Is there some sort of ordering
> constraint that is forcing other modules to go through the same
> workqueue for things?
> 
> This seems like a very fragile internal thing to be exposing, and I'm
> wondering if there's a better way to handle it.

I responded in a different thread, but here's what I wrote:

"This is simply an attempt to reduce/combine work queues used by the Infiniband 
code.  This keeps the threading a little simpler in the rdma_cm, since all 
callbacks are invoked using the same work queue.  (I'm also using this with the 
local SA/multicast code, but that's not ready for merging.)"

There's no specific ordering constraint that's required.  We're just ending up 
with several Infiniband modules creating their own work queues (ib_mad, ib_cm, 
ib_addr, rdma_cm, plus a couple more in modules under development), and this is 
an attempt to reduce that.  If having separate work queues would work better, 
there shouldn't be anything that prevents this.

- Sean
