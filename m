Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVCJHOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVCJHOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 02:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVCJHOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 02:14:24 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44001 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262165AbVCJHOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 02:14:18 -0500
To: dipankar@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Dave Anderson <anderson@redhat.com>,
       gdb <gdb@sources.redhat.com>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: Query: Kdump: Core Image ELF Format
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
	<m1br9um313.fsf@ebiederm.dsl.xmission.com>
	<1110350629.31878.7.camel@wks126478wss.in.ibm.com>
	<m1ll8wlx82.fsf@ebiederm.dsl.xmission.com>
	<20050309150644.GA4663@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Mar 2005 00:11:10 -0700
In-Reply-To: <20050309150644.GA4663@in.ibm.com>
Message-ID: <m17jkgkmb5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> writes:

> On Wed, Mar 09, 2005 at 07:17:49AM -0700, Eric W. Biederman wrote:

> > Beyond that I prefer a little command line tool that will do the
> > ELF64 to ELF32 conversion and possibly add in the kva mapping to
> > make the core dump usable with gdb.  Doing it in a separate tool
> > means it is the developer who is doing the analysis who cares
> > not the user who is capturing the system core dump.
> 
> Well, as a kernel developer, I am both :) For me, having to install
> half-a-dozen different command line tools to get and analyze a crash dump
> is a PITA, not to mention potential version mismatches. As someone
> who would like very much to use crash dump for debugging, I would
> much rather be able to force a dump and then use gdb for
> a quick debug. I agree that a customer would see a different
> situation. It would be nice if we can cater to both the kinds.

Crash dumps seem to be a when all else fails kind of solution.  Or
something to make a detailed record of what happened so information
can be logged.

I think are differences are largely a matter of emphasis.  I worry
about the end user and the whole cycle.  For that we need a fixed
simple crash dump format whit no knobs bells or whistles, that can
be given to developers and eventually supported natively by all of
the tools.

I doubt tweaking gdb so it can handle a 64bit ELF core dump even
on 32bit architectures would be very hard.  Once that is in place
the 64->32bit conversion doesn't matter.  The virtual addresses
matter a little more although I am more inclined to teach gdb
about the physical and virtual address differences of whole machine
crash dumps.

I do agree that the ability to tweak things in the short term
to work like a process that does not have the virtual/physical address
distinction is useful.  

The issue of tool versioning problems is bogus.  That is solved
by simply picking a good interface between tools and sticking
with it.  Occasionally there will be paradigm shifts (like threading)
that will cause change, but generally everything will stay the same.
In addition if tools are distributed together it does not matter,
if there are several of them because there is only one update.

Eric
