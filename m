Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbUKVVaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbUKVVaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbUKVV1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:27:45 -0500
Received: from palrel11.hp.com ([156.153.255.246]:16830 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262376AbUKVV03 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:26:29 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [Lse-tech] scalability of signal delivery for Posix Threads
Date: Mon, 22 Nov 2004 13:26:28 -0800
Message-ID: <65953E8166311641A685BDF71D865826058B5C@cacexc12.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lse-tech] scalability of signal delivery for Posix Threads
Thread-Index: AcTQ1Tt2eikfi5qRTtCctVUUL6ganAAAz41Q
From: "Boehm, Hans" <hans.boehm@hp.com>
To: "Ray Bryant" <raybry@sgi.com>, "Andi Kleen" <ak@suse.de>
Cc: "Andreas Schwab" <schwab@suse.de>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>,
       "lse-tech" <lse-tech@lists.sourceforge.net>, <holt@sgi.com>,
       "Dean Roe" <roe@sgi.com>, "Brian Sumner" <bls@sgi.com>,
       "John Hawkes" <hawkes@tomahawk.engr.sgi.com>
X-OriginalArrivalTime: 22 Nov 2004 21:26:28.0929 (UTC) FILETIME=[EDCC5B10:01C4D0D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although I don't fully understand all the issues here,
I'm concerned about this proposal.  In particular, our
garbage collector (used by gcj, and Mono, among others)
uses signals to stop threads for each garbage collection.
With a small heap, and many threads, I would expect the
frequency of signal delivery to be similar to what you
get with performance tools.  But it does not, and should not,
use SIGPROF.

I think this is a more general issue.  Special casing one
piece of it is only going to make performance more surprising,
something I think should be avoided if at all possible.

Hans

> -----Original Message-----
> From: linux-ia64-owner@vger.kernel.org
> [mailto:linux-ia64-owner@vger.kernel.org]On Behalf Of Ray Bryant
> Sent: Monday, November 22, 2004 11:23 AM
> To: Andi Kleen
> Cc: Andreas Schwab; Kernel Mailing List; linux-ia64@vger.kernel.org;
> lse-tech; holt@sgi.com; Dean Roe; Brian Sumner; John Hawkes
> Subject: Re: [Lse-tech] scalability of signal delivery for 
> Posix Threads
> 
> 
> OK, apparently SIGPROF is delivered in both the ITIMER_PROF and
> pmu interrupt cases, so if we special case that signal we should
> be fine.
> -- 
> Best Regards,
> Ray
> -----------------------------------------------
>                    Ray Bryant
> 512-453-9679 (work)         512-507-7807 (cell)
> raybry@sgi.com             raybry@austin.rr.com
> The box said: "Requires Windows 98 or better",
>             so I installed Linux.
> -----------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
