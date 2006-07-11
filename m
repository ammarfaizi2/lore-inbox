Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWGKNbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWGKNbx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWGKNbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:31:53 -0400
Received: from outbound-red.frontbridge.com ([216.148.222.49]:2964 "EHLO
	outbound1-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750761AbWGKNbw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:31:52 -0400
X-BigFish: V
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
Date: Tue, 11 Jul 2006 08:31:44 -0500
Message-ID: <84EA05E2CA77634C82730353CBE3A84303218EA4@SAUSEXMB1.amd.com>
In-Reply-To: <200607111507.39079.ak@suse.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
Thread-Index: Acak6wsDO/dyi7JURx6gizgrVxU1+gAAdGYA
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "Andi Kleen" <ak@suse.de>, "Deguara, Joachim" <joachim.deguara@amd.com>
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
X-OriginalArrivalTime: 11 Jul 2006 13:31:45.0799 (UTC)
 FILETIME=[5ABAA170:01C6A4EE]
X-WSS-ID: 68AD77CB27K16312640-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Jul 11 21:23:35 gradient kernel: CPU 2: Syncing TSC to CPU 0.
> > Jul 11 21:23:35 gradient kernel: CPU 2: synchronized TSC with CPU 0 
> > (last diff -91 cycles, maxerr 621 cycles)
> 
> > Jul 11 21:23:35 gradient kernel: CPU 3: Syncing TSC to CPU 0.
> > Jul 11 21:23:35 gradient kernel: CPU 3: synchronized TSC with CPU 0 
> > (last diff -122 cycles, maxerr 1129 cycles)
> 
> This means the CPUs diverged between 500 and 1100 cycles in the night.
> This can already cause severe timing problems with the clock 
> going backwards if a task switches CPUs - and there are many 
> programs that don't like that. If the system is up longer it 
> will be worse.

Joachim -

Can you run Andi's test without changing PN! frequency?
I'd like to see a baseline for how bad TSC is by itself,
and whether the TSCnow! code is making the problem worse
or better.

Customers in the field seem to want to use TSC for gtod,
so I want to know how awful an idea that is.

> The only way to possibly make the concept work would be 
> regular TSC resyncs during runtime, but I think I would 
> prefer using per CPU TSC offsets using RDTSCP instead because 
> they should be able to tolerate arbitary shifts.

I would prefer that, too, but I don't have the resources
to code that solution in the timeframe I have available.

-Mark Langsdorf
AMD, Inc.


