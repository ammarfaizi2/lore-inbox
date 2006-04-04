Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWDDDhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWDDDhB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 23:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWDDDhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 23:37:00 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:13243 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S964993AbWDDDg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 23:36:59 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200604040340.k343ewe3029930@auster.physics.adelaide.edu.au>
Subject: 2.6.16-rt11: Hires timer makes sleep wait far too long
To: linux-kernel@vger.kernel.org
Date: Tue, 4 Apr 2006 13:10:58 +0930 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few days ago I compiled and tested 2.6.16-rt11 on a Pentium3 desktop box
with the high resolution timer feature enabled.  It was set to a frequency
of 1000.  Things appeared to work fine so I tried exactly the same thing
on a 2.0 GHz Centrino-based laptop last night.

Unfortunately the laptop had an issue: whenever the system scripts called
sleep the system would wait for *way* longer than it should have.  Calling
  sleep 1
would give rise to a wait of as much as 45 seconds before the command 
prompt returned.

This was similar to an issue I had earlier (around 2.6.13) which was
associated with the new clock source infrastructure.  However, this time
around the timekeeping (as in the time of day reported by "date") did not
appear to run slow as it did in this previous fault condition.

I tested the situation under the four clock sources reported to be available
in /sys/devices/system/clocksource/clocksource0/:

  pit, jiffies, acpi_pm (the default), tsc

The actual amount of time waited by a "sleep 1" call from bash was tested
at least twice for each timer source:

  pit: 12 seconds, 29 seconds, 28 seconds
  tsc: 45 seconds, 45 seconds
  acpi_pm: 45 seconds, 29 seconds
  jiffies: 45 seconds, 32 seconds

I then rebuilt the 2.6.16-rt11 kernel without the HR-timers option selected.
After rebooting, running sleep worked exactly as expected.

I'm more than happy to run additional tests to try to narrow down the
problem.

Regards
  jonathan
