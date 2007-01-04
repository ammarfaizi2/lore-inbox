Return-Path: <linux-kernel-owner+w=401wt.eu-S1030245AbXADVtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbXADVtc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbXADVtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:49:32 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:55473 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030191AbXADVtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:49:31 -0500
Subject: Re: [openib-general] [PATCH  v4 01/13] Linux RDMA Core Changes
From: Steve Wise <swise@opengridcomputing.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adawt424gt8.fsf@cisco.com>
References: <1167851839.4187.36.camel@stevo-desktop>
	 <20070103193324.GD29003@mellanox.co.il>
	 <1167855618.4187.65.camel@stevo-desktop>
	 <1167859320.4187.81.camel@stevo-desktop>  <adawt424gt8.fsf@cisco.com>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 15:49:31 -0600
Message-Id: <1167947371.3071.59.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-04 at 13:34 -0800, Roland Dreier wrote:
> OK, I'm back from vacation today.
> 
> Anyway I don't have a definitive statement on this right now.  I guess
> I agree that I don't like having an extra parameter to a function that
> should be pretty fast (although req notify isn't quite as hot as
> something like posting a send request or polling a cq), given that it
> adds measurable overhead.  (And I am surprised that the overhead is
> measurable, since 3 arguments still fit in registers, but OK).
> 
> I also agree that adding an extra entry point just to pass in the user
> data is ugly, and also racy.
> 
> Giving the kernel driver a pointer it can read seems OK I guess,
> although it's a little ugly to have a backdoor channel like that.
> 
> I'm somewhat surprised the driver has to go into the kernel to rearm a
> CQ -- what makes the operation need kernel privileges?  (Sorry for not
> reading the code)
> -

Rearming the CQ requires reading and writing to a global adapter
register that is shared and thus needs to be protected.  They didn't
architect the rearm to be a direct user operation.

Steve.



