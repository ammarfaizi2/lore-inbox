Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWF2Rti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWF2Rti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWF2Rti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:49:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19879 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751110AbWF2Rth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:49:37 -0400
Date: Thu, 29 Jun 2006 19:48:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Gleixner <tglx@timesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic HZ -V4
Message-ID: <20060629174838.GA1695@elf.ucw.cz>
References: <1150747581.29299.75.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150747581.29299.75.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> An updated patchset is available from:
> 
> http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick4.patch
> 
> http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick4.patches.tar.bz2

I briefly tested -dyntick5 on my thinkpad, and it seems to work
okay... but timer still seems to tick at 250Hz.

I have

CONFIG_NO_HZ=y
CONFIG_NO_IDLE_HZ=y
CONFIG_HIGH_RES_RESOLUTION=1000
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250

root@amd:/proc/sys# cat /proc/interrupts ; sleep 10; cat
/proc/interrupts
           CPU0
  0:      66865          XT-PIC  timer
  1:       1473          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:        249          XT-PIC  acpi
 11:        214          XT-PIC  ohci1394, yenta, yenta,
ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3,
uhci_hcd:usb4, Intel 82801DB-ICH4, eth0
 12:        641          XT-PIC  i8042
 14:       2476          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0
           CPU0
  0:      69374          XT-PIC  timer
  1:       1474          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:        249          XT-PIC  acpi
 11:        219          XT-PIC  ohci1394, yenta, yenta,
ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3,
uhci_hcd:usb4, Intel 82801DB-ICH4, eth0
 12:        641          XT-PIC  i8042
 14:       2491          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0
root@amd:/proc/sys#

...am I doing something wrong?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
