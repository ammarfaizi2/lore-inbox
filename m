Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131624AbQK0Oli>; Mon, 27 Nov 2000 09:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131655AbQK0OlP>; Mon, 27 Nov 2000 09:41:15 -0500
Received: from ns.caldera.de ([212.34.180.1]:25362 "EHLO ns.caldera.de")
        by vger.kernel.org with ESMTP id <S131597AbQK0OlI> convert rfc822-to-8bit;
        Mon, 27 Nov 2000 09:41:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <14882.27508.534457.187156@ns.caldera.de>
Date: Mon, 27 Nov 2000 15:11:00 +0100 (CET)
To: aj@dungeon.inka.de (Andreas Jellinghaus)
Cc: linux-kernel@vger.kernel.org
Subject: [Oops] apic, smp and k6
In-Reply-To: <20001124181723.BAAC7B7813@dungeon.inka.de>
In-Reply-To: <20001124181723.BAAC7B7813@dungeon.inka.de>
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
From: Torsten Duwe <duwe@caldera.de>
Reply-to: Torsten.Duwe@caldera.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andreas" == Andreas Jellinghaus <aj@dungeon.inka.de> writes:

    Andreas> a dual board (meant for pentium) with one k6 200 and a
    Andreas> 2.4.0-test11 kernel with APIC support enabled does oops
    Andreas> here. removed the APIC support, and now everything is fine.  i
    Andreas> read here it´s a known problem ? at least someone else reported
    Andreas> this, and it´s the same problem here.

Yes, a colleague of mine has a similar beast, hence Caldera ships for quite a
while now with an appropriate patch. Now Christoph Hellwig has identified a
simpler solution (updated for -test11 by me):

--- linux/arch/i386/kernel/setup.c~	Fri Jul  7 04:42:06 2000
+++ linux/arch/i386/kernel/setup.c	Tue Jul 18 19:22:48 2000
@@ -785,7 +785,8 @@
 	/*
 	 * get boot-time SMP configuration:
 	 */
-	if (smp_found_config)
+	if (smp_found_config && /* try only if the cpu has a local apic */
+	    test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability))
 		get_smp_config();
 #endif
 #ifdef CONFIG_X86_LOCAL_APIC


I think Alan has a similar thing in his test11-ac* series.

Hope that helps,

	Torsten
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
