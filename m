Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVLaK5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVLaK5k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 05:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVLaK5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 05:57:40 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.25]:12321 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S932140AbVLaK5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 05:57:39 -0500
Subject: Re: [PATCH 6/9] clockpro-clockpro.patch
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Rik van Riel <riel@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>
In-Reply-To: <Pine.LNX.4.63.0512302321420.16308@cuia.boston.redhat.com>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
	 <20051230224312.765.58575.sendpatchset@twins.localnet>
	 <20051231002417.GA4913@dmt.cnet>
	 <Pine.LNX.4.63.0512302019530.2845@cuia.boston.redhat.com>
	 <20051231032702.GA9136@dmt.cnet>
	 <Pine.LNX.4.63.0512302321420.16308@cuia.boston.redhat.com>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 11:57:13 +0100
Message-Id: <1136026633.17853.52.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 00:24 -0500, Rik van Riel wrote:
> > > > Why do you use only two clock hands and not three (HandHot, HandCold and 
> > > > HandTest) as in the original paper?
> > > 
> > > Because the non-resident pages cannot be in the clock.
> > > This is both because of space overhead, and because the
> > > non-resident list cannot be per zone.
> > 
> > I see - that is a fundamental change from the original CLOCK-Pro
> > algorithm, right? 
> > 
> > Do you have a clear idea about the consequences of not having           
> > non-resident pages in the clock? 
> 
> The consequence is that we could falsely consider a non-resident
> page to be active, or not to be active.  However, this can only
> happen if we let the scan rate in each of the memory zones get
> way too much out of whack (which is bad regardless).

Yes, the uncertainty of position causes a time uncertainty wrt.
terminating the test period (heisenberg anyone?). So individual pages
can be terminated either too soon or too late, however statistics make
it come out even in the end.

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

