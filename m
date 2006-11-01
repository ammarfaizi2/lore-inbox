Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752374AbWKAUx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbWKAUx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbWKAUx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:53:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:44928 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752369AbWKAUxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:53:55 -0500
Date: Wed, 1 Nov 2006 12:53:30 -0800
From: Greg KH <greg@kroah.com>
To: Shem Multinymous <multinymous@gmail.com>
Cc: David Zeuthen <davidz@redhat.com>, Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>, Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061101205330.GA2593@kroah.com>
References: <1161815138.27622.139.camel@shinybook.infradead.org> <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com> <1162037754.19446.502.camel@pmac.infradead.org> <1162041726.16799.1.camel@hughsie-laptop> <1162048148.2723.61.camel@zelda.fubar.dk> <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com> <20061031074946.GA7906@kroah.com> <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com> <20061101193134.GB29929@kroah.com> <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 09:53:12PM +0200, Shem Multinymous wrote:
> Hi Greg,
> 
> On 11/1/06, Greg KH <greg@kroah.com> wrote:
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

No silly ":mV" on the file name.

> BTW, please note that we're talking about a large set of files that
> use these units (remaining, last full, design capacity, alarm
> thresholds, etc.), and not just a single attribute.

Sure, what's wrong with:
	capacity_remaining_power
	capacity_last_full_power
	capacity_design_min_power
if you can read that from the battery, and:
	capacity_remaining_current
	capacity_last_full_current
	capacity_design_min_current
if you can read that instead.

> This particular alternative indeed seems cleanest for the kernel side.
> The drawback is that someone in userspace who doesn't care about units
> but just wants to show a status report or compute the amount of
> remaining fooergy divided by the amount of a fooergy when fully
> charged, like your typical battery applet, will need to parse
> filenames (or try out a fixed and possibly partial list) to find out
> which attribute files contain the numbers.

If the file isn't there, they the attribute isn't present.  It doesn't
get easier than that.

And of course user apps will have to change, but only once.  And then
they will work with all types of batterys, unlike today.

thanks,

greg k-h
