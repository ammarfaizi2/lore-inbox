Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWG0O77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWG0O77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWG0O77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:59:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21904 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751262AbWG0O77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:59:59 -0400
Date: Thu, 27 Jul 2006 16:59:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz,
       Len Brown <len.brown@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org
Subject: Re: Generic battery interface
Message-ID: <20060727145944.GB3131@elf.ucw.cz>
References: <20060727002035.GA2896@elf.ucw.cz> <20060727140539.GA10835@srcf.ucam.org> <41840b750607270739u7b6fe7efl5ac5ec147d83e624@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607270739u7b6fe7efl5ac5ec147d83e624@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >This would also be useful for the OLPC project - it's unlikely that
> >it'll use ACPI, but a more feature-rich interface than /proc/apm would
> >be massively helpful. This is just a matter of speccing out what
> >information is needed and what format it should be presented in, and
> >then adding a new device class, right?
> 
> Can we really assume there's one driver providing all battery-related
> attributes?

Anything else would be crazy, I'd say.

> For example, on a ThinkPad you want the ACPI battery module loaded so
> that handles hande battery-related ACPI events, but on ACPI can't
> doesn't provide all available attributes. For example, ACPI reports
> the equvialent of
>  /sys/devices/platform/smapi/BAT0/power_avg (last minute average)
> but not
>  /sys/devices/platform/smapi/BAT0/power_now (instantaneous average)
> or
>  /sys/devices/platform/smapi/BAT0/cycle_count
> or control functions like
>  /sys/devices/platform/smapi/BAT0/force_discharge
> (see http://thinkwiki.org/wiki/tp_smapi for detials).

Well, in that case probably smapi driver should "hook into" acpi
driver.

> In this particular case we could split the ACPI module into two, one
> module for events and one module for the sysfs interface, and load
> only the first one on ThinkPads. But that's only because tp_smapi
> happens to reproduce all of ACPI's attributes; there are probably
> other cases whether neither method dominates the other.

I hope such hardware will not be too common. Thinkpad is covered by
accident, and I do not know about any other problematic machine.

Worst case, we would get equivalent of

/sys/class/battery/system_battery_acpi/...
/sys/class/battery/system_battery_some_clever_vendor_hack/...

with some values common between both of them. I'd say it is still
better than having vendor_hack in /sys in one format while having acpi
battery in /proc/acpi in completely different format.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
