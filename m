Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWG0XMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWG0XMY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 19:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWG0XMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 19:12:24 -0400
Received: from ns2.suse.de ([195.135.220.15]:50867 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751424AbWG0XMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 19:12:23 -0400
Date: Thu, 27 Jul 2006 16:08:01 -0700
From: Greg KH <greg@kroah.com>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060727230801.GA30619@kroah.com>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <20060727221632.GE3797@elf.ucw.cz> <41840b750607271556n1901af3by2e4d046d68abcb94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607271556n1901af3by2e4d046d68abcb94@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 01:56:03AM +0300, Shem Multinymous wrote:
> On 7/28/06, Pavel Machek <pavel@suse.cz> wrote:
> >+ perhaps it would not need explicit maintainer, just assign names
> >        carefully
> 
> We also need to decide on clear convention about units. Are they in
> the output and/or filename? Filename is best, I think, since it's
> impossible to miss and works nicely for input attributes too.

Actually, this whole thing could probably just go under the 'hwmon'
interface, as it already handles other hardware monitoring events.  I
don't see how a battery would be any different, do you?

> >- does not suit PC-style batteries which trigger events when data
> >        change (can be fixed by /sys/XXX/anything-new, which gives one
> >        byte when something changes)
> 
> Changed since last poll? That doesn't work with multiple clients.
> Changed for the last X seconds? That requires everybody to poll that
> frequenty, and risks missing events due to system load.

Again, look at the hwmon documentation, they handle alarms and other
things already that you are trying to re-invent.

> Wild thought: how about adding a generic "event source" mechanism into
> sysfs, at the same level as attributes? Maybe even make them textual,
> in keeping with sysfs philosophy:
> 
> while read TYPE PARAM  < /sys/class/battery/BAT0/criticl_events; do
>  echo "battery 0 generated ctitical event $TYPE with parameters $PARAM"
> done

Heh, no, the file should specify the units, and then you document it.
Much simpler.

> The simpler solution is to convert events into state (e.g.,
> critical=0/1) and present them as normal attributes which userspace
> can poll, as Greg KH suggested (did I get that right?).

Yes, just like temperature events today.

People have asked for the "this sysfs file's value changed" type uevent
message to come back, so that's also an option that might be used here.

thanks,

greg k-h
