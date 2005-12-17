Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVLQV3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVLQV3a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVLQV3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:29:30 -0500
Received: from lame.durables.org ([64.81.244.120]:58539 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S932100AbVLQV3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:29:30 -0500
Subject: Re: [PATCH 07/13]  [RFC] ipath core misc files
From: Robert Walsh <rjwalsh@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20051217123850.aa6cfd53.akpm@osdl.org>
References: <200512161548.KglSM2YESlGlEQfQ@cisco.com>
	 <200512161548.3fqe3fMerrheBMdX@cisco.com>
	 <20051217123850.aa6cfd53.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 13:29:23 -0800
Message-Id: <1134854963.20575.17.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +void ipath_init_picotime(void)
> > +{
> > +	int i;
> > +	u_int64_t ts, te, delta = -1ULL;
> > +
> > +	for (i = 0; i < 5; i++) {
> > +		ts = get_cycles();
> > +		udelay(250);
> > +		te = get_cycles();
> > +		if ((te - ts) < delta)
> > +			delta = te - ts;
> > +		yield();
> > +	}
> > +	_ipath_pico_per_cycle = 250000000 / delta;
> > +}
> 
> hm, I hope this is debug code which is going away.  If not, we should take
> a look at what it's trying to do here.

This isn't debug code.  It's used to calculate the roughly number
picoseconds per cycle.  This is used in the driver to make sure
HyperTransport reads haven't timed out (see ipath_snap_cntr in
ipath_driver.c) when reading chip counters.  If you can think of a
better way of figuring out whether a read took greater than a certain
length of time, I'd be interested in knowing it.

Regards,
 Robert.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


