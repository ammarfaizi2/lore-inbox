Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWHZO7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWHZO7d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 10:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWHZO7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 10:59:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53473 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751585AbWHZO7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 10:59:32 -0400
Date: Sat, 26 Aug 2006 16:59:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org, david-b@pacbell.net
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: waking system up using RTC (was Re: rtcwakeup.c)
Message-ID: <20060826145920.GA1826@elf.ucw.cz>
References: <20060725124941.GD5034@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060725124941.GD5034@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > p.s. A followup message will include a userspace program which
> >      makes it easier to try the RTC wakeup mechanism.
> 
> For example, if your system actually supports RTC wakeup correctly:
> 
>         rtcwake -t $(date -u -d 'tomorrow 6:30am' +'%s') -m mem
> 
> will set up the system to wake up tomorrow at 6:30am, then suspend-to-RAM by
> writing "mem" to /sys/power/state.  
> 
> Or for testing kernels, unattended scripts like this may help:
> 
>         while true
>         do
>                 echo "suspend-to-disk for 10 minutes starting $(date)"
>                 rtcwake -s $((10 * 60)) -m disk
>                 sleep 500
>         done
> 
> If there are many RTC utilities out there that aren't x86-specific, I didn't
> happen to find them.  Ergo this one.

Your new RTC driver seems to work for me (thinkpad x60), but no, I
can't get wakeup using RTC to work:

root@amd:~# echo HDEF > /proc/acpi/wakeup
root@amd:~# cat /proc/acpi/wakeup
Device  Sleep state     Status
 LID       3            * enabled
SLPB       3            * enabled
DURT       3             enabled
EXP0       4             enabled
EXP1       4             enabled
EXP2       4             enabled
EXP3       4             enabled
PCI1       4             enabled
USB0       3             enabled
USB1       3             enabled
USB2       3             enabled
USB7       3             enabled
HDEF       4             enabled
root@amd:~# sync
root@amd:~# sync; /tmp/rtcwake -s $((2 * 60)) -m disk
rtcwake: wakeup from "disk" using rtc0 at Sun Aug 27 16:54:49 2006
root@amd:~#

Any ideas? (I tried suspending to RAM, too; no change).

Is acpi-rtc code likely to be merged?
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
