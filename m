Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423323AbWJYMLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423323AbWJYMLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 08:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423356AbWJYMLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 08:11:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11747 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423323AbWJYMLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 08:11:39 -0400
Subject: Re: [PATCH v2] Re: Battery class driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Richard Hughes <hughsient@gmail.com>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       David Zeuthen <davidz@redhat.com>
In-Reply-To: <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161631091.16366.0.camel@localhost.localdomain>
	 <1161633509.4994.16.camel@hughsie-laptop>
	 <1161636514.27622.30.camel@shinybook.infradead.org>
	 <1161710328.17816.10.camel@hughsie-laptop>
	 <1161762158.27622.72.camel@shinybook.infradead.org>
	 <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 15:11:35 +0300
Message-Id: <1161778296.27622.85.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-25 at 11:54 +0200, Shem Multinymous wrote:
> What about current and power? These change very quickly.

I don't think we'd want to generate events for those, except perhaps if
they exceed certain thresholds.

> BTW, your patch doesn't address the instantaneous vs. average readout
> issue in the Smart Battery Data Specification and ThinkPads. Nor a
> number of other issues I brought up earlier.

True; it's a work-in-progress, and was actually sent just as I was
boarding a plane. I shall attempt to go back through the messages I've
received and address anything else that's pending.

If you can summarise the bits I've missed in the meantime that would be 
wonderfully useful -- especially if you could do so in 'diff -u' form :)

> > one of the things I plan is to remove 'charge_units' and provide both
> > 'design_charge' and 'design_energy' (also {energy,charge}_last,
> > _*_thresh etc.) to cover the mWh vs. mAh cases.
> 
> You can't do this conversion, since the voltage is not constant.
> Typically the voltage drops when the charge goes down, so you'll be
> grossly overestimating the available energy it. And the effect varies
> with battery chemistry and condition.

Absolutely. I don't want to do the conversion -- I want to present the
raw data. I was just a question of whether I provide 'capacity' and
'units' properties, or whether I provide 'capacity_mWh' and
'capacity_mAh' properties (only one of which, presumably, would be
available for any given battery). Likewise for the rates, thresholds,
etc.

> > I'd rather show it as a hex value 'flags' than
> > split it up. But I still think that the current 'present,charging,low'
> > is best.
> 
> Then please make space-separated rather than comma-separated. That's
> easier to parse in shell and C.

Ok. Committed to git://git.infradead.org/battery-2.6.git

-- 
dwmw2

