Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWCMRLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWCMRLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 12:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWCMRLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 12:11:39 -0500
Received: from fmr17.intel.com ([134.134.136.16]:3218 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750820AbWCMRLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 12:11:38 -0500
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Roland Dreier'" <rdreier@cisco.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <openib-general@openib.org>
Subject: RE: [PATCH 5/6 v2] IB: IP address based RDMA connection manager
Date: Mon, 13 Mar 2006 09:11:34 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
thread-index: AcZGtQV5tqXO0SOWSCO3sJe3U7UdMQAC5bTA
In-Reply-To: <adabqwafizj.fsf@cisco.com>
Message-ID: <ORSMSX401FRaqbC8wSA0000001e@orsmsx401.amr.corp.intel.com>
X-OriginalArrivalTime: 13 Mar 2006 17:11:36.0015 (UTC) FILETIME=[2F23DDF0:01C646C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static void cma_detach_from_dev(struct rdma_id_private *id_priv)
> > +{
> > +	list_del(&id_priv->list);
> > +	if (atomic_dec_and_test(&id_priv->cma_dev->refcount))
> > +		wake_up(&id_priv->cma_dev->wait);
> > +	id_priv->cma_dev = NULL;
> > +}
>
>doesn't need to do atomic_dec_and_test(), because it is never dropping
>the last reference to id_priv (and in fact if it was, the last line
>would be a use-after-free bug).

It's dropping the reference on cma_dev, as opposed to id_priv.

- Sean

