Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265911AbUFITeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbUFITeL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 15:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbUFITdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 15:33:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31370 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265880AbUFITct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 15:32:49 -0400
Date: Wed, 9 Jun 2004 15:32:41 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: John Bradford <john@grabjohn.com>
cc: Matt Mackall <mpm@selenic.com>,
       Christian Borntraeger <linux-kernel@borntraeger.net>,
       <linux-kernel@vger.kernel.org>,
       Lasse K?rkk?inen / Tronic <tronic2@sci.fi>
Subject: Re: Some thoughts about cache and swap
In-Reply-To: <200406091932.i59JWh0N000383@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0406091528410.3620-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2004, John Bradford wrote:

> Does "the big problem" really exist though?

It's all about corner cases (and corner case workloads).

> Despite all of this discussion about swap and memory management, I
> _never_ reproduce any of the problems mentioned in normal use.

Just like most people aren't seeing problems with the O(1)
scheduler and the 500 lines of kludges piled on top that
keep it working ok in 2.6 - in most cases.

Compare with Con's staircase scheduler, that removes those
500 lines of code, appears to work just as good in the common
situations and deals with a few extra corner cases.

The VM is in a similar situation, with Too Much Magic(tm) all
over the place, just to keep the system working smoothly in
normal workloads.

It would be a minor miracle if the VM - with all the magic
tweaks - still worked fine for workloads that don't behave the
way the VM expects them to.

THAT is what replacing the current code with a self-learning
algorithm is all about, IMHO.

> In my experience, extreme VM problems almost always stem from
> mis-configured swap.

Haven't seen many of those, to be honest.  The majority
of the VM problems I get to see are people running a
workload the kernel didn't expect - a workload the kernel
wasn't prepared to handle...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

