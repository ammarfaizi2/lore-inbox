Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVCLAAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVCLAAZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 19:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVCKX5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:57:46 -0500
Received: from ewhac.best.vwh.net ([192.220.66.121]:38154 "EHLO
	ewhac.best.vwh.net") by vger.kernel.org with ESMTP id S261846AbVCKXyN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:54:13 -0500
Date: Fri, 11 Mar 2005 15:54:12 -0800
To: linux-kernel@vger.kernel.org
Subject: N00b Asks:  Supporting Linux Power Management HOWTO?
Message-ID: <20050311235412.GA12642@best.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: "Leo L. Schwab" <ewhac@best.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I'm currently working on driver development for an embedded/handheld
system.  We're currently using kernel 2.6.11 on an ARM-based platform, and
I've already got a handful of drivers running (anyone need an I2C bus driver
for a Freescale MX21?).  Earlier this week, I was asked to begin work on
power management -- shutting off unused devices, placing the system in
suspend/standby/sleep, etc.

	So I started Googling around for info on Linux power management and,
near as I can tell, there doesn't appear to be a cohesive approach to the
issue.  What I've managed to turn up so far is:

	- APM
	  An older power management system, supplanted by ACPI.  It seems to
	  enjoy the most mature support in Linux, if for no other reason
	  than it's been around so much longer.  It lacks flexibility,
	  however.
	- ACPI
	  The current "standard" for power management.  Support even on x86-
	  platforms seems highly uneven, however, and the ACPI support code
	  still seems to be undergoing major revisions.  It also appears to
	  be widely regarded as an unholy mess of a spec.  I've also gleaned
	  hints from LKML discussons that ACPI contains enough x86-specific
	  material to make it a questionable choice on other platforms.
	- DPM (Dynamic Power Management, http://dynamicpower.sf.net/ )
	  A proposal put forward by MontaVista and IBM, primarily for
	  embedded systems (although an Intel Speedstep implementation is
	  available).  While the reference implementation is being kept
	  current, it doesn't seem to have a lot of activity surrounding it,
	  despite being two years old.

	The functionality in each of these facilities seems to overlap
the others.  DPM in particular seems to heavily overlap services provided by
ACPI and exposed by 'cpufreq'.  This suggests to me that one ends up
redundantly implementing power support across three APIs, or that one is
supposed to select a single API and stick with that.  How one makes this
selection is not at all clear.

	Ideally, what I'd like is "the" approach that integrates most
cleanly into existing frameworks.  That is, I'd like to be able to write the
power management support into the drivers and platform-specific kernel
files, then essentially drop a stock distro on top of it and have the
largest number of scripts and tools Just Work.  I would prefer, if possible,
to write support for one interface rather than three (APM, ACPI, DPM)
especially when two of them are still moving targets.

	So, I guess what I'm asking for at the moment is:
	- A brief overview of the current state and maturity of power
	  management support in the 2.6.x kernel series,
	- the currently available facilities for implementing and supporting
	  power management,
	- pointers to documents describing the facilities in detail and how
	  to write driver and platform support for them.

	I realize I well may be asking for too much -- the following LKML
thread suggests that Linux power management remains a problem under active
discussion with fragmented solutions:

	http://groups-beta.google.com/group/fa.linux.kernel/browse_thread/thread/cab82562215fde4/4660291cd90cf2d2?q=power#4660291cd90cf2d2

	Nevertheless, any and all guidance would be greatly appreciated.
Please Cc: list responses to this address.  My sincerest thanks in advance.

--
Leo L. Schwab -- Digital Spellweaver                   ewhac@best.com  ..or..
 \_ -_   http://ewhac.best.vwh.net/                    ewhac@well.com
O----^o  Recumbent Bikes: The Only Way To Fly.         (pronounced "EH-wack")
