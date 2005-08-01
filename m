Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbVHAREp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVHAREp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 13:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVHAREp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 13:04:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:32909 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262424AbVHAREj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 13:04:39 -0400
Date: Mon, 1 Aug 2005 10:04:24 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: Alex Williamson <alex.williamson@hp.com>, tony.luck@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: long delays (possibly infinite) in time_interpolator_get_counter
In-Reply-To: <200508011057.05802.bjorn.helgaas@hp.com>
Message-ID: <Pine.LNX.4.62.0508011002280.6746@schroedinger.engr.sgi.com>
References: <200507292206.j6TM6w4k004594@agluck-lia64.sc.intel.com>
 <1122742054.28719.58.camel@localhost.localdomain>
 <Pine.LNX.4.62.0507301105120.25104@schroedinger.engr.sgi.com>
 <200508011057.05802.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Bjorn Helgaas wrote:

> > If it is really synchronized then you can run with "nojitter" without any 
> > issue. Then you wont have to deal with the cmpxchg and everything is fine. 
> > But I suspect that the ITC are NOT truly synchronized (it has an 
> > "offset" that may be nonzero right?) otherwise you would have used nojitter.
> 
> And why should everyday users have to be concerned with "nojitter"?

Because so far ITCs were not truly synchronized.
 
> > Extra timer hardware is necessary to fix the ITC deficiency. You are at 
> > the source of the problem. Fix the damn hardware to provide a standardized 
> > synchronized clock or provide a truly synchronized ITC.
> 
> The "ITC deficiency" is a platform design issue.  Most small SMP platforms
> *do* synchronize the clocks of all processors.  Obviously that's difficult
> on large boxes, and then you may need extra timers in the platform.

I have no objections to making nojitter the default. There is already some 
PAL information that provides information on ITC reliability. If you can 
insure that this is accurate (currently it indicates no drift even if 
the ITC's have an offset) then simply switch on nojitter for small 
boxes.
