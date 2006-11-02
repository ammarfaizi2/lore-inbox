Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752635AbWKBDp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbWKBDp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 22:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbWKBDp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 22:45:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:1691 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752635AbWKBDp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 22:45:26 -0500
Date: Wed, 1 Nov 2006 19:45:08 -0800
From: Greg KH <greg@kroah.com>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Shem Multinymous <multinymous@gmail.com>,
       David Zeuthen <davidz@redhat.com>, Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>, Jean Delvare <khali@linux-fr.org>
Subject: Re: [ltp] Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061102034508.GA30730@kroah.com>
References: <1162037754.19446.502.camel@pmac.infradead.org> <1162041726.16799.1.camel@hughsie-laptop> <1162048148.2723.61.camel@zelda.fubar.dk> <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com> <20061031074946.GA7906@kroah.com> <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com> <20061101193134.GB29929@kroah.com> <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com> <20061101205330.GA2593@kroah.com> <20061101235540.GA11581@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101235540.GA11581@khazad-dum.debian.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 08:55:40PM -0300, Henrique de Moraes Holschuh wrote:
> On Wed, 01 Nov 2006, Greg KH wrote:
> > On Wed, Nov 01, 2006 at 09:53:12PM +0200, Shem Multinymous wrote:
> > > Hi Greg,
> > > 
> > > On 11/1/06, Greg KH <greg@kroah.com> wrote:
> > > >> The suggestions so far were:
> > > >> 1. Append units string to the content of such attribute:
> > > >>   /sys/.../capacity_remaining reads "16495 mW".
> > > >> 2. Add a seprate *_units attribute saying what are units for other
> > > >> attribute:
> > > >>   /sys/.../capacity_units gives the units for
> > > >>   /sys/.../capacity_{remaining,last_full,design,min,...}.
> > > >> 3. Append the units to the attribute names:
> > > >>   capacity_{remaining,last_full,design_min,...}:mV.
> > > >
> > > >No, again, one for power and one for current.  Two different files
> > > >depending on the type of battery present.  That way there is no need to
> > > >worry about unit issues.
> > > 
> > > I'm missing something. How is that different from option 3 above?
> > 
> > No silly ":mV" on the file name.
> 
> As long as that also means no "silly _mV" in the name.  However, if the
> choice is between :mV and _mV, please go with :mV.

Neither should be in the name.

Again, people, look how we already do this in the kernel today with the
hwmon drivers.  They all just document the units and that's it.  No
problems.

> > > BTW, please note that we're talking about a large set of files that
> > > use these units (remaining, last full, design capacity, alarm
> > > thresholds, etc.), and not just a single attribute.
> > 
> > Sure, what's wrong with:
> > 	capacity_remaining_power
> > 	capacity_last_full_power
> > 	capacity_design_min_power
> > if you can read that from the battery, and:
> > 	capacity_remaining_current
> > 	capacity_last_full_current
> > 	capacity_design_min_current
> > if you can read that instead.
> 
> Well, "Wh" measures energy and not power, and "Ah" measures electric charge
> and not current, so it would be better to make that:
> 
> capacity_*_energy  (Wh-based)
> 
> and
> 
> capacity_*_charge  (Ah-based)

Ok, that's fine with me.

> Also, should we go with mWh/mAh, or with even smaller units because of the
> tiny battery-driven devices of tomorrow?

Well, what do the tiny battery-driven devices of today provide (like the
Nokia 770, other cell phones, smart hand-helds, etc.)  Those should give
you a good idea if that would be needed or not.

thanks,

greg k-h
