Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262828AbSKNDwA>; Wed, 13 Nov 2002 22:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbSKNDv7>; Wed, 13 Nov 2002 22:51:59 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.11.87]:3588
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S262828AbSKNDv6>; Wed, 13 Nov 2002 22:51:58 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Fix drivers/acpi/sleep.c compile error if swsusp is disabled
Date: Wed, 13 Nov 2002 23:04:03 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211132304.03608.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this should fix this compile problem (if this is correct).

Please apply.

Shawn.

diff -urpN  linux-2.5.47-vanilla/drivers/acpi/sleep.c linux-2.5.47-fixes/drivers/acpi/sleep.c
--- linux-2.5.47-vanilla/drivers/acpi/sleep.c   2002-11-13 22:40:07.000000000 -0500
+++ linux-2.5.47-fixes/drivers/acpi/sleep.c     2002-11-13 22:55:25.000000000 -0500
@@ -205,8 +205,10 @@ acpi_system_suspend(
                break;

        case ACPI_STATE_S2:
+#ifdef CONFIG_SOFTWARE_SUSPEND
        case ACPI_STATE_S3:
                do_suspend_lowlevel(0);
+#endif
                break;
        }
        local_irq_restore(flags);


