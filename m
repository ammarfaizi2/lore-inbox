Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUCLDFo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 22:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUCLDFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 22:05:44 -0500
Received: from fmr06.intel.com ([134.134.136.7]:2480 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261925AbUCLDFl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 22:05:41 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: 2.6.4-mm1
Date: Thu, 11 Mar 2004 19:04:50 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173FEB851@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.4-mm1
Thread-Index: AcQHwpjH5/XaizadTdeoVoWDAp71VwAGVVzQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Nick Piggin" <piggin@cyberone.com.au>, "Andi Kleen" <ak@muc.de>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Mar 2004 03:04:53.0912 (UTC) FILETIME=[CAC2E180:01C407DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The part I like with this scheduler is that the common scheduler code
has no idea about the domains topology; it just traverses the pointers.
The domains are built in an architecture or platform specific fashion.
So that part can be a bit complex as observed, but that's a setup
business, not a runtime behavior. 

As we can have more complex architectures in the future, the scheduler
is flexible enough to represent various scheduling domains effectively,
and yet keeps the common scheduler code simple.

Jun
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Nick Piggin
>Sent: Thursday, March 11, 2004 3:38 PM
>To: Andi Kleen
>Cc: Andrew Morton; linux-kernel@vger.kernel.org
>Subject: Re: 2.6.4-mm1
>
>Andi Kleen wrote:
>
>>>>Some kind of SMT scheduler is definitely needed, we have a serious
>>>>regression compared to 2.4 here right now. I'm not sure this
>>>>is the right approach though, it seems to be far too complex.
>>>>
>
>Andi, I'll agree that the way domains currently get set up is pretty
>ugly. Maybe some additional functions or macros could be used to make
>this process a bit clearer.
>
>The actual kernel/sched.c code is really not that complex. In some ways
>it is *less* complicated than the old numa scheduler because it all
goes
>through one code path.
>
>It also handles SMT, which is where a bit of complexity is coming from.
>The other alternative is shared runqueues which is uglier and less
flexible.
>
>
>>>Well that's discouraging.  I really do want to push this thing along
a
>bit.
>>>
>>>Yours is the only report of regression of which I am aware.  Is the
>reason
>>>understood?
>>>
>>
>>I think the reason is that it doesn't do balance on clone/fork. The
>>normal scheduler also doesn't do that, but for some reason it still
does
>>better on the benchmarks (but worse than the old 2.4 -aa/Intel O(1) HT
>>scheduler)
>>
>>
>
>There have been a few changes and bug fixes since you last tested.
>Maybe that would help.
>
>>>And is anyone developing alternative SMT enhancements?
>>>
>>
>>I thought there was a patch from Ingo Molnar? ("shared runqueue")
>>I must admit I never tried it, just remember seeing the patches.
>>
>
>Yep shared runqueues. Ingo and Rusty both had implementations but
>they both agreed sched-domains was a better alternative.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
