Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWJJVSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWJJVSJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWJJVSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:18:09 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:27520 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030388AbWJJVSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:18:05 -0400
Date: Tue, 10 Oct 2006 17:17:38 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
cc: Jeremy Fitzhardinge <jeremy@goop.org>, tim.c.chen@linux.intel.com,
       Andrew Morton <akpm@osdl.org>, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org
Subject: RE: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC3F4CAB@mssmsx411>
Message-ID: <Pine.LNX.4.58.0610101712370.10398@gandalf.stny.rr.com>
References: <B41635854730A14CA71C92B36EC22AAC3F4CAB@mssmsx411>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Oct 2006, Ananiev, Leonid I wrote:

> Steven Rostedt wrote:
> > Holy crap!  I wonder where else in the kernel gcc is doing this.
> Jeremy Fitzhardinge wrote:
> > annotation which makes gcc consider writes to the variable relatively
> expensive
>
> I should underline that cache miss is a result of invalidating of cache
> line with __warn_once in each other CPUs performed by hw for cache
> coherence.
> __warn_once is a common data. It is costly to test-and-modify it just in
> SMP. But it is not costly to write to the variable in memory just after
> reading it. As a compiler have understood source code.
> A read-and-modify for common variable are performed under lock usually.
>

In todays world, SMP is becoming more and more common (still waiting to
get that DualCore cell phone).  So that means that writing to a variable
is going to carry more weight than it use to, and gcc needs to take note
of this.  So, to avoid a short condition jump by adding a write to
memory, is not going to save anying.

Maybe gcc just needs to have an option to "optimize" for SMP.

-- Steve

