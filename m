Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVATAOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVATAOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbVATANK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:13:10 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:9390 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261989AbVATAIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:08:36 -0500
Date: Wed, 19 Jan 2005 16:07:56 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@suse.cz>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050120000755.GD9975@atomide.com>
References: <20050119000556.GB14749@atomide.com> <20050119113642.GA1358@elf.ucw.cz> <20050119171106.GA14545@atomide.com> <20050119220637.GA7513@elf.ucw.cz> <20050119230813.GI14545@atomide.com> <20050119235905.GA1371@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20050119235905.GA1371@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Pavel Machek <pavel@suse.cz> [050119 15:58]:
> Hi!
> 
> > > > Thanks for trying it out. I have quite accurate time here on my
> > > > systems, and sleep works as it should. I wonder what's happening on
> > > > your system? If you have a chance, could you please post the results
> > > > from following simple tests?
> > > 
> > > On patched 2.6.11-rc1:
> > > 
> > > [Heh, clock is two times too fast, perhaps that makes ntpdate fail? -- yes.
> > > 
> > > root@amd:~# dmesg | grep -i time; for i in 1 2 3 4 5; do ntpdate -b tak.cesnet.cz && sleep 10; done ; date && sleep 10 && date; while [ 1 ]; do date; done | uniq
> > > PCI: Setting latency timer of device 0000:00:11.5 to 64
> > > dyn-tick: Enabling dynamic tick timer
> > > dyn-tick: Timer using dynamic tick
> > 
> > Thanks. Looks like you're running on PIT only, I guess my patch
> > currently breaks PIT (and possibly HPET) No dmesg message for "
> > "Using XXX for high-res timesource".
> 
> This machine definitely has TSC... What do I have to do in .config to
> make it do something interesting? My .config is:

I suspect it's the HPET_TIMER, see below. CONFIG_X86_PM_TIMER is
optional, otherwise TSC is used.

Tony


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-config-no-hpet

--- config.orig	2005-01-19 16:05:16.000000000 -0800
+++ config	2005-01-19 16:06:07.000000000 -0800
@@ -103,7 +103,7 @@
 CONFIG_X86_GOOD_APIC=y
 CONFIG_X86_INTEL_USERCOPY=y
 CONFIG_X86_USE_PPRO_CHECKSUM=y
-CONFIG_HPET_TIMER=y
+# CONFIG_HPET_TIMER is not set
 CONFIG_NO_IDLE_HZ=y
 # CONFIG_SMP is not set
 CONFIG_PREEMPT=y
@@ -169,7 +169,7 @@
 CONFIG_ACPI_POWER=y
 CONFIG_ACPI_PCI=y
 CONFIG_ACPI_SYSTEM=y
-# CONFIG_X86_PM_TIMER is not set
+CONFIG_X86_PM_TIMER=y
 # CONFIG_ACPI_CONTAINER is not set
 
 #

--lrZ03NoBR/3+SXJZ--
