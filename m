Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWG0MY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWG0MY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 08:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWG0MY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 08:24:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49319 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750838AbWG0MY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 08:24:28 -0400
Date: Thu, 27 Jul 2006 02:20:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: vojtech@suse.cz, Len Brown <len.brown@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: linux-thinkpad@linux-thinkpad.org, multinymous@gmail.com
Subject: Generic battery interface
Message-ID: <20060727002035.GA2896@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(Vojtech and other thinkpad users: look at tp_smapi package; it
includes stuff like "do not charge battery unless it is below 90%",
which should make your battery last few more years).

(I'll still need to test it on x60, sorry).

Anyway, unlike acpi, tp_smapi uses some reasonably-nice
one-value-per-file sysfs interface. I have few objections:

0) it needs to move to /sys/class/battery/tp_smapi or something like
that
 
1) it probably should not include units in the files (hard to parse,
and someone may have great idea to choose different units)

2) some optional method for battery applets to avoid polling would be
nice (OTOH tp_smapi probably does not support notifications, so it is
not its fault)

3) some fields look almost too specialized, but if hardware supports
them, I guess we should export them, too...

...but otherwise it looks very good, certainly better than
alternatives. Perhaps we should make something like this "generic"
battery interface?

Good description is at
http://thinkwiki.org/wiki/Tp_smapi#Installation_from_source , and to
give you a quick example:

# cat /sys/devices/platform/smapi/BAT0/installed
# cat /sys/devices/platform/smapi/BAT0/state       # idle/charging/discharging
# cat /sys/devices/platform/smapi/BAT0/cycle_count 
# cat /sys/devices/platform/smapi/BAT0/current_now # instantaneous  current
# cat /sys/devices/platform/smapi/BAT0/current_avg # last minute average
# cat /sys/devices/platform/smapi/BAT0/power_now   # instantaneous  power
# cat /sys/devices/platform/smapi/BAT0/power_avg   # last minute  average
# cat /sys/devices/platform/smapi/BAT0/last_full_capacity
# cat /sys/devices/platform/smapi/BAT0/remaining_capacity
# cat /sys/devices/platform/smapi/BAT0/design_capacity
# cat /sys/devices/platform/smapi/BAT0/voltage
# cat /sys/devices/platform/smapi/BAT0/design_voltage
# cat /sys/devices/platform/smapi/BAT0/manufacturer
# cat /sys/devices/platform/smapi/BAT0/model
# cat /sys/devices/platform/smapi/BAT0/barcoding
# cat /sys/devices/platform/smapi/BAT0/chemistry
# cat /sys/devices/platform/smapi/BAT0/serial
# cat /sys/devices/platform/smapi/BAT0/manufacture_date
# cat /sys/devices/platform/smapi/BAT0/first_use_date
# cat /sys/devices/platform/smapi/ac_connected

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
