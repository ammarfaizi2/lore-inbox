Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268667AbSISNen>; Thu, 19 Sep 2002 09:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269223AbSISNem>; Thu, 19 Sep 2002 09:34:42 -0400
Received: from kim.it.uu.se ([130.238.12.178]:26798 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S268667AbSISNem>;
	Thu, 19 Sep 2002 09:34:42 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15753.54167.111587.38417@kim.it.uu.se>
Date: Thu, 19 Sep 2002 15:39:35 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Andi Kleen <ak@suse.de>,
       "David S. Miller" <davem@redhat.com>, johnstul@us.ibm.com,
       James Cleverdon <jamesclv@us.ibm.com>, linux-kernel@vger.kernel.org,
       anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
In-Reply-To: <1032442039.26712.32.camel@irongate.swansea.linux.org.uk>
References: <1032305535.7481.204.camel@cog>
	<20020917.163246.113965700.davem@redhat.com>
	<20020918015209.B31263@wotan.suse.de>
	<20020917.164649.110499262.davem@redhat.com>
	<20020918015838.A6684@wotan.suse.de>
	<15753.45833.702405.2357@kim.it.uu.se>
	<1032442039.26712.32.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > On Thu, 2002-09-19 at 12:20, Mikael Pettersson wrote:
 > >  > The local APIC timer is specified in the Intel Manual volume 3 for example.
 > >  > It's an optional feature (CPUID), but pretty much everyone has it.
 > > 
 > > Except that like everything else related to the local APIC, you're at
 > > the mercy of the competence (or lack thereof) of the BIOS implementors.
 > > - There are plenty of laptops whose CPUs have local APICs but whose
 > >   BIOSen go berserk if you enable it. There are also plenty of laptops
 > 
 > Frequently because we don't disable it again before any APM calls I
 > suspect. When a CPU goes into sleep mode you must disable PMC and local
 > apic timer interrupts.

We do on sane boxes where the APM BIOS informs us before suspending.
E.g., on my ASUS P3B-F & P4T-E suspend works with local APIC enabled
because I hooked both the NMI watchdog and local APIC to the
PM system, so we disable before suspending and restore afterwards.

The problem is that some BIOSen don't post the suspend event to
our APM driver, so we fail to disable before suspend, and some BIOSen
(like the utter crap Dell put in the Inspiron) die on all entries to
the BIOS: pull the power cord -> #SMM event -> box crashes.

/Mikael
