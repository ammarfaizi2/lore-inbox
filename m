Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWGDWC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWGDWC5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 18:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWGDWC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 18:02:57 -0400
Received: from www.osadl.org ([213.239.205.134]:60631 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932306AbWGDWC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 18:02:56 -0400
Subject: Re: 2.6.17-mm5: lockdep prevents suspend to disk
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Fabio Comolli <fabio.comolli@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <20060704212910.GA11872@elf.ucw.cz>
References: <b637ec0b0607041258j36007132kdb7dbca1fa8f7dd5@mail.gmail.com>
	 <20060704183244.GB4420@ucw.cz> <20060704210833.GA17961@elte.hu>
	 <20060704212910.GA11872@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 00:05:28 +0200
Message-Id: <1152050728.24611.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 23:29 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > Jul  4 21:48:08 tycho kernel:   rt-test-4
> > > > Jul  4 21:48:08 tycho kernel:   rt-test-5
> > > > Jul  4 21:48:08 tycho kernel:   rt-test-6
> > > > Jul  4 21:48:08 tycho kernel:   rt-test-7
> > > 
> > > Are rt-test-X tasks kernel threads or userspace programs? (Kernel
> > > threads need explicit try_to_freeze in them to allow suspend).
> > > 
> > > Are they normally killable?
> > 
> > hm, that's not lockdep but due to CONFIG_RT_MUTEX_TESTER.
> 
> I'm pretty sure RT_MUTEX_TESTER is the problem, then. It should either
> end its threads when testing is no longer needed, or maybe add

The tests are stimulated from userspace, we need the kernel threads to
test the correctness of the PI bits in the kernel. So we don't know when
the tests are done.

> try_to_freeze() somewhere inside so that those threads can be frozen.

will look into it tomorrow.

	tglx


