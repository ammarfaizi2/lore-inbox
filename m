Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263081AbVHERNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbVHERNW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 13:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbVHERNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 13:13:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:61362 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S263082AbVHERMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 13:12:54 -0400
Date: Fri, 5 Aug 2005 19:12:51 +0200
From: Andi Kleen <ak@suse.de>
To: Adam Litke <agl@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       christoph@lameter.com, dwg@au1.ibm.com
Subject: Re: [RFC] Demand faulting for large pages
Message-ID: <20050805171251.GZ8266@wotan.suse.de>
References: <1123255298.3121.46.camel@localhost.localdomain> <20050805155307.GV8266@wotan.suse.de> <1123259847.3121.91.camel@localhost.localdomain> <20050805164702.GY8266@wotan.suse.de> <1123261200.3121.104.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123261200.3121.104.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 12:00:00PM -0500, Adam Litke wrote:
> On Fri, 2005-08-05 at 11:47, Andi Kleen wrote:
> > On Fri, Aug 05, 2005 at 11:37:27AM -0500, Adam Litke wrote:
> > > On Fri, 2005-08-05 at 10:53, Andi Kleen wrote:
> > > > On Fri, Aug 05, 2005 at 10:21:38AM -0500, Adam Litke wrote:
> > > > > Below is a patch to implement demand faulting for huge pages.  The main
> > > > > motivation for changing from prefaulting to demand faulting is so that
> > > > > huge page allocations can follow the NUMA API.  Currently, huge pages
> > > > > are allocated round-robin from all NUMA nodes.   
> > > > 
> > > > I think matching DEFAULT is better than having a different default for
> > > > huge pages than for small pages.
> > > 
> > > I am not exactly sure what the above means.  Is 'DEFAULT' a system
> > > default numa allocation policy?
> > 
> > It's one of the four numa policies: DEFAULT, PREFERED, INTERLEAVE, BIND
> > 
> > It just means allocate on the local node if possible, otherwise fall back.
> > 
> > You said you wanted INTERLEAVE by default, which i think is a bad idea.
> > It should be only optional like in all other allocations.
> 
> I tried to say that allocations are _currently_ INTERLEAVE (aka
> round-robin) but that I want it to be configurable.  So I think we are
> in agreement here.

Ok, but the way to configure it should be the standard mempolicy
infrastructure (that is how it works in SLES9 too) 

-Andi
