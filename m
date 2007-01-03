Return-Path: <linux-kernel-owner+w=401wt.eu-S932127AbXACVv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbXACVv1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbXACVv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:51:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:9018 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932127AbXACVv0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:51:26 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,234,1165219200"; 
   d="scan'208"; a="181148982:sNHT31422328"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] 4/4 block: explicit plugging
Date: Wed, 3 Jan 2007 13:50:46 -0800
Message-ID: <98F3657447CE934E9ADA3A348D854FB602858A4F@scsmsx414.amr.corp.intel.com>
In-Reply-To: <20070103082202.GG11203@kernel.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 4/4 block: explicit plugging
thread-index: AccvEB1PZItVrhcJTkGulRrlxS87SgAb7W8A
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Jens Axboe" <jens.axboe@oracle.com>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Nick Piggin" <npiggin@suse.de>
X-OriginalArrivalTime: 03 Jan 2007 21:50:47.0368 (UTC) FILETIME=[39FF7C80:01C72F81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote on Wednesday, January 03, 2007 12:22 AM
> > Do you have any benchmarks which got faster with these changes?
> 
> On the hardware I have immediately available, I see no regressions wrt
> performance. With instrumentation it's simple to demonstrate that most
> of the queueing activity of an io heavy benchmark spends less time in
> the kernel (most merging activity takes place outside of the queue
lock,
> hence queueing is lock free).
> 
> I've asked Ken to run this series on some of his big iron, I hope
he'll
> have some results for us soonish.

We are having some trouble with the patch set that some of our fiber
channel
host controller doesn't initialize properly anymore and thus lost whole
bunch
of disks (somewhere around 200 disks out of 900) at boot time.
Presumably FC
loop initialization command are done through block layer etc.  I haven't
looked into the problem closely.

Jens, I assume the spin lock bug in __blk_run_queue is fixed in this
patch
set?

- Ken
