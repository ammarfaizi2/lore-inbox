Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTKBGlL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 01:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTKBGlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 01:41:11 -0500
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:5749 "EHLO
	earth-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S261484AbTKBGlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 01:41:09 -0500
Date: Sat, 1 Nov 2003 22:41:07 -0800 (PST)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@sue
To: Matthew Wilcox <willy@debian.org>
Cc: linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
Subject: IA64/simulators - Kconfig logic for drivers/*
In-Reply-To: <20031102043402.GF3824@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.58.0311012038250.20298@sue>
References: <Pine.GSO.4.58.0310251706470.15711@inky>
 <20031102031644.GB3824@parcelfarce.linux.theplanet.co.uk>
 <Pine.GSO.4.58.0311011945190.18996@sue> <20031102043402.GF3824@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Nov 2003, Matthew Wilcox wrote:

> > Why not include drivers/Kconfig and scrap the individual subdirectory
> > includes, as i386 does?
>
> At that time, I hadn't done the work to create drivers/Kconfig ;-)
> The main problem for ia64 is the simulator stuff.  Maybe something like:
>
> if !IA64_HP_SIM
> source "drivers/Kconfig"
> endif
>
> if IA64_HP_SIM
> source "drivers/base/Kconfig"
> source "drivers/scsi/Kconfig"
> source "net/Kconfig"
> source "drivers/block/Kconfig"
> source "arch/ia64/hp/sim/Kconfig"
> endif

I would guess that everyone who uses a simulator is a kernel developer or maybe
an application developer.  I worry that the risk of hiding useful configs from
simulator users by lax maintenance of that block of Kconfig logic exceeds the
risk of those people trying to build a simulator kernel with all kinds of
hardware drivers and finding that it doesn't work.  A quieter configuration is
nice, however.  Hmmm.

What about something like the following - create a new config, ARCH_SIMULATOR,
that IA64_HP_SIM and any other barebones simulators set.  Then put an "if
!ARCH_SIMULATOR" on the subdir includes in drivers/Kconfig that definitely don't
apply to simulators (drivers specifically for real hardware).  That increases
the probability that people who add new features that simulator users might want
will know to unmask them, since far more people see drivers/Kconfig than do
arch/ia64/Kconfig, and it handles similar simulators in a uniform way.

You could also extend that strategy by, for example masking the SCSI low level
drivers menu with an "if !ARCH_SIMULATOR" so simulator users see the generic
SCSI machinery but not all the irrelevant hardware drivers.

What do you think?

