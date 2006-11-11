Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946860AbWKKAX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946860AbWKKAX5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 19:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946863AbWKKAX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 19:23:57 -0500
Received: from mail.suse.de ([195.135.220.2]:6850 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946860AbWKKAX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 19:23:56 -0500
From: Andi Kleen <ak@suse.de>
To: "Bela Lubkin" <blubkin@vmware.com>
Subject: Re: touch_cache() only touches two thirds
Date: Sat, 11 Nov 2006 01:23:38 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
References: <FE74AC4E0A23124DA52B99F17F441597DA118C@PA-EXCH03.vmware.com> <p734pt7k8s0.fsf@bingen.suse.de> <FE74AC4E0A23124DA52B99F17F44159701DBBFE7@PA-EXCH03.vmware.com>
In-Reply-To: <FE74AC4E0A23124DA52B99F17F44159701DBBFE7@PA-EXCH03.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611110123.38309.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The corrected code in <http://bugzilla.kernel.org/show_bug.cgi?id=7476#c4>
> covers the full cache range.  Granted that modern CPUs may be able to track
> multiple simultaneous cache access streams: how many such streams are they
> likely to be able to follow at once?  It seems like going from 1 to 2 would
> be a big win, 2 to 3 a small win, beyond that it wouldn't likely make much
> incremental difference.  So what do the actual implementations in the field
> support?

I remember reading at some point that a POWER4 could track at least 5+ parallel
streams.  I don't know how many K8 handles, but it is multiple too at least 
(forward and backwards)

I don't have more data, but at least the newer Intel CPUs seem to be also 
very good at prefetching and when you look at a die photo the L/S unit 
in general is quite big. More than 6 streams handled is certainly a 
possibility.

I guess it could be figured out with some clever benchmarking.
> 
> The code (original and corrected) uses 6 simultaneous streams.

My gut feeling is that this is not enough.

> I have a modified version that takes a `ways' parameter to use an arbitrary
> number of streams.  I'll post that onto bugzilla.kernel.org.

Post it to the list please.

-Andi

