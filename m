Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWGDV30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWGDV30 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 17:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWGDV30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 17:29:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59101 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751179AbWGDV30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 17:29:26 -0400
Date: Tue, 4 Jul 2006 23:29:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Fabio Comolli <fabio.comolli@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.17-mm5: lockdep prevents suspend to disk
Message-ID: <20060704212910.GA11872@elf.ucw.cz>
References: <b637ec0b0607041258j36007132kdb7dbca1fa8f7dd5@mail.gmail.com> <20060704183244.GB4420@ucw.cz> <20060704210833.GA17961@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704210833.GA17961@elte.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Jul  4 21:48:08 tycho kernel:   rt-test-4
> > > Jul  4 21:48:08 tycho kernel:   rt-test-5
> > > Jul  4 21:48:08 tycho kernel:   rt-test-6
> > > Jul  4 21:48:08 tycho kernel:   rt-test-7
> > 
> > Are rt-test-X tasks kernel threads or userspace programs? (Kernel
> > threads need explicit try_to_freeze in them to allow suspend).
> > 
> > Are they normally killable?
> 
> hm, that's not lockdep but due to CONFIG_RT_MUTEX_TESTER.

I'm pretty sure RT_MUTEX_TESTER is the problem, then. It should either
end its threads when testing is no longer needed, or maybe add
try_to_freeze() somewhere inside so that those threads can be frozen.

(BTW.. some mail from me to you may be severely delayed because of
graylist. I send some mail from zaurus over bt over gprs, and
300second is quite a long time for that...)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
