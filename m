Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268487AbUHQWh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268487AbUHQWh1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268486AbUHQWh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:37:27 -0400
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:12416 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268487AbUHQWhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:37:24 -0400
Date: Wed, 18 Aug 2004 00:37:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
       benh@kernel.crashing.org, david-b@pacbell.net
Subject: Re: [patch] enums to clear suspend-state confusion
Message-ID: <20040817223700.GA15046@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz> <20040817212510.GA744@elf.ucw.cz> <20040817152742.17d3449d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817152742.17d3449d.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > I'd like this to be applied, so I can start fixing the drivers...
> 
> Sure, let's try to get this done.
> 
> > +static inline enum pci_state to_pci_state(suspend_state_t state)
> > +{
> > +	if (SUSPEND_EQ(state, PM_SUSPEND_ON))
> > +		return PCI_D0;
> > +	if (SUSPEND_EQ(state, PM_SUSPEND_STANDBY))
> > +		return PCI_D1;
> > +	if (SUSPEND_EQ(state, PM_SUSPEND_MEM))
> > +		return PCI_D3hot;
> > +	if (SUSPEND_EQ(state, PM_SUSPEND_DISK))
> > +		return PCI_D3cold;
> > +	BUG();
> > +	return PCI_D0;	/* akpm complained about warnings? */
> > +}
> > +
> > ...
> > +/*
> > + * For now, drivers only get system state. Later, this is going to become
> > + * structure or something to enable runtime power managment.
> > + */
> > +typedef enum system_state suspend_state_t;
> > +
> > +#define SUSPEND_EQ(a, b) (a == b)
> > +
> >  enum {
> >  	PM_DISK_FIRMWARE = 1,
> >  	PM_DISK_PLATFORM,
> 
> This is a bit ugly, and I don't think it actually works.

I agree about the ugly bit :-(.

> If, at some time in the future you change the suspend state to a struct
> then you will want to pass that thing around by reference, not by
> value. 

Actually I expect it to become struct of two members, system-state and
bus-specific state. That seems small enough to pass by value.

> Hence your new suspend_state_t will need to be typecast to a pointer to
> struct, and not a struct.  And that's not a thing which we do in-kernel
> much at all.  (There's nothing wrong with the practice per-se, but in the
> kernel it does violate the principle of least surprise).
> 
> So if you really do intend to add more things to the suspend state I'd
> suggest that you set the final framework in place immediately.  Do:
> 
> struct suspend_state {
> 	enum system_state state;
> }

I can do that... but it will break compilation of every driver in the
tree. I can fix drivers I use and try to fix some more will sed, but
it will be painfull (and pretty big diff, and I'll probably miss some).

Should I do that?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
