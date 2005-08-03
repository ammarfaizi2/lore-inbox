Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVHCXLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVHCXLw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 19:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVHCXLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 19:11:42 -0400
Received: from zorn.worldpath.net ([206.152.180.10]:14006 "EHLO
	unix.worldpath.net") by vger.kernel.org with ESMTP id S261612AbVHCXKo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 19:10:44 -0400
Subject: [GIT PATCH] ACPI patches for 2.6.13-rc5
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <1122702560.26850.9.camel@toshiba>
References: <1122702560.26850.9.camel@toshiba>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 19:16:25 -0400
Message-Id: <1123110985.13136.12.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/to-linus.git

I reverted several things to 2.6.12 behaviour
which should result in a higher quality 2.6.13 release:

1. Fixed the PCI Interrupt Link revert you pulled from the list.
2. Put Embedded Controller back into polling mode by default.
3. Set CONFIG_ACPI_HOTKEY to 'n' by default (updated driver too).
4. Lovingly restored the rudely deleted /proc/acpi/button/:-)

thanks,
-Len

p.s.
Latest ACPI plain patch, including stuff waiting for 2.6.14 is available
here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12/
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12/broken-out/


 drivers/acpi/Kconfig          |    5 
 drivers/acpi/button.c         |  206 ++++++++
 drivers/acpi/ec.c             |   24 -
 drivers/acpi/hotkey.c         |  690 +++++++++++++++++-------------
 drivers/acpi/pci_link.c       |   11 
 drivers/acpi/processor_idle.c |    7 
 6 files changed, 634 insertions(+), 309 deletions(-)


commit 79cda7d0e1c8629996242c036d6fe0466038d8ba
Author: Luming Yu <luming.yu@intel.com>
Date:   Wed Aug 3 18:07:59 2005 -0400

    [ACPI] CONFIG_ACPI_HOTKEY is now "n" by default
    For 2.6.12 behaviour, this (EXPERIMENTAL) driver
    should not be built.
    
    Update the driver source with latest from Luming.
    
    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit b34a8030eeab4d59dcdd86de38f6927b9edd441f
Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Date:   Wed Aug 3 17:55:21 2005 -0400

    [ACPI] restore /proc/acpi/button/ (ala 2.6.12)
    
    Signed-off-by Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by Len Brown <len.brown@intel.com>

commit 7b15f5e7bb180ac7bfb8926dbbd8835fecc07fad
Author: Luming Yu <luming.yu@intel.com>
Date:   Wed Aug 3 17:38:04 2005 -0400

    [ACPI] revert Embedded Controller to polling-mode by default (ala
2.6.12)
    Burst mode isn't ready for prime time,
    but can be enabled for test via "ec_burst=1"
    
    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ecc21ebe603af31f172c43b8b261df79040790ef
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Wed Aug 3 11:00:11 2005 -0400

    [ACPI] PCI interrupt link suspend/resume - revert to 2.6.12
behaviour
    
    This patch disables the PCI Interrupt Link refernece counts,
    which should not co-exist with the 2.6.12 irq_router.resume
    method or else a double acpi_pci_link_set() could result
    on resume.
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3d35600a9de8e2816d0e3726f64b7271af6fdda4
Author: Len Brown <len.brown@intel.com>
Date:   Wed Aug 3 00:22:52 2005 -0400

    [ACPI] fix 64-bit build warning in processor_idle.c
    
    Signed-off-by: Len Brown <len.brown@intel.com>



