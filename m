Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274881AbTHFHES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274884AbTHFHES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:04:18 -0400
Received: from sngrel7.hp.com ([192.6.86.111]:31729 "EHLO sngrel7.hp.com")
	by vger.kernel.org with ESMTP id S274881AbTHFHER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:04:17 -0400
Date: Wed, 6 Aug 2003 17:04:06 +1000
From: Martin Pool <mbp@samba.org>
To: linux-kernel@vger.kernel.org, zippel@linux-m68k.org,
       Alain.Knaff@poboxes.com
Subject: [patch] [Kconfig] disable CONFIG_FD on ia64, which has no floppy drive
Message-ID: <20030806070356.GA11405@vexed.ozlabs.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG: 1024D/A0B3E88B: AFAC578F 1841EE6B FD95E143 3C63CA3F A0B3E88B
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of linux-2.6.0-test2-ia64-030729, there is no asm-ia64/floppy.h,
and so the fd driver won't work.  Other architectures have various
legacy floppy controllers, but ia64 does not have one and is never
likely to.

David Mosberger says:

> The Merced machines came with SuperDrives (or whatever they
> were called), but those attached to the IDE controller, not the floppy
> controller.  The classic (AT-style) floppy controller is an ISA device
> and since ia64 doesn't support ISA, such controllers never were
> supported.

There is no reason to ever have CONFIG_FD on ia64, but if it does get
turned on then the build will fail.  Therefore, I suggest this patch
to keep it off:

--- linux-2.6.0test2-ia64/drivers/block/Kconfig.~1~     2003-07-29 12:07:02.000000000 +1000
+++ linux-2.6.0test2-ia64/drivers/block/Kconfig 2003-08-06 15:55:16.000000000 +1000
@@ -6,7 +6,7 @@ menu "Block devices"

 config BLK_DEV_FD
        tristate "Normal floppy disk support"
-       depends on !X86_PC9800
+       depends on !X86_PC9800 && !IA64
        ---help---
          If you want to use the floppy disk drive(s) of your PC under Linux,
          say Y. Information about this driver, especially important for IBM

-- 
Martin 
