Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWCUWjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWCUWjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWCUWjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:39:39 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:63826 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751482AbWCUWji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:39:38 -0500
X-IronPort-AV: i="4.03,116,1141632000"; 
   d="scan'208"; a="316839968:sNHT33041572"
To: Sean Hefty <mshefty@ichips.intel.com>
Cc: Sean Hefty <sean.hefty@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 4/6 v2] IB: address translation to map	IP toIB addresses (GIDs)
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX401FRaqbC8wSA0000000d@orsmsx401.amr.corp.intel.com>
	<adabqvza53f.fsf@cisco.com> <44206B53.8020701@ichips.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 21 Mar 2006 14:39:36 -0800
In-Reply-To: <44206B53.8020701@ichips.intel.com> (Sean Hefty's message of "Tue, 21 Mar 2006 13:08:35 -0800")
Message-ID: <ada3bhba0d3.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Mar 2006 22:39:37.0803 (UTC) FILETIME=[55B461B0:01C64D38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Sean> "This is simply an attempt to reduce/combine work queues
    Sean> used by the Infiniband code.  This keeps the threading a
    Sean> little simpler in the rdma_cm, since all callbacks are
    Sean> invoked using the same work queue.  (I'm also using this
    Sean> with the local SA/multicast code, but that's not ready for
    Sean> merging.)"

How does it keep the threading model simpler?  Is this an inter-module
dependency.

    Sean> There's no specific ordering constraint that's required.
    Sean> We're just ending up with several Infiniband modules
    Sean> creating their own work queues (ib_mad, ib_cm, ib_addr,
    Sean> rdma_cm, plus a couple more in modules under development),
    Sean> and this is an attempt to reduce that.  If having separate
    Sean> work queues would work better, there shouldn't be anything
    Sean> that prevents this.

It seems like it would be cleaner for each module to have its own
workqueue if it needs one.  There's also schedule_work(), although
that goes to a multi-threaded workqueue.  Michael Tsirkin has
suggested creating a system-wide single-threaded workqueue (ie
something like schedule_ordered_work()) for everyone that occasionally
needs a single-threaded workqueue.

 - R.
