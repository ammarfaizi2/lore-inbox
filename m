Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266131AbUGJEFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266131AbUGJEFt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 00:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUGJEFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 00:05:49 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:29852 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266127AbUGJEFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 00:05:46 -0400
To: ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: arch/sparc64/Kconfig
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Fri, 09 Jul 2004 21:05:45 -0700
Message-ID: <52brio8q1y.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Jul 2004 04:05:45.0673 (UTC) FILETIME=[2CF36390:01C46633]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently tested building the OpenIB InfiniBand drivers for sparc64.
These drivers add a new drivers/infiniband directory and hook into the
kernel config system by adding a 'source "drivers/infiniband/Kconfig"'
to the drivers/Kconfig file.

However, I discovered that arch/sparc64/Kconfig includes individual
drivers/xxx/Kconfig files rather than the main drivers/Kconfig.  This
means that hooking in the infiniband Kconfig requires changing the
sparc64 Kconfig.

I looked at arch/sparc64/Kconfig and found that the only files it does
not include that are included by drivers/Kconfig are

    drivers/cdrom/Kconfig
    drivers/char/Kconfig
    drivers/macintosh/Kconfig
    drivers/message/i2o/Kconfig
    drivers/misc/Kconfig

cdrom is safe because the whole thing depends on ISA.  macintosh is
safe because it depends on PPC || MAC.  misc is safe because it only
includes one entry that depends on X86.

So I guess my questions are, first, is there any reason why the
message/i2o and especially the char Kconfigs are left out of the
sparc64 Kconfig, and second, would a patch changing sparc64 to use the
main drivers/Kconfig be accepted?

Thanks,
  Roland
