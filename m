Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWAFAE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWAFAE2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWAFAE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:04:27 -0500
Received: from digitalimplant.org ([64.62.235.95]:33954 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932303AbWAFAEX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:04:23 -0500
Date: Thu, 5 Jan 2006 16:04:07 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
In-Reply-To: <20060105235838.GC3339@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net>
References: <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net>
 <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net>
 <20060105215528.GF2095@elf.ucw.cz> <20060105221334.GA925@isilmar.linta.de>
 <20060105222338.GG2095@elf.ucw.cz> <20060105222705.GA12242@isilmar.linta.de>
 <20060105230849.GN2095@elf.ucw.cz> <20060105234629.GA7298@isilmar.linta.de>
 <20060105235838.GC3339@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Jan 2006, Pavel Machek wrote:

> On Pá 06-01-06 00:46:29, Dominik Brodowski wrote:
> > On Fri, Jan 06, 2006 at 12:08:49AM +0100, Pavel Machek wrote:
> > > Ok, so lets at least add value-checking to .../power file, and prevent
> > > userspace see changes to PM_EVENT_SUSPEND value. 2 and 0 are now
> > > "arbitrary cookies". I'd like to use "on" and "off", but pcmcia
> > > apparently depends on "2" and "0", so...
> > >
> > > Any objections?
> >
> > Sorry, but yes -- the same as before, minus the PCMCIA breakage.
>
> I don't understand at this point.
>
> Current code takes value from user, and passes it down to driver,
> without any checking. If user writes 666 into the file, it will
> happily pass down 666 to the driver. Driver does not expect 666 in
> pm_message_t.event. It may oops, BUG_ON() or anything like that.
>
> Shall I change
>
> #define PM_EVENT_SUSPEND 2
>
> to
>
> #define PM_EVENT_SUSPEND 1324
>
> to get my point across? This is kernel-specific value, it should not
> be exported to userland.

A better point, and one that would actually be useful, would be to remove
the file altogether. Let Dominik export a power file, with complete
control over the values, for each pcmcia device. Then you never have to
worry about breaking PCMCIA again.

Thanks,


	Patrick

