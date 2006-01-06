Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWAFIQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWAFIQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 03:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWAFIQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 03:16:46 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4544 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964856AbWAFIQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 03:16:46 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Yinghai Lu <yinghai.lu@amd.com>, vgoyal@in.ibm.com, ak@muc.de,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, linuxbios@openbios.org
Subject: [PATCH] i386 io_apic: Use correct index variable when computing the
 apic that is in ExtInt mode.
References: <20060103044632.GA4969@in.ibm.com>
	<86802c440601051630i4d52aa2fj1a2990acf858cd63@mail.gmail.com>
	<20060105163848.3275a220.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 06 Jan 2006 01:14:16 -0700
In-Reply-To: <20060105163848.3275a220.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 5 Jan 2006 16:38:48 -0800")
Message-ID: <m11wzl6aef.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Somehow in all of the chaos this one line bug fix got merged with
the another patch and was then discarded when issues were found
with that other patch.

 From: Vivek Goyal <vgoyal@in.ibm.com>

  A minor fix to the patch which remembers the location of where i8259 is
  connected.  Now counter i has been replaced by apic.  counter i is having
  some junk value which was leading to non-detection of i8259 connected to
  IOAPIC.

---

 arch/i386/kernel/io_apic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

b5a215b462de26a1e6c21f607677796f0bb446aa
diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index 7554f8f..f2dd218 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -1649,7 +1649,7 @@ static void __init enable_IO_APIC(void)
 	for(apic = 0; apic < nr_ioapics; apic++) {
 		int pin;
 		/* See if any of the pins is in ExtINT mode */
-		for(pin = 0; pin < nr_ioapic_registers[i]; pin++) {
+		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
 			struct IO_APIC_route_entry entry;
 			spin_lock_irqsave(&ioapic_lock, flags);
 			*(((int *)&entry) + 0) = io_apic_read(apic, 0x10 + 2 * pin);
