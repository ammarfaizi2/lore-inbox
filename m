Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWJXDlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWJXDlt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 23:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWJXDlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 23:41:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:22223 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965077AbWJXDlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 23:41:46 -0400
Subject: Re: Battery class driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Richard Hughes <hughsient@gmail.com>
Cc: Dan Williams <dcbw@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, David Zeuthen <davidz@redhat.com>
In-Reply-To: <1161633509.4994.16.camel@hughsie-laptop>
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161631091.16366.0.camel@localhost.localdomain>
	 <1161633509.4994.16.camel@hughsie-laptop>
Content-Type: text/plain; charset=utf-8
Date: Tue, 24 Oct 2006 13:41:27 +1000
Message-Id: <1161661288.10524.542.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, I think the distinction between batteries and ac_adapter is large
> enough to have different classes of devices. You may have many
> batteries, but you'll only ever have one ac_adapter. I'm not sure it's
> an obvious abstraction to make.

No you won't :) You can have several power supplies, you can have UPS
too, and limited power budget depending on the "status" of these things
(for example, on some blades, we slow things down when one of the power
supply fails to limit our load on the remaining one(s), though that's
currently done outside of linux).

Ben.

> > > Comments? 
> 
> How are battery change notifications delivered to userspace? I know acpi
> is using the input layer for buttons in the future (very sane IMO), so
> using sysfs events for each property changing would probably be nice.
> 
> Comments on your patch:
> 
> > +#define BAT_INFO_TEMP2		(2) /* °C/1000 */
> Temperature expressed in degrees C/1000? - what if the temperature goes
> below 0? What about just using mK (kelvin / 1000) - I don't know what is
> used in the kernel elsewhere tho. Also, are you allowed the ° sign in
> kernel source now?
> 
> > +#define BAT_INFO_CURRENT	(6) /* mA */
> Can't this also be expressed in mW according to the ACPI spec?
> 
> > +#define BAT_STAT_FIRE		(1<<7)
> I know there is precedent for "FIRE" but maybe CRITICAL or DANGER might
> be better chosen words. We can reserve the word FIRE for when the faulty
> battery really is going to explode...
> 
> Richard.
> 
> > > commit 42fe507a262b2a2879ca62740c5312778ae78627
> > > Author: David Woodhouse <dwmw2@infradead.org>
> > > Date:   Mon Oct 23 18:14:54 2006 +0100
> > > 
> > >     [BATTERY] Add support for OLPC battery
> > >     
> > >     Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> > > 
> > > commit 6cbec3b84e3ce737b4217788841ea10a28a5e340
> > > Author: David Woodhouse <dwmw2@infradead.org>
> > > Date:   Mon Oct 23 18:14:14 2006 +0100
> > > 
> > >     [BATTERY] Add initial implementation of battery class
> > >     
> > >     I really don't like the sysfs interaction, and I don't much like the
> > >     internal interaction with the battery drivers either. In fact, there
> > >     isn't much I _do_ like, but it's good enough as a straw man.
> > >     
> > >     Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 

