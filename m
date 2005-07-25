Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVGYOOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVGYOOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 10:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVGYOOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 10:14:04 -0400
Received: from imap.gmx.net ([213.165.64.20]:30423 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261152AbVGYOOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 10:14:03 -0400
X-Authenticated: #1725425
Date: Mon, 25 Jul 2005 16:13:33 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Power consumption HZ250 vs. HZ1000
Message-Id: <20050725161333.446fe265.Ballarin.Marc@gmx.de>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I did some measurements in order to compare power drain with HZ250 and
HZ1000.
To measure the actual drain, I used the "smart" battery's internal measurement.
(Available with acpi-sbs in /proc/acpi/sbs/SBS0/SB0/state.)
No clue how accurate this is.

Here some battery details, in case someone knows:
charge reporting error:  25%
SB specification:        v1.1 (with PEC)
manufacturer name:       Panasonic
manufacture date:        2004-11-27
device name:             02ZL
device chemistry:        Lion

Kernel: 2.6.13-rc3-mm1 + acpi-sbs

CPU:
cpu family	: 6
model		: 13
model name	: Intel(R) Pentium(R) M processor 1.60GHz
stepping		: 6

The "ondemand" governor was running, using acpi_cpufreq. (Idle at 600MHz).

Systems was running X11/KDE to get a more or less realistic scenario. No
cron jobs, network traffic or additional applications. WLAN and built-in
display were disabled completely, all fans and LEDs were off, internal hard
disc was running. Additional peripherals: external keyboard, mouse, display
and externally-powered hard disk (USB).

The results are quite simple:
In both configurations the current settles between 727-729 mA
(Voltage ~16.5 V).

Some issues:

- C-states look strange:
active state:            C2
max_cstate:              C8
bus master activity:     00887fff
states:
    C1:                  type[C1] promotion[C2] demotion[--]   latency[000] usage[00000010]
  *C2:                  type[C2] promotion[C3] demotion[C1] latency[001] usage[01367471]
    C3:                  type[C3] promotion[--]   demotion[C2] latency[085] usage[00000000]

- I don't know, how much polling of the battery affects results. Reads always
block for ~10 seconds, and I used this behaviour for rate-limiting.

- Is this approach valid at all?

- I could repeat the test in single user mode with internal hard disc turned off.

Regards
