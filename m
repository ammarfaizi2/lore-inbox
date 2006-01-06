Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWAFLlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWAFLlw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 06:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWAFLlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 06:41:52 -0500
Received: from [218.25.172.144] ([218.25.172.144]:19465 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S964901AbWAFLlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 06:41:50 -0500
Date: Fri, 6 Jan 2006 19:41:43 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dave Jones <davej@redhat.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org, rms@gnu.org, torvalds@osdl.org
Subject: Re: Add tainting for proprietary helper modules.
Message-ID: <20060106114143.GA9046@localhost.localdomain>
References: <20051203004102.GA2923@redhat.com> <Pine.LNX.4.61.0512050832290.27133@chaos.analogic.com> <20051205173041.GE12664@redhat.com> <20060106094933.GB2807@localhost.localdomain> <Pine.LNX.4.61.0601061139560.30781@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601061139560.30781@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 11:46:10AM +0100, Jan Engelhardt wrote:
> 
> >>  > > Kernels that have had Windows drivers loaded into them are undebuggable.
> >>  > > I've wasted a number of hours chasing bugs filed in Fedora bugzilla
> >>  > > only to find out much later that the user had used such 'helpers',
> >>  > > and their problems were unreproducable without them loaded.
> >>  > >
> >>  > > Acked-by: Arjan van de Ven <arjan@infradead.org>
> >>  > > Signed-off-by: Dave Jones <davej@redhat.com>
> >>  > >
> >>  > > --- linux-2.6.14/kernel/module.c~	2005-11-29 16:44:00.000000000 -0500
> >>  > > +++ linux-2.6.14/kernel/module.c	2005-11-29 17:03:55.000000000 -0500
> >>  > > @@ -1723,6 +1723,11 @@ static struct module *load_module(void _
> >>  > > 	/* Set up license info based on the info section */
> >>  > > 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
> >>  > >
> >>  > > +	if (strcmp(mod->name, "ndiswrapper") == 0)
> >>  > > +		add_taint(TAINT_PROPRIETARY_MODULE);
> >>  > > +	if (strcmp(mod->name, "driverloader") == 0)
> >>  > > +		add_taint(TAINT_PROPRIETARY_MODULE);
> >>  > > +
> >>  > > #ifdef CONFIG_MODULE_UNLOAD
> >>  > > 	/* Set up MODINFO_ATTR fields */
> >>  > > 	setup_modinfo(mod, sechdrs, infoindex);
> 
> (That's like putting the PCI name device database back in.)
> 
> 
> >You've hard-coded some module names, that itself `taints' the
> >kernel source IMO.  Blacklisting in kernel is both ugly and unacceptable.
> >
> >I agree that it would be convenient for you to only check if there's `Not tainted' in oops messages.  But I still suggest you to not hard-code them in the
> >kernel source.  Instead you could use some script to grep the problematic module
> >names in the `Modules linked in' field.
> >
> >For the long run, we could:
> >
> >1) Add some other mechanism, like MODULE_LICENSE_STRICT("GPL.strict").
> >
> >   GPL.strict:  A GPL.strict module is not only itself licensed under GPL,
> >   but it shall not load/link any binary code (specially non-gpl binaries)
> >   nor any non-GPL.strict code. This definition goes recursively.
> >
> 
> How are you going to verify that, how do you want to distinguish whether a
> certain byte range in memory (possibly beloaded with a windows driver) is prop
> or not?

Simple, I don't verify that.  But I know if a program is capable to link some
binary to itself, this program is no longer gpl.strict.  Whether it loads prop
or not depends on the user.  But at the time the author writes such programs,
the risk is open.

These binary-linking programs, under a gpl disguise, may look innocent, but they
are especially dangerous to the free world.  We need gpl.strict to keep away
from them.

-- 
Coywolf Qi Hunt
