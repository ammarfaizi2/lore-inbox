Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSLJOmJ>; Tue, 10 Dec 2002 09:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbSLJOmJ>; Tue, 10 Dec 2002 09:42:09 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:59871 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S261686AbSLJOlZ>; Tue, 10 Dec 2002 09:41:25 -0500
Date: Tue, 10 Dec 2002 15:49:04 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.20-BK] make new ide compile
Message-ID: <20021210154904.E18849@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new ide code in the latest BK 2.4 kernel does not compile.

Several symbols: local_save_flags, save_and_cli, local_irq_set
are not defined, probably due to a missing merge somewhere in
include/asm-*/system.h.

The attached (dirty) patch makes it compile again. Just in case
somebody else needs it, while waiting for the proper fix.

Stelian.

===== include/linux/ide.h 1.7 vs edited =====
--- 1.7/include/linux/ide.h	Fri Nov 29 23:03:01 2002
+++ edited/include/linux/ide.h	Tue Dec 10 12:20:01 2002
@@ -1755,5 +1755,8 @@
 #define ide_lock		(io_request_lock)
 #define DRIVE_LOCK(drive)       ((drive)->queue.queue_lock)
 
+#define local_save_flags(flags)	save_flags((flags))
+#define save_and_cli(x)		local_irq_save(x)
+#define local_irq_set(flags)    do { local_save_flags((flags)); local_irq_enable(); } while (0)
 
 #endif /* _IDE_H */
-- 
Stelian Pop <stelian@popies.net>
