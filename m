Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVDAJpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVDAJpu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 04:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVDAJpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 04:45:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25222 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262676AbVDAJp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 04:45:28 -0500
Date: Fri, 1 Apr 2005 11:45:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>, seife@suse.de
Cc: Benoit Boissinot <bboissin@gmail.com>, romano@dea.icai.upco.es,
       dtor_core@ameritech.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: noresume breaks next suspend [was Re: 2.6.12-rc1 swsusp broken]
Message-ID: <20050401094502.GA13017@elf.ucw.cz>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <20050329132022.GA26553@pern.dea.icai.upco.es> <20050329170238.GA8077@pern.dea.icai.upco.es> <20050329181551.GA8125@elf.ucw.cz> <20050331144728.GA21883@pern.dea.icai.upco.es> <d120d5000503310715cbc917@mail.gmail.com> <20050331165007.GA29674@pern.dea.icai.upco.es> <40f323d005033110292934aa1d@mail.gmail.com> <20050331222531.GE1802@elf.ucw.cz> <1112316622.18871.132.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112316622.18871.132.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Yes! With this it works ok.
> > > > 
> > > > > Also, could you please try sticking psmouse_reset(psmouse) call at the
> > > > > beginning of drivers/input/mouse/alps.c::alps_reconnect() and see if
> > > > > it can suspend _without_ the patch above.
> > > >
> > > 
> > > Both patches are working for me (Dell D600). before i was unable to
> > > suspend to disk on this laptop (it was stuck in alps code).
> > > 
> > > By the way, i have an unrelated problem:
> > > if the kernel was booted with the "noresume" option, it cannot be
> > > suspended, it fails with:
> > > 
> > > swsusp: FATAL: cannot find swap device, try swapon -a!
> > 
> > Uh, okay, logic error, probably introduced by resume-from-initrd
> > patch. Does this fix it?
> > 
> > OTOH, perhaps refusing suspend is right thing to do. If user is
> > running in "safe mode" (with noresume), we don't want him to be able
> > to suspend...
> 
> What? If you suspend, then decide not to resume, you can suspend again
> until after your next reboot?!

Yes, in current code. It was a bug. OTOH that means that you can not
suspend from safe mode, and that's good: if you *do* suspend from safe
mode, there's basically no way for you to resume [user *could* select
safe mode next time, and kill noresume, but I don't think many users
will figure that out.]

So I can fix the bug (patch was attached), but that means that it
would be nice to prevent suspend from safe mode in next SuSE... And
probably other distros, too.

(Safe mode is grub setting with noapic noresume....)



								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
