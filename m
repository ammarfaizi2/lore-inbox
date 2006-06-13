Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWFMUeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWFMUeg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWFMUeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:34:36 -0400
Received: from es335.com ([67.65.19.105]:34667 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S932096AbWFMUef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:34:35 -0400
Subject: Re: [PATCH v2 1/2] iWARP Connection Manager.
From: Steve Wise <swise@opengridcomputing.com>
To: Tom Tucker <tom@opengridcomputing.com>
Cc: Andrew Morton <akpm@osdl.org>, rdreier@cisco.com, mshefty@ichips.intel.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <1150127698.22704.9.camel@trinity.ogc.int>
References: <20060607200600.9003.56328.stgit@stevo-desktop>
	 <20060607200605.9003.25830.stgit@stevo-desktop>
	 <20060608005452.087b34db.akpm@osdl.org>
	 <1150127698.22704.9.camel@trinity.ogc.int>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 15:34:31 -0500
Message-Id: <1150230871.17394.68.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> > > +static void cm_event_handler(struct iw_cm_id *cm_id,
> > > +			     struct iw_cm_event *iw_event) 
> > > +{
> > > +	struct iwcm_work *work;
> > > +	struct iwcm_id_private *cm_id_priv;
> > > +	unsigned long flags;
> > > +
> > > +	work = kmalloc(sizeof(*work), GFP_ATOMIC);
> > > +	if (!work)
> > > +		return;
> > 
> > This allocation _will_ fail sometimes.  The driver must recover from it. 
> > Will it do so?
> 
> Er...no. It will lose this event. Depending on the event...the carnage
> varies. We'll take a look at this.
> 

This behavior is consistent with the Infiniband CM (see
drivers/infiniband/core/cm.c function cm_recv_handler()).  But I think
we should at least log an error because a lost event will usually stall
the rdma connection.

> > 
> > > +EXPORT_SYMBOL(iw_cm_init_qp_attr);
> > 
> > This file exports a ton of symbols.  It's usual to provide some justifying
> > commentary in the changelog when this happens.
> 
> This module is a logical instance of the xx_cm where xx is the transport
> type. I think there is some discussion warranted on whether or not these
> should all be built into and exported by rdma_cm. One rationale would be
> that the rdma_cm is the only client for many of these functions (this
> being a particularly good example) and doing so would reduce the export
> count. Others would be reasonably needed for any application (connect,
> etc...)
> 

Transport-dependent ULPs, in theory, are able to use the
transport-specific CM directly if they don't wish to use the RDMA CM.  I
think that's the rationale for have the xx_cm modules seperate from the
rdma_cm module and exporting the various functions.   

> All that said, we'll be sure to document the exported symbols in a
> follow-up patch.
> 

I'll add commentary explaining this.

Steve.

