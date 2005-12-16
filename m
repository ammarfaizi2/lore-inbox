Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVLPV7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVLPV7Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVLPV7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:59:24 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:23500
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932496AbVLPV7X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:59:23 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Linus Torvalds <torvalds@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>, matthew@wil.cx,
       arjan@infradead.org, Christoph Hellwig <hch@infradead.org>,
       mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       nikita@clusterfs.com, pj@sgi.com, dhowells@redhat.com
In-Reply-To: <Pine.LNX.4.64.0512161339140.3698@g5.osdl.org>
References: <20051215085602.c98f22ef.pj@sgi.com>
	 <20051213143147.d2a57fb3.pj@sgi.com> <20051213075441.GB6765@elte.hu>
	 <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu>
	 <20051213100015.GA32194@elte.hu>
	 <6281.1134498864@warthog.cambridge.redhat.com>
	 <14242.1134558772@warthog.cambridge.redhat.com>
	 <16315.1134563707@warthog.cambridge.redhat.com>
	 <1134568731.4275.4.camel@tglx.tec.linutronix.de> <43A0AD54.6050109@rtr.ca>
	 <20051214155432.320f2950.akpm@osdl.org>
	 <17313.29296.170999.539035@gargle.gargle.HOWL>
	 <1134658579.12421.59.camel@localhost.localdomain>
	 <4743.1134662116@warthog.cambridge.redhat.com>
	 <7140.1134667736@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.64.0512150945410.3292@g5.osdl.org>
	 <20051215112115.7c4bfbea.akpm@osdl.org>
	 <1134678532.13138.44.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0512152130390.16426@pademelon.sonytel.be>
	 <1134769269.2806.17.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.64.0512161339140.3698@g5.osdl.org>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 16 Dec 2005 23:06:18 +0100
Message-Id: <1134770778.2806.31.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 13:41 -0800, Linus Torvalds wrote:
> 
> > > No one. It's not really a mutex, but a completion.
> > 
> > Well, then let us use a completion and not some semantically wrong
> > workaround
> 
> It is _not_ wrong to have a semaphore start out in locked state.
> 
> For example, it makes perfect sense if the data structures that the 
> semaphore needs need initialization. The way you _should_ handle that is 
> to make the semaphore come up as locked, and the data structures in some 
> "don't matter" state, and then the thing that initializes stuff can do so 
> properly and then release the semaphore.
> 
> Yes, in some cases such a locked semaphore is only used once, and ends up 
> being a "completion", but that doesn't invalidate the fact that this is 
> a perfectly fine way to handle a real issue.

Well, in case of a semaphore it is a semantically correct use case. In
case of of a mutex it is not.

Gerd was talking about a mutex. The fact that a mutex is implemented on
top (or on actually the same) mechanism as a semaphore - for what ever
reason - does not change the semantical difference between semaphores
and mutexes.

	tglx


