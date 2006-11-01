Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992748AbWKATcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992748AbWKATcJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 14:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992750AbWKATcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 14:32:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:11216 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S2992748AbWKATcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 14:32:06 -0500
Date: Wed, 1 Nov 2006 11:31:34 -0800
From: Greg KH <greg@kroah.com>
To: Shem Multinymous <multinymous@gmail.com>
Cc: David Zeuthen <davidz@redhat.com>, Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>, Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061101193134.GB29929@kroah.com>
References: <1161778296.27622.85.camel@shinybook.infradead.org> <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com> <1161815138.27622.139.camel@shinybook.infradead.org> <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com> <1162037754.19446.502.camel@pmac.infradead.org> <1162041726.16799.1.camel@hughsie-laptop> <1162048148.2723.61.camel@zelda.fubar.dk> <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com> <20061031074946.GA7906@kroah.com> <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 03:28:27PM +0200, Shem Multinymous wrote:
> Hi Greg,
> 
> On 10/31/06, Greg KH <greg@kroah.com> wrote:
> >> On 10/28/06, David Zeuthen <davidz@redhat.com> wrote:
> >> >What about just prepending the unit to the 'threshold' file? Then user
> >> >space can expect the contents of said file to be of the form "%d %s". I
> >> >don't think that violates the "only one value per file" sysfs mantra.
> >>
> >> The tp_smapi battery driver did just this  ("16495 mW"). But I dropped
> >> it in a recent version when Pavel pointed out the rest of sysfs, hwmon
> >> included, uses undecorated integers.
> >> Consistency aside, it seems reasonable and convenient. You have to
> >> decree that writes to the attributes (where relevant) don't include
> >> the units, of course, so no one will expect the kernel to parse that.
> >>
> >> There's an issue here if a drunk driver decides to specify (say)
> >> capacity_remaining in mWh and capacity_last_full in mAa, which will
> >> confuse anyone comparing those attributest. So don't do that.
> >>
> >> Jean, what's your opinion on letting hwmon-ish attributes specify
> >> units as "%d %s" where these are hardware-dependent?
> >
> >No, the sysfs files should just always keep the same units as
> >documented.  It's easier all around that way.
> 
> It sure is easier, but we're discussinng the case where units change
> in runtime; what do we document then? Plug in a different battery and
> you get reports in mA and mAh  insted of mW and mWh.

Then you should just get different sysfs files then.  One that describes
power and one that describes current.

> The suggestions so far were:
> 1. Append units string to the content of such attribute:
>   /sys/.../capacity_remaining reads "16495 mW".
> 2. Add a seprate *_units attribute saying what are units for other 
> attribute:
>   /sys/.../capacity_units gives the units for
>   /sys/.../capacity_{remaining,last_full,design,min,...}.
> 3. Append the units to the attribute names:
>   capacity_{remaining,last_full,design_min,...}:mV.

No, again, one for power and one for current.  Two different files
depending on the type of battery present.  That way there is no need to
worry about unit issues.

thanks,

greg k-h
