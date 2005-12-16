Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbVLPVm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVLPVm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVLPVm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:42:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932496AbVLPVm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:42:28 -0500
Date: Fri, 16 Dec 2005 13:41:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>, matthew@wil.cx,
       arjan@infradead.org, Christoph Hellwig <hch@infradead.org>,
       mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       nikita@clusterfs.com, pj@sgi.com, dhowells@redhat.com
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
In-Reply-To: <1134769269.2806.17.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.64.0512161339140.3698@g5.osdl.org>
References: <20051215085602.c98f22ef.pj@sgi.com>  <20051213143147.d2a57fb3.pj@sgi.com>
 <20051213075441.GB6765@elte.hu>  <20051213090219.GA27857@infradead.org>
 <20051213093949.GC26097@elte.hu>  <20051213100015.GA32194@elte.hu> 
 <6281.1134498864@warthog.cambridge.redhat.com>  <14242.1134558772@warthog.cambridge.redhat.com>
  <16315.1134563707@warthog.cambridge.redhat.com>  <1134568731.4275.4.camel@tglx.tec.linutronix.de>
 <43A0AD54.6050109@rtr.ca>  <20051214155432.320f2950.akpm@osdl.org> 
 <17313.29296.170999.539035@gargle.gargle.HOWL>  <1134658579.12421.59.camel@localhost.localdomain>
  <4743.1134662116@warthog.cambridge.redhat.com>  <7140.1134667736@warthog.cambridge.redhat.com>
  <Pine.LNX.4.64.0512150945410.3292@g5.osdl.org>  <20051215112115.7c4bfbea.akpm@osdl.org>
  <1134678532.13138.44.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0512152130390.16426@pademelon.sonytel.be>
 <1134769269.2806.17.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Dec 2005, Thomas Gleixner wrote:

> On Thu, 2005-12-15 at 21:32 +0100, Geert Uytterhoeven wrote:
> > > Why have the "MUTEX" part in there?  Shouldn't that just be DECLARE_SEM
> > > (oops, I mean DEFINE_SEM).  Especially that MUTEX_LOCKED! What is that?
> > > How does a MUTEX start off as locked.  It can't, since a mutex must
> > > always have an owner (which, by the way, helped us in the -rt patch to
> > > find our "compat_semaphores").  So who's the owner of a
> > > DEFINE_SEM_MUTEX_LOCKED?
> > 
> > No one. It's not really a mutex, but a completion.
> 
> Well, then let us use a completion and not some semantically wrong
> workaround

It is _not_ wrong to have a semaphore start out in locked state.

For example, it makes perfect sense if the data structures that the 
semaphore needs need initialization. The way you _should_ handle that is 
to make the semaphore come up as locked, and the data structures in some 
"don't matter" state, and then the thing that initializes stuff can do so 
properly and then release the semaphore.

Yes, in some cases such a locked semaphore is only used once, and ends up 
being a "completion", but that doesn't invalidate the fact that this is 
a perfectly fine way to handle a real issue.

		Linus
