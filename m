Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWIVSxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWIVSxQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWIVSxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:53:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62479 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932092AbWIVSxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:53:11 -0400
Date: Fri, 22 Sep 2006 12:33:29 +0000
From: Pavel Machek <pavel@suse.cz>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: prasanna@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, Jes Sorensen <jes@sgi.com>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ltt-dev@shafik.org,
       Martin Bligh <mbligh@google.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Ingo Molnar <mingo@elte.hu>, systemtap@sources.redhat.com,
       systemtap-owner@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
       William Cohen <wcohen@redhat.com>, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060922123329.GC4055@ucw.cz>
References: <20060920010852.GA7469@in.ibm.com> <OFD1A61531.0E2D11C4-ON802571EF.002D4111-802571EF.002DA3BC@uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD1A61531.0E2D11C4-ON802571EF.002D4111-802571EF.002DA3BC@uk.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Very good idea.. However, overwriting the second instruction
> > with a jump could
> > > > be dangerous on preemptible and SMP kernels, because we never
> > know if a thread
> > > > has an IP in any of its contexts that would return exactly at
> > the middle of the
> > > > jump.
> > >
> > > No: on x86 it is the *same* case for all of these even writing an int3.
> > > One byte or a megabyte,
> > >
> > > You MUST ensure that every CPU executes a serializing instruction
> before
> > > it hits code that was modified by another processor. Otherwise you get
> > > CPU errata and the CPU produces results which vendors like to describe
> > > as "undefined".
> >
> > Are you referring to Intel erratum "unsynchronized cross-modifying code"
> > - where it refers to the practice of modifying code on one processor
> > where another has prefetched the unmodified version of the code.
> 
> In the special case of replacing an opcode with int3 that erratum doesn't
> apply. I know that's not in the manuals but it has been confirmed by the
> Intel microarchitecture group. And it's not reasonable to it to be any
> other way.

What about replacing int3 with old instruction (i.e. marker being
deleted)?
							Pavel

-- 
Thanks for all the (sleeping) penguins.
