Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946428AbWKJLLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946428AbWKJLLw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 06:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946446AbWKJLLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 06:11:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28865 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946428AbWKJLLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 06:11:52 -0500
Date: Fri, 10 Nov 2006 12:11:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Gleixner <tglx@linutronix.de>, vojtech@suse.cz, jbohac@suse.cz
Cc: Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Message-ID: <20061110111134.GA3291@elf.ucw.cz>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <20061109233035.569684000@cruncher.tec.linutronix.de> <1163121045.836.69.camel@localhost> <200611100610.13957.ak@suse.de> <1163146206.8335.183.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163146206.8335.183.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoj!

Tahle debata (lkml) by se Vam mohla hodit...
								Pavel

On Fri 2006-11-10 09:10:06, Thomas Gleixner wrote:
> On Fri, 2006-11-10 at 06:10 +0100, Andi Kleen wrote:
> > > >  		verify_tsc_freq_timer.function = verify_tsc_freq;
> > > >  		verify_tsc_freq_timer.expires =
> > > 
> > > 
> > > Hmmm. I wish this patch was unnecessary, but I don't see an easy
> > > solution. 
> > 
> > Very sad. This will make a lot of people unhappy, even to the point
> > where they might prefer disabling noidlehz over super slow gettimeofday. 
> > I assume you at least have a suitable command line option for that, right?
> 
> Yes it is sad. And the sadest part is that AMD and Intel have been asked
> to fix that more than 5 years ago. They did not get their brain straight
> and now we are the dimwits.
> 
> > Can we get a summary on which systems the TSC is considered unstable?
> > Normally we assume if it's stable enough for gettimeofday it should
> > be stable enough for longer delays too.
> 
> TSC is simply a nightmare:
> 
> - Frequency changes with CPU clock
> - Unsynced across CPUs
> - Stops in C3, which makes it completely unusable
> 
> Once you take away periodic interrupts it is simply broken. AMD and
> Intel can run in circels, it does not get better.
> 
> 	tglx
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
