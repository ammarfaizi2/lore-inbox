Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbUKJACI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbUKJACI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 19:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbUKJAAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 19:00:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:9139 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261777AbUKIX6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:58:48 -0500
Subject: Re: Externalize SLIT table
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Mark Goodwin <markgw@sgi.com>
Cc: Erich Focht <efocht@hpce.nec.com>, Jack Steiner <steiner@sgi.com>,
       Takayoshi Kochi <t-kochi@bq.jp.nec.com>, linux-ia64@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411100722070.14545@woolami.melbourne.sgi.com>
References: <20041103205655.GA5084@sgi.com>
	 <20041104.105908.18574694.t-kochi@bq.jp.nec.com>
	 <20041104141337.GA18445@sgi.com>  <200411041631.42627.efocht@hpce.nec.com>
	 <1100029381.3980.12.camel@arrakis>
	 <Pine.LNX.4.61.0411100722070.14545@woolami.melbourne.sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1100044724.3980.23.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 09 Nov 2004 15:58:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 12:34, Mark Goodwin wrote:
> On Tue, 9 Nov 2004, Matthew Dobson wrote:
> > ...
> > I don't think we should export the *exact same* node distance information
> > through the CPUs, though.
> 
> We should still export cpu distances though because the distance between
> cpus on the same node may not be equal. e.g. consider a node with multiple
> cpu sockets, each socket with a hyperthreaded (or dual core) cpu.

Well, I'm not sure that just because a CPU has two hyperthread units in
the same core that those HT units have a different distance or latency
to memory...?  The fact that it is a HT unit and not a physical core has
implications to the scheduler, but I thought that the 2 siblings looked
identical to userspace, no?  If 2 CPUs in the same node are on the same
bus, then in all likelihood they have the same "distance".


> Once again however, it depends on the definition of distance. For nodes,
> we've established it's the ACPI SLIT (relative distance to memory). For
> cpus, should it be distance to memory? Distance to cache? Registers? Or
> what?
> 
> -- Mark

That's the real issue.  We need to agree upon a meaningful definition of
CPU-to-CPU "distance".  As Jesse mentioned in a follow-up, we can all
agree on what Node-to-Node "distance" means, but there doesn't appear to
be much consensus on what CPU "distance" means.

-Matt

