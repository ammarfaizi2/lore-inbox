Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135957AbRDZWKq>; Thu, 26 Apr 2001 18:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135956AbRDZWKf>; Thu, 26 Apr 2001 18:10:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32412 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135954AbRDZWKV>;
	Thu, 26 Apr 2001 18:10:21 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15080.40123.543633.854889@pizda.ninka.net>
Date: Thu, 26 Apr 2001 15:10:03 -0700 (PDT)
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'John Fremlin'" <chief@bandits.org>,
        "'Simon Richter'" <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        "'Pavel Machek'" <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
Subject: RE: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD9F@orsmsx35.jf.intel.com>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD9F@orsmsx35.jf.intel.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Grover, Andrew writes:
 > A generalized interface is more work, and I see no
 > benefit *right now*. We'll see when someone designs one, I guess.

If the whole world were ACPI, yes I would not see a benefit either,
but for PPC, UltraSPARC-III etc. systems there is going to be a gain.

These systems do power management in a way that is in many ways quite
different from the models provided by ACPI.

You can break the whole power management problem down to "here are
the levels of low-power provided by the hardware, here are the
idleness triggers that may be monitored".  That's it, nothing more.
This is powerful enough to do all the things you could want a pm layer
to do:

	1) CPU's have been in their idle threads for X percent of
	   of the past measurement quantum, half clock the processors.

	2) The user has hit the "sleep" trigger, spin down the disks,
	   reduce clock the cpus, bus, PCI controller and PCI devices.

This kind of pm model with triggers and available low power states can
be used to solve problems PM was not designed to solve.  For example,
if fans begin to fail and temperature indicates we might begin to
overheat, we can reduce clock the cpus to reduce the heat before doing
something more drastic like shutting the system down.  Basically,
environment control problems can be expressed within this framework.

You get the idea.  And none of it has anything to do with ACPI, Sun's
Ultra-III platform power management scheme, or what Apple uses in the
iBook.

This is the kind of model I like because it doesn't "look" like any
particular implementation of power management, it "is" power
management.  I can plug any hardware PM scheme into that.

Later,
David S. Miller
davem@redhat.com

