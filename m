Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270154AbTGUO7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270158AbTGUO7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:59:22 -0400
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:29865
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S270154AbTGUO7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:59:19 -0400
Message-ID: <27683.216.12.38.216.1058800462.squirrel@www.ghz.cc>
Date: Mon, 21 Jul 2003 11:14:22 -0400 (EDT)
Subject: "apm: suspend: Unable to enter requested state" in 2.5.x/2.6.0test1
From: "Charles Lepple" <clepple@ghz.cc>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
References: 
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a ThinkPad 770, and under 2.4.x (including .21 and several RedHat
.18-x kernels, FWIW), it would suspend and even hibernate nicely (if all
PCMCIA cards were removed).

In 2.5.x (where x > 66, and maybe earlier) and 2.6.0test1, the machine
doesn't suspend. If I either press the suspend hotkey (Fn-F4), close the
lid, or invoke "apm --suspend", the suspend LED starts to blink, and I get
these messages:

Jul 19 10:46:32 lemur apmd[587]: System Suspend
Jul 19 10:46:52 lemur kernel: uhci-hcd 00:01.2: suspend to state 3 Jul 19
10:46:52 lemur kernel: apm: suspend: Unable to enter requested state

followed by a few beeps, and then the LEDs indicate a non-suspended state.
After a couple of seconds, the screen returns to normal.

Here are the powr mgmt configuration options I used for 2.6.0test1:

  # Power management options (ACPI, APM)
  #
  CONFIG_PM=y
  # CONFIG_SOFTWARE_SUSPEND is not set

  #
  # ACPI Support
  #
  # CONFIG_ACPI is not set
  CONFIG_APM=m
  # CONFIG_APM_IGNORE_USER_SUSPEND is not set
  CONFIG_APM_DO_ENABLE=y
  CONFIG_APM_CPU_IDLE=y
  # CONFIG_APM_DISPLAY_BLANK is not set
  # CONFIG_APM_RTC_IS_GMT is not set
  # CONFIG_APM_ALLOW_INTS is not set
  # CONFIG_APM_REAL_MODE_POWER_OFF is not set

CONFIG_APM_ALLOW_INTS doesn't seem to matter, as the APM code detects that
it is an IBM machine, and enables interrupts during APM calls
unconditionally:

  lemur:~$ dmesg|grep -iw apm
  IBM machine detected. Enabling interrupts during APM calls.
  apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)

I have diddled with a few of the other options with no noticeable effect.
Also, I have tried reducing the number of loaded drivers (booting
single-user, not loading any modules but those needed for disk and console
I/O).

As time permits, I will try and test this on other kernel versions.
However, I feel like I am poking around in the dark. Any ideas as to what
may be preventing suspend from working? I'm not too familiar with the
details of APM, but my impression was that APM is BIOS-driven. So there
should not be any random device drivers preventing suspend (as could
happen with ACPI), right?

ACPI doesn't even work with this hardware in Win98 or Win2k, (plain 770s;
later 770s supposedly support it) and the latest kernels won't even
attempt to work with it. Otherwise, I'd be bugging the linux-acpi people.

Any advice would be appreciated. I am more than willing to pepper the
kernel APM code with printks if necessary to debug this, but I am going to
need a bit of guidance to do that effectively.

-- 
Charles Lepple <ghz.cc!clepple>
http://www.ghz.cc/charles/

