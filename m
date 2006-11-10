Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161850AbWKJPlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161850AbWKJPlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 10:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161868AbWKJPlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 10:41:21 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:4481 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1161850AbWKJPlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 10:41:20 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Pavel Machek <pavel@ucw.cz>, Michael Holzheu <holzheu@de.ibm.com>,
       Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com
Subject: Re: How to document dimension units for virtual files?
References: <20061108175412.3c2be30c.holzheu@de.ibm.com>
	<20061109231533.GE2616@elf.ucw.cz> <20061109231533.GE2616@elf.ucw.cz>
	<6F3F24CD-2893-43E2-A006-F809E35607AE@mac.com>
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Date: 10 Nov 2006 15:41:09 +0000
In-Reply-To: <6F3F24CD-2893-43E2-A006-F809E35607AE@mac.com>
Message-ID: <r6mz6znwbu.fsf@skye.ra.phy.cam.ac.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:
> Well, IMO you should never have "current:mW" in any form whatsoever
> anyways.  Electrically it makes no sense; it's like saying
> "height:grams".  

Agreed!

> Watts are an indication of power emitted or consumed per unit time
> (as opposed to current/amperage which counts only the number of
> electrons and not the change in energy), so perhaps "power_flow:mW"
> or "power_consumption:mW" would make more sense?

Current is flow of charge, in other words, charge per time.  Flow has
the notion of "per time" built into it.  So "power flow" contains an
extra "per time" compared to what you're looking for.  Power, being
energy per time, is already a flow (it's a flow of energy).

Perhaps because I'm writing a textbook on _The Art of Approximation_
(and finding formulas using dimensions is a main part of the art), I
like to distinguish a quantity's dimensions from its units.  The
dimensions are universal, like energy or length or power; the units
are their implementation in a particular system of measurement.  In
the SI system of units (a.k.a. the metric system), energy is measured
in Joules, time in seconds, and power in Joules/seconds or Watts.

So all of the following make sense:

* "Power:mW"
* "energy flow: mW" (more verbose but equivalent)
* "energy flow: mJ/s" (even more verbose but also equivalent)

> I can conceivably see a need for a "current:mJ_per_s" versus
> "current:mW" depending on the hardware-reported units, but never
> both at the same time.

I got lost here.  mJ/s is the same as mW, so with either current:mW or
current:mJ/s you're back in the soup of measuring current using units
of power.  If the hardware reports current, use "current: mA".  If the
hardware reports power, use "power: mW".  Then applications can easily
find out what's being reported and use it accordingly.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
