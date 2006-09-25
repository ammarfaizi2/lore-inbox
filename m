Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWIYNfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWIYNfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 09:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWIYNfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 09:35:55 -0400
Received: from server.mrvanes.com ([81.17.40.76]:26066 "EHLO mail.mrvanes.com")
	by vger.kernel.org with ESMTP id S1750817AbWIYNfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 09:35:54 -0400
From: Martin van Es <martin@mrvanes.com>
To: linux-kernel@vger.kernel.org
Subject: intel8x0-snd module fails to correctly detect clock when compiled in kernel
Date: Mon, 25 Sep 2006 15:35:44 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609251535.45246.martin@mrvanes.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the second time I sent a mail to perex@suse.cz a couple of days ago 
without any reply so far, so I thought I'd let the kernel mailinglist reader 
know of my findings as well.

Maybe anybody else can do something with the knowledge that the intel8x0-snd 
module fails to detect the 'clock' correctly if built into the kernel, as a 
module this works fine. If not for anything else, I hope this mail gets 
archived and the solution is available for anybody else having the same 
problem.


Below is the verbatim mail as I sent it to Jaroslav:

Yesterday I compiled the fresh 2.6.18 kernel and to my big surprise I 
discovered my sound was a bit off speed (too slow, like 48000 content was 
played at 44100 or so). Hence my immediate search for clock problems.

A bit of searching revealed that the ac97#0-0 file (in /proc/asound/card0 dir) 
contains 2 lines referring to 441~ and 48~.
In 2.6.18 these lines 

PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz

Both lines alternate between 44100 and 48000 between reboots (and I can't find 
what it depends on).

dmesg outputs the following 2 lines concerning audio clock:
intel8x0_measure_ac97_clock: measured 50992 usecs
intel8x0: clocking to 43920

The 'clocking to' line is not always the same, but never 48000.

Don't ask me why, but at last I tried to build the intel8x0-snd driver as a 
module and surprisingly that always results in correct funcionality. The 2 
dmesg lines now read:
intel8x0_measure_ac97_clock: measured 50463 usecs
intel8x0: clocking to 48000

The clocking line is always 48000, just like it used to be in 2.6.17.

I tried to use ac97_clock=48000 as kernel boot parameter, but the doesn't 
help (for the in-kernel version of the module).

ALSA version in 2.6.18 is:
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22 
13:55:50 2006 UTC).

My alsa intel8x0 device string is:
ALSA device list:
#0: Intel 82801DB-ICH4 with ALC202 at 0xe0100c00, irq 10


For the time being, my problem is solved by compiling the driver as module.
In the future however I'd appreciate building my kernel monolithic again.


Hope the information and bugreport is of any use to improve the intel8x0-snd 
module in future kernels.

Regards,
Martin van Es
-- 
If 'but' was of any use, it would be a logical operator.

