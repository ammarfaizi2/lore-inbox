Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946857AbWKKANI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946857AbWKKANI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 19:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946813AbWKKANH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 19:13:07 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:54491 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1946857AbWKKANE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 19:13:04 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: touch_cache() only touches two thirds
Date: Fri, 10 Nov 2006 16:12:19 -0800
Message-ID: <FE74AC4E0A23124DA52B99F17F44159701DBBFE7@PA-EXCH03.vmware.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: touch_cache() only touches two thirds
Thread-Index: AccEoeggPGuYib7PR1ObQZqbfZqbogAhCT8/
References: <FE74AC4E0A23124DA52B99F17F441597DA118C@PA-EXCH03.vmware.com> <p734pt7k8s0.fsf@bingen.suse.de>
From: "Bela Lubkin" <blubkin@vmware.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <mingo@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> "Bela Lubkin" <blubkin@vmware.com> writes:
> > 
> > /*
> >  * Dirty a big buffer in a hard-to-predict (for the L2 cache) way. This
> >  * is the operation that is timed, so we try to generate unpredictable
> >  * cachemisses that still end up filling the L2 cache:
> >  */
>
> The comment is misleading anyways. AFAIK several of the modern
> CPUs (at least K8, later P4s, Core2, POWER4+, PPC970) have prefetch 
> predictors advanced enough to follow several streams forward and backwards
> in parallel.
>
> I hit this while doing NUMA benchmarking for example.
>
> Most likely to be really unpredictable you need to use a
> true RND and somehow make sure still the full cache range 
> is covered.

The corrected code in <http://bugzilla.kernel.org/show_bug.cgi?id=7476#c4>
covers the full cache range.  Granted that modern CPUs may be able to track
multiple simultaneous cache access streams: how many such streams are they
likely to be able to follow at once?  It seems like going from 1 to 2 would
be a big win, 2 to 3 a small win, beyond that it wouldn't likely make much
incremental difference.  So what do the actual implementations in the field
support?

The code (original and corrected) uses 6 simultaneous streams.

I have a modified version that takes a `ways' parameter to use an arbitrary
number of streams.  I'll post that onto bugzilla.kernel.org.

>Bela<
