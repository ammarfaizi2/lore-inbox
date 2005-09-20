Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbVITTNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbVITTNx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 15:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVITTNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 15:13:53 -0400
Received: from amdext4.amd.com ([163.181.251.6]:22433 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S965087AbVITTNx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 15:13:53 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [discuss] Re: [PATCH] x86-64: Fix bad assumption that
 dualcore cpus have synced TSCs
Date: Tue, 20 Sep 2005 14:13:13 -0500
Message-ID: <84EA05E2CA77634C82730353CBE3A843032187C4@SAUSEXMB1.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] Re: [PATCH] x86-64: Fix bad assumption that
 dualcore cpus have synced TSCs
Thread-Index: AcW+FaEdhoZpYvZgTdaGA0sTES3jFAAAS2/Q
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "john stultz" <johnstul@us.ibm.com>, "Andi Kleen" <ak@suse.de>
cc: "Andrew Morton" <akpm@osdl.org>, "lkml" <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
X-OriginalArrivalTime: 20 Sep 2005 19:13:14.0000 (UTC)
 FILETIME=[59338100:01C5BE17]
X-WSS-ID: 6F2E80C309S1621524-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2005-09-19 at 21:49 +0200, Andi Kleen wrote:
> > On Mon, Sep 19, 2005 at 12:42:16PM -0700, john stultz wrote:
> > > On Mon, 2005-09-19 at 21:31 +0200, Andi Kleen wrote:
> > > > On Mon, Sep 19, 2005 at 12:16:43PM -0700, john stultz wrote:
> > > > > 	This patch should resolve the issue seen in 
> bugme bug #5105, 
> > > > > where it is assumed that dualcore x86_64 systems have synced 
> > > > > TSCs. This is not the case, and alternate timesources 
> should be 
> > > > > used instead.
> > > > 
> > > > 
> > > > I asked AMD some time ago and they told me it was synchronized. 
> > > > The TSC on K8 is C state invariant, but not P state 
> invariant, but 
> > > > P states always happen synchronized on dual cores.
> > > > 
> > > > So I'm not quite convinced of your explanation yet.
> > > 
> > > Would a litter userspace test checking the TSC 
> synchronization maybe 
> > > shed additional light on the issue?
> > 
> > Sure you can try it.
> 
> So, bugzilla.kernel.org has (temporarily at least) lost the 
> reports from yesterday, but from the email i got, folks using 
> my TSC consistency check that I posted were seeing what 
> appears to be unsynched TSCs on dualcore AMD systems.

My understanding was that each TSC on a dual-core processor
will advance individually and atomically.  They will not 
always be in synchronization.

> Personally I suspect that the powernow driver is putting the 
> cores independently into low power sleep and the TSCs are 
> being independently halted, causing them to become unsynchronized.

The powernow-k8 driver doesn't know what a low power sleep state
is, so I strongly doubt it is involved here.  It only handles
pstates.
 
-Mark Langsdorf
K8 PowerNow! Maintainer
AMD, Inc.

