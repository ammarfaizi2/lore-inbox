Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVHYCwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVHYCwF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 22:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbVHYCwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 22:52:05 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40952 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932497AbVHYCwE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 22:52:04 -0400
Date: Wed, 24 Aug 2005 19:51:58 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: PowerOP Take 2 0/3 Intro
Message-ID: <20050825025158.GA28662@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PowerOP is a system power parameter management API submitted for
discussion.  PowerOP writes and reads power "operating points",
comprised of arbitrary values, called power parameters, that correspond
to registers, clocks, dividers, voltage regulators, etc. that may be
modified to set a basic power/performance point for the system.
Higher-layer power management software passes a platform-specific struct
of power parameters to a backend that makes the requested adjustments.

PowerOP can be thought of as a layer below cpufreq that actually
accesses the hardware to make cpu frequency, voltage, core bus, and
perhaps other modifications to set a power point.  The main goal is to
open up interfaces to operating points comprised of arbitrary power
parameters, as an alternative to the "cpu frequency" parameter that
cpufreq is designed around.  It pushes the hardware-level power
parameter management down to a level that can be shared with other power
management policy frameworks that deal with entire operating points as
the basic unit of system power management for reasons described below,
and that 

The new layer is intended to leave all power policy decisions, and
various other power management chores such as driver notification, to
higher layers in a power management software stack.

This work is aimed in part at supporting embedded systems, which often
have several parameters that can be set and the cpu frequency
abstraction specifies only part of the operating point that may be
managed from software.  For example, an XScale PXA27x could be
considered to have six basic power parameters (mainly cpu run mode and
memory and bus dividers) that for the most part should be set in tandem
to known good sets of values as validated by the silicon vendor.
Embedded systems typically handle more hardware clock manipulation
directly in Linux than do, for example, desktop/server systems based on
ACPI interfaces.  Desktop/server systems may also benefit from the
ability to select custom voltages, bus speeds, etc., although deviating
from values validated by the hardware vendor is risky and controversial.

An optional sysfs interface to create and activate operating points is
also submitted for discussion.  This interface could be used in an
actual power management stack, or at least can serve as a starting point
for discussing how to manage operating points at the next higher layer
in the power management soctware stack.

cpufreq is another possible interface. PowerOP can fit below cpufreq to
make cpu frequency, voltage, core bus, and perhaps other modifications
to set a power point, leaving cpufreq to manage the interfaces based
around the "cpu frequency" abstraction, the policies and governors that
select the frequency, its notifiers, and so forth.  An example hooking
up support for one cpufreq platform to PowerOP has been previously
submitted.  Some discussion regarding incorporating an expanded set of
power parameters into the cpufreq interfaces has also taken place.
