Return-Path: <linux-kernel-owner+w=401wt.eu-S932149AbXACVWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbXACVWH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbXACVWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:22:06 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:37226 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932147AbXACVWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:22:04 -0500
Subject: Re: [openib-general] [PATCH  v4 01/13] Linux RDMA Core Changes
From: Steve Wise <swise@opengridcomputing.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1167855618.4187.65.camel@stevo-desktop>
References: <1167851839.4187.36.camel@stevo-desktop>
	 <20070103193324.GD29003@mellanox.co.il>
	 <1167855618.4187.65.camel@stevo-desktop>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 15:22:00 -0600
Message-Id: <1167859320.4187.81.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > So what does this tell you?
> > To me it looks like there's a measurable speed difference,
> > and so we should find a way (e.g. what I proposed) to enable chelsio userspace
> > without adding overhead to other low level drivers or indeed chelsio kernel level code.
> > 
> > What do you think? Roland?
> > 
> 
> I think having a 2nd function to set the udata seems onerous.
> 
> 

Roland, 

If you think I should not add the udata parameter to the req_notify_cq()
provider verb, then I can rework the chelsio driver:

1) at cq creation time, pass the virtual address of the u32 used by the
library to track the current cq index.  That way the chelsio kernel
driver can save the address in its kernel cq context for later use.

2) change chelsio's req_notify_cq() to copy in the current cq index
value directly for rearming.

This puts all the burden on the chelsio driver, which is apparently the
only one that needs this functionality.  

Lemme know.

Steve.



