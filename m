Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVK2TjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVK2TjX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 14:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVK2TjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 14:39:23 -0500
Received: from fmr16.intel.com ([192.55.52.70]:26076 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S932362AbVK2TjW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 14:39:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [RFC][PATCH] Runtime switching of the idle function [take 2]
Date: Tue, 29 Nov 2005 14:37:53 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005456F00@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH] Runtime switching of the idle function [take 2]
Thread-Index: AcX0sd+jvy33TaevQXaiRMFb6QzeAwAaP9pQ
From: "Brown, Len" <len.brown@intel.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>, "Ingo Molnar" <mingo@elte.hu>,
       "Steven Rostedt" <rostedt@goodmis.org>, "Andi Kleen" <ak@suse.de>
Cc: "Andrew Morton" <akpm@osdl.org>, <acpi-devel@lists.sourceforge.net>,
       <nando@ccrma.Stanford.EDU>, <rlrevell@joe-job.com>,
       <linux-kernel@vger.kernel.org>, <paulmck@us.ibm.com>, <kr@cybsft.com>,
       <tglx@linutronix.de>, <pluto@agmk.net>, <john.cooper@timesys.com>,
       <bene@linutronix.de>, <dwalker@mvista.com>, <trini@kernel.crashing.org>,
       <george@mvista.com>
X-OriginalArrivalTime: 29 Nov 2005 19:37:59.0340 (UTC) FILETIME=[6772E6C0:01C5F51C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

idle=poll is a really bad way to go from a power perspective.
While it is diminishing returns to get into deeper C-states,
getting into at least C1 (HALT or MONITOR/MWAIT) is very important
on many processors.

Note that if the issue at hand is the TSC stopping in deep
ACPI C-states, that there is a flag already available to limit
how deep the C-states go.  eg.

processor.max_cstate=2 will disable C3, C4 etc
You can do this at run-time by writing to
/sys/module/processor/parameters/max_cstate

I agree with Andi that we have some work to do to address
the issue directly, which is that the TSC is not reliable
under all conditions on all processors.  I think we need
some modes for TSC to detect and handle the cases where it either
stops in C3 or changes speeds, vs the systems where it actually
works the way we want it to -- constant rate that never stops.
 
>Why not just slightly cleanup and extend (eg. to ACPI) the
>hlt_counter thingy that many architectures already have?

Hmmm, I see the floppy driver invoking hlt_counter,
but it isn't clear what the general semantics and general
users are supposd to be.  Can you clue me in?

thanks,
-Len
