Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWDXUfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWDXUfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWDXUfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:35:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35541 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751240AbWDXUfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:35:18 -0400
Date: Mon, 24 Apr 2006 22:34:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: dtor_core@ameritech.net, Matthew Garrett <mjg59@srcf.ucam.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060424203424.GE3386@elf.ucw.cz>
References: <20060419195356.GA24122@srcf.ucam.org> <20060419200447.GA2459@isilmar.linta.de> <20060419202421.GA24318@srcf.ucam.org> <d120d5000604240745i71bd56b8n99b97130388d36f6@mail.gmail.com> <1145894731.7155.120.camel@localhost.localdomain> <d120d5000604240926u51fc06d6gbf4f23832064e0ad@mail.gmail.com> <1145898341.7155.145.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145898341.7155.145.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ugh... I wonder if we could change SW_0 to report "comletely
> > shut"/"open" and SW_1 to report orientation. Then we could alias SW_0
> > <-> SW_LID, SW_1 <-> SW_TABLET_MODE.
> 
> I've checked which switch is which and SW_0 is equivalent to SW_LID. We
> can just rename them and retain compatibility if:
> 
> SW_0/SW_LID is pressed to indicate shut
> SW_1/SW_TABLET_MODE is pressed to indicate tablet mode
> SW_2/SW_HEADPHONE_DETECT is pressed to indicate headphone jack insertion
> 
> I'm happy to submit a patch to make that change (and remove the as yet
> unused SW_[3-7] if you like?
> 
> I realise there are arguments for having the headphone jack control
> monitoring in the sound driver but this was the nicest way I've found of
> passing the event to user space to deal with. I didn't want to deal with
> it in the sound driver as in this case there is no right answer as to
> what the sound driver should do (we can't detect if it was headphones, a
> speaker + mic headset etc. or just a mic that was inserted yet we can
> support all of them).

Well, it "headset inserted" is a kind of user button...

What is on the jack, BTW? Left headphone, right headphone, mic in? Can
all of them be used independently?

> > > Whilst sort of on the subject (AC power switches and AC power events)
> > > I'd like to see some standard way of exporting power/battery information
> > > to userspace. Currently, the ARM handhelds use kernel emulation of an
> > > APM bios and export the battery info as part of that. Making ARM emulate
> > > ACPI interfaces doesn't appeal. The answer could be a battery sysfs
> > > class and the above system events interface but I'm open to other
> > > suggestions.
> > >
> > 
> > Having generic battery interface would be nice.
> 
> It gets tricky. AC presence isn't a property of a battery for example
> and is in fact more like a switch (my handheld has a mechanical
> switch

Oops, really? Mechanical switch to sense ac in? (What happens when you
plug in charger but that is not plugged to AC?)

I think that AC presence should be handled independently from
battery. There can be >1 battery in the system.

(Another interesting question is: is AC status 0/1 or is it number of
milivolts?)

> to detect when its plugged in) ;). The battery class would export some
> information but not all of it and I don't know where the leftover
> information should go. If I knew that, I'd write the class.

Leftover information?

I think we should create directory in sysfs, and populate it according
to battery's capabilities.

Zaurus' battery would have voltage and maybe percent fields.

ACPI battery would have all the usual fields.

Another important question is a way for user applications to avoid
polling... but I guess that should be solveable by enabling select on
one of those files.
								Pavel
-- 
Thanks for all the (sleeping) penguins.
