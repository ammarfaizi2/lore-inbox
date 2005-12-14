Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbVLNWvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbVLNWvt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbVLNWvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:51:49 -0500
Received: from mithrandir.paypc.com ([66.186.24.2]:51366 "EHLO
	mithrandir.paypc.com") by vger.kernel.org with ESMTP
	id S965057AbVLNWvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:51:48 -0500
DomainKey-Signature: a=rsa-sha1; s=mithrandir; d=paypc.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:mime-version:
	content-type:user-agent;
	b=MJuCiAdqc/04PL7jWRdH7P7kK4hoPhKKEoq75UjbIxUaBBTJYd9ZOs8F4BzKqMyyL
	coWzz/BLYte4drjK0TE3Q==
Message-ID: <1134600697.43a0a1f9de94e@www.paypc.com>
Date: Thu, 15 Dec 2005 08:51:37 +1000
From: Patch Devil <lkpatches@paypc.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] i8xx_tco - Add SuperMicro ICH[56] Pentium 4 watchdog support
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ1134600697177709f2d6695705a862fa3540db732d"
User-Agent: Internet Messaging Program (IMP) 3.2.x-RMSv9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ1134600697177709f2d6695705a862fa3540db732d
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Hello friends of LK:

It seems that SuperMicro P4-based motherboards DO actually have working
watchdog hardware (be sure jumpers *and* BIOS settings are configured
appropriately), however the setup of their internal ports and registers
deviate from canonical Intel specification.

Because it seems impossible/difficult to do a proper auto-detection for these
deviations, I've added a module_param to the TCO module to provide minor
changes to the existing i8xx TCO code.  I've given it some testing on i845
(Northwood P4) and E7520 (Nacona/EM64T SMP-Xeon) and it does indeed activate
watchdog (reset/reboot) functionality and provide WDT resets to keep the
system up.

SuperMicro had provided me with some documentation for their Pentium III
motherboards, however I was not able to ever get it functioning on my SSE370+,
however I've incorporated the logic as documented as a bit of a "bookmark" for
future implementors who MAY be lucky to have P3 SuperMicros with working WDT
functionality.

My patch activates the watchdog even if the BIOS setting disables it, however
it cannot override the jumper on the motherboard.

Naturally, users should do two-way testing before deploying this on production
hardware: 1) Verify that the watchdog IS actually able to reset the machine --
so you'll need to deliberately lockup or kill the WDT refresh and make sure
the machine reboots, and then 2) Verify that the watchdog timer is being
properly reset.

This patch was made against 2.6.13.2, and I provide some background detail in
the patched source.

I've had this working in production for a couple of months now without any
issues.  Of course, these very reliable systems never lockup (typical uptimes
are over 300-400 days, and are rebooted for kernel upgrades only).  But hey, I
was a bit annoyed that an advertised feature wasn't available to me.

Cheers,
Robert

PS: I'm not a subscriber to LKML, so if you CC: your reply to me, I will be
able to read it.


---MOQ1134600697177709f2d6695705a862fa3540db732d
Content-Type: application/x-gzip; name="supermicro-tco.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="supermicro-tco.patch.gz"

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

---MOQ1134600697177709f2d6695705a862fa3540db732d--
