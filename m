Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275355AbTHGO4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275360AbTHGO4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:56:46 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:7837 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S275355AbTHGO4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:56:20 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: <linux-kernel@vger.kernel.org>
Subject: [APM]  CPU idle calls causing problem with ASUS P4PE MoBo
Date: Thu, 7 Aug 2003 11:08:09 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGIEPOCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am experiencing problems with the CPU idle call feature on an ASUS P4PE
(Intel 82845PE MCH and Intel 82801DB ICH4 chipsets).  I am using kernel
2.4.20-8 (Red Hat 9.0).  We were having trouble with our system "hanging"
after running for a while.    By this I mean, that no IRQs are getting
through, but software components are still running.  We have a proprietary
PCI DMA bus master device that works fine in PIII system, but the plans are
to ship our product using this ASUS MoBo.  In the process of trying to debug
this problem, we have updated BIOS, tweaked BIOS parameters, added debug to
the kernel to determine the status of our IRQ, etc.  When I changed the
CONFIG_APM_CPU_IDLE to no, our 3 hour test runs to completion.  Previously
this test would cause the system to hang within minutes.  I have tried
various combinations of APM tweaking with the following results:

   TEST:												RESULTS:
1) Power Management enabled in BIOS								Ran to completion (~ 3hours)
   Kernel configured with CONFIG_APM_CPU_IDLE not set

2) Power Management disabled in BIOS							locked up after a few minutes
   Kernel configured with CONFIG_APM_CPU_IDLE_CALLS=y

3) Power Management disabled in BIOS							Ran to completion
   Kernel configured with CONFIG_APM_CPU_IDLE_CALLS not set

4) Power Management disabled in BIOS							Ran to completion
   Kernel configured with CONFIG_APM_CPU_IDLE_CALLS=y
   Kernel parameter passed in: amp=off

5) Power Management disabled in BIOS							locked up after a few minutes
   Kernel configured with CONFIG_APM_CPU_IDLE_CALLS=y
   Kernel parameter passed in: amp=allow_ints

6) Power Management disabled in BIOS							Ran to completion
   Kernel configured with CONFIG_APM_CPU_IDLE_CALLS=y
   Changed apm_do_idle to NOT make BIOS call

For what it's worth:  In the process of testing this, I also noted that the
apm_do_idle always returns 0 (no evidence of the printk messages indicating
clock slowed down or BIOS refused call).  I originally suspected that when
the linux APM driver makes an idle call to BIOS, control never returns;
therefore, interrupts never get re-enabled and our system appears to freeze.
However, even though test #5 should have allowed interrupts to stay on, we
still had the described lockup.  It appears to be timing related since
thousands of these CPU idle BIOS calls are made before the system locks up.
(I determined this by adding 3 counters in apm_cpu_idle routine to determine
how many times the BIOS, original and default idle routines were called.  A
user app and driver combo request the values of these counters every
second.)

I noticed that this version of linux does not have this particular ASUS MoBo
in it's APM blacklist.  Has anyone seen similar symptoms with other MoBos
which have crippled CPU idle BIOSs?  I would be happy to provide any
additional testing needed to determine if this is a true APM/motherboard
interaction related problem.

Thanks in advance!  Please cc me in your response.

Kathy Frazier
Senior Software Engineer
Max Daetwyler Corporation-Dayton Division
2133 Lyons Road
Miamisburg, OH 45342
Tel #: 937.439-1582 ext 6158
Fax #: 937.439-1592
Email: kfrazier@daetwyler.com
http://www.daetwyler.com



