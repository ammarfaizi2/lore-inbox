Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWJJVFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWJJVFV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWJJVFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:05:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:29249 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1030362AbWJJVFS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:05:18 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,291,1157353200"; 
   d="scan'208"; a="2666163:sNHT23730390"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Date: Wed, 11 Oct 2006 01:05:03 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC3F4CAB@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
thread-index: AcbspzeMvSKTItYmTeC+rhGAbbHBDQABjRcg
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Jeremy Fitzhardinge" <jeremy@goop.org>,
       "Steven Rostedt" <rostedt@goodmis.org>
Cc: <tim.c.chen@linux.intel.com>, "Andrew Morton" <akpm@osdl.org>,
       <herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Oct 2006 21:05:12.0340 (UTC) FILETIME=[C6AE9540:01C6ECAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Jeremy Fitzhardinge [mailto:jeremy@goop.org] 
Sent: Wednesday, October 11, 2006 12:04 AM
To: Steven Rostedt
Cc: tim.c.chen@linux.intel.com; Andrew Morton;
herbert@gondor.apana.org.au; linux-kernel@vger.kernel.org; Ananiev,
Leonid I
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression

Steven Rostedt wrote:
> Holy crap!  I wonder where else in the kernel gcc is doing this. 
Jeremy Fitzhardinge wrote:
> annotation which makes gcc consider writes to the variable relatively
expensive

I should underline that cache miss is a result of invalidating of cache
line with __warn_once in each other CPUs performed by hw for cache
coherence.
__warn_once is a common data. It is costly to test-and-modify it just in
SMP. But it is not costly to write to the variable in memory just after
reading it. As a compiler have understood source code. 
A read-and-modify for common variable are performed under lock usually.

Leonid

Steven Rostedt wrote:
> Holy crap!  I wonder where else in the kernel gcc is doing this. (of
> course I'm using gcc4 so I don't know).  Is there another gcc
attribute
> to actually tell gcc that a variable is really mostly read only
(besides
> placing it in a mostly read only elf section)?
>   

That would be nice, but I don't know of one (apart from "volatile", 
which has its own downsides).  Once could imagine an annotation which 
makes gcc consider writes to the variable relatively expensive, so that 
it avoids generating unnecessary/excessive writes.

    J
