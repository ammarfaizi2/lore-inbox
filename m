Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWDRXk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWDRXk1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWDRXk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:40:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:2059 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750813AbWDRXk0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:40:26 -0400
X-IronPort-AV: i="4.04,132,1144047600"; 
   d="scan'208"; a="24694722:sNHT16005934"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: ia64_do_page_fault shows 19.4% slowdown from notify_die.
Date: Tue, 18 Apr 2006 16:40:24 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0642FB26@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ia64_do_page_fault shows 19.4% slowdown from notify_die.
Thread-Index: AcZjPKTWFXP+9pBGSq+uldbGXfZBwwAAloTg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       "Robin Holt" <holt@sgi.com>
Cc: "Keith Owens" <kaos@americas.sgi.com>, <prasanna@in.ibm.com>,
       <ananth@in.ibm.com>, <davem@davemloft.net>,
       <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 18 Apr 2006 23:40:25.0366 (UTC) FILETIME=[77635360:01C66341]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 499 nSec/fault ia64_do_page_fault notify_die commented out.
> 501 nSec/fault ia64_do_page_fault with nobody registered.
> 533 nSec/fault notify_die in and just kprobes.
> 596 nSec/fault notify_die in and kdb, kprobes, mca, and xpc loaded.
> 
> The 596 nSec/fault is a 19.4% slowdown.  This is an upcoming OSD beta
> kernel.  It will be representative of what our typical customer will
> have loaded.
> 
> Is this enough justification for breaking notify_die into
> notify_page_fault for the fault path?

I didn't see quite the stability from run to run that your results
suggest.  Running the benchmark five times on the same kernel, I saw
the mean value of the 128 results go from as low as 439 to as high
as 445.  So the difference between commenting in/out the notify_die
call is in the noise.

But comparing the first and last of your results shows that there
is significant slowdown when the notify chain is loaded up with a
ton of stuff, way more than the noise that I see, and I'm glad to see
Anil jumping in to fix this.

-Tony
