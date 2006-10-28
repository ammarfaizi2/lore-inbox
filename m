Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWJ1O5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWJ1O5H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 10:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWJ1O5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 10:57:07 -0400
Received: from mx2.redhat.com ([66.187.237.31]:45206 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S1750714AbWJ1O5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 10:57:05 -0400
Subject: Re: [PATCH v2] Re: Battery class driver.
From: David Zeuthen <davidz@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Shem Multinymous <multinymous@gmail.com>,
       Richard Hughes <hughsient@gmail.com>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>
In-Reply-To: <1162046193.19446.521.camel@pmac.infradead.org>
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161710328.17816.10.camel@hughsie-laptop>
	 <1161762158.27622.72.camel@shinybook.infradead.org>
	 <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>
	 <1161778296.27622.85.camel@shinybook.infradead.org>
	 <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com>
	 <1161815138.27622.139.camel@shinybook.infradead.org>
	 <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com>
	 <1162037754.19446.502.camel@pmac.infradead.org>
	 <1162041726.16799.1.camel@hughsie-laptop>
	 <41840b750610280734q212fc138occ152f4a01ef67f5@mail.gmail.com>
	 <1162046193.19446.521.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 10:55:37 -0400
Message-Id: <1162047338.2723.49.camel@zelda.fubar.dk>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-28 at 15:36 +0100, David Woodhouse wrote:
> On Sat, 2006-10-28 at 16:34 +0200, Shem Multinymous wrote:
> > * Thou shalt not export any attributes in sysfs except these, and
> >     with these units: */
> > 
> > Drivers *will* want to violate this. For example, the "inhibit
> > charging for N minutes" command on ThinkPads seems too arcane to be
> > worthy of generalization. I would add a more sensible boolean
> > "charging_inhibit" attribute to battery.h, and let the ThinkPad driver
> > implement it as well as it can. The driver will then expose a
> > non-stadard "charging_inhibit_minutes" attribute to reveal the finer
> > level of access to those who care.
> 
> If it makes enough sense that it's worth exporting it to userspace at
> all, then it can go into battery.h.

If it's non-standard please make sure to prefix the name with something
unique e.g.

 x_thinkpad_charging_inhibit [1]

to avoid collisions, e.g. two drivers using the same name but the
semantics are different. Over time the battery class can standardize on
this (if a feature becomes sufficiently common) and drivers can move
over if they want to.

    David

[1] : The x_ bit is inspired by how non standard email headers are
handled e.g. X-Mailer and whatever. It's a very useful hint to user
space people (and users in general) that some sysfs attribute is
non-standard. I was going to suggest to user a full reverse DNS style
naming scheme but I guess something that is unique enough will do.


