Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752449AbWKAV1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbWKAV1p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752452AbWKAV1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:27:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24038 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752449AbWKAV1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:27:44 -0500
Date: Wed, 1 Nov 2006 22:27:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Greg KH <greg@kroah.com>, David Zeuthen <davidz@redhat.com>,
       Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061101212720.GA2893@elf.ucw.cz>
References: <1161815138.27622.139.camel@shinybook.infradead.org> <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com> <1162037754.19446.502.camel@pmac.infradead.org> <1162041726.16799.1.camel@hughsie-laptop> <1162048148.2723.61.camel@zelda.fubar.dk> <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com> <20061031074946.GA7906@kroah.com> <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com> <20061101193134.GB29929@kroah.com> <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> The suggestions so far were:
> >> 1. Append units string to the content of such attribute:
> >>   /sys/.../capacity_remaining reads "16495 mW".
> >> 2. Add a seprate *_units attribute saying what are units for other
> >> attribute:
> >>   /sys/.../capacity_units gives the units for
> >>   /sys/.../capacity_{remaining,last_full,design,min,...}.
> >> 3. Append the units to the attribute names:
> >>   capacity_{remaining,last_full,design_min,...}:mV.
> >
> >No, again, one for power and one for current.  Two different files
> >depending on the type of battery present.  That way there is no need to
> >worry about unit issues.
> 
> I'm missing something. How is that different from option 3 above?
> BTW, please note that we're talking about a large set of files that
> use these units (remaining, last full, design capacity, alarm
> thresholds, etc.), and not just a single attribute.
> 
> This particular alternative indeed seems cleanest for the kernel side.
> The drawback is that someone in userspace who doesn't care about units
> but just wants to show a status report or compute the amount of
> remaining fooergy divided by the amount of a fooergy when fully
> charged, like your typical battery applet, will need to parse
> filenames (or try out a fixed and possibly partial list) to find out
> which attribute files contain the numbers.

That's okay, we want userspace to use common library, and doing

echo $[`cat capacity_remaining:*` / `cat capacity_total:*`]

is not exactly rocket science. If greg does not like units suffixes,
that's okay, too, I'm sure handy wildcard match will be possible.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
