Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274906AbTHFHnd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274907AbTHFHnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:43:32 -0400
Received: from sngrel7.hp.com ([192.6.86.111]:1022 "EHLO sngrel7.hp.com")
	by vger.kernel.org with ESMTP id S274906AbTHFHnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:43:25 -0400
Date: Wed, 6 Aug 2003 17:43:13 +1000
From: Martin Pool <mbp@samba.org>
To: Richard Zidlicky <rz@linux-m68k.org>, geert@linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: [patch] [Kconfig] disable GEN_RTC on ia-64
Message-ID: <20030806074312.GT22302@vexed.ozlabs.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG: 1024D/A0B3E88B: AFAC578F 1841EE6B FD95E143 3C63CA3F A0B3E88B
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IA-64 does not have a directly accessible real-time clock.  As far as
I know the only method to access the clock on this platform is to go
through EFI (Extensible Firmware Interface, like a BIOS), which is
handled by efirtc.c.

genrtc can be configured on for this platform but does not build
(because there is no asm/rtc.h), and anyhow it is never likely to be
useful.  I suggest that it should be disabled in Kconfig, as rtc.c
already is.

Perhaps other platforms that don't support it should be turned off
too.



--- linux-2.6.0test2-ia64/drivers/char/Kconfig.~1~	2003-07-11 06:04:38.000000000 +1000
+++ linux-2.6.0test2-ia64/drivers/char/Kconfig	2003-08-06 17:35:08.000000000 +1000
@@ -797,7 +797,7 @@ config RTC
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y
+	depends on RTC!=y && !IA64
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you


Regards,
-- 
Martin 
