Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbVLPWfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVLPWfz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVLPWfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:35:54 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:45004
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964791AbVLPWfw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:35:52 -0500
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
In-Reply-To: <Pine.LNX.4.64.0512161414370.3698@g5.osdl.org>
References: <20051215085602.c98f22ef.pj@sgi.com>
	 <20051213143147.d2a57fb3.pj@sgi.com> <20051213093949.GC26097@elte.hu>
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
	 <1134770778.2806.31.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.64.0512161414370.3698@g5.osdl.org>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 16 Dec 2005 23:42:44 +0100
Message-Id: <1134772964.2806.50.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 14:19 -0800, Linus Torvalds wrote:
> 
> On Fri, 16 Dec 2005, Thomas Gleixner wrote:
> > 
> > Well, in case of a semaphore it is a semantically correct use case. In
> > case of of a mutex it is not.
> 
> I disagree.
> 
> Think of "initialization" as a user. The system starts out initializing 
> stuff, and as such the mutex should start out being held. It's that 
> simple. It _is_ mutual exclusion, with one user being the early bootup 
> state.

Mutual exclusion is available with various semantical characteristics.
If you want to have a particular semantical functionality you have to
chose a variant which fits that need. Arguing that the underlying
mechanism (implemenation) can handle your request is broken by
definition. It can, but it still is semantically wrong.

Mutexes have a well defined semantic of lock ownership, i.e. the thread
which locked a mutex has to unlock it. Semaphores do not have this
semantical requirement.

Therefor, if you want to handle that "init protection" scenario, do not
use a mutex, because the owner can not be defined at compile -
allocation time.

You can still implement (chose a mechanism) a mutex on top - or in case
of lack of priority inheritance or debugging with exactly the same -
mechanism as a semaphore, but this does not change the semantical
difference at all.

	tglx




