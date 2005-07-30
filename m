Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262915AbVG3Fok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbVG3Fok (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 01:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVG3Fok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 01:44:40 -0400
Received: from zorn.worldpath.net ([206.152.180.10]:14225 "EHLO
	unix.worldpath.net") by vger.kernel.org with ESMTP id S262915AbVG3Fnh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 01:43:37 -0400
Subject: [GIT PATCH] ACPI patches for 2.6.13
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0507141648070.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	 <20050714005106.GA16085@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
	 <1121304825.4435.126.camel@mindpipe>
	 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
	 <1121326938.3967.12.camel@laptopd505.fenrus.org>
	 <20050714121340.GA1072@ucw.cz>
	 <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>
	 <1121383050.4535.73.camel@mindpipe>
	 <Pine.LNX.4.58.0507141623490.19183@g5.osdl.org>
	 <1121384499.4535.82.camel@mindpipe>
	 <Pine.LNX.4.58.0507141648070.19183@g5.osdl.org>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 01:49:20 -0400
Message-Id: <1122702560.26850.9.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/to-linus/

Sorry to be scrambling so late in the 2.6.13 release cycle --
we'll do better with 2.6.14.

thanks,
-Len

p.s.
Latest ACPI plain patch, including stuff waiting for 2.6.14 is available
here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12/
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12/broken-out/


 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c |    7 
 arch/i386/pci/acpi.c                        |    1 
 arch/i386/pci/common.c                      |    6 
 arch/i386/pci/irq.c                         |    1 
 arch/i386/pci/pci.h                         |    1 
 drivers/acpi/ec.c                           |  889
++++++++++++++++++++++------
 drivers/acpi/pci_irq.c                      |   85 +-
 drivers/acpi/pci_link.c                     |  103 ++-
 drivers/acpi/processor_idle.c               |   31 
 drivers/net/sk98lin/skge.c                  |   63 +
 drivers/pcmcia/yenta_socket.c               |    9 
 include/acpi/acpi_drivers.h                 |    3 
 include/linux/acpi.h                        |    4 
 sound/pci/intel8x0.c                        |    6 
 14 files changed, 978 insertions(+), 231 deletions(-)

commit d6ac1a7910d22626bc77e73db091e00b810715f4
Merge: 577a4f8102d54b504cb22eb021b89e957e8df18f
87bec66b9691522414862dd8d41e430b063735ef
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jul 29 23:31:17 2005 -0400

    /home/lenb/src/to-linus branch 'acpi-2.6.12'

commit 87bec66b9691522414862dd8d41e430b063735ef
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Wed Jul 27 23:02:00 2005 -0400

    [ACPI] suspend/resume ACPI PCI Interrupt Links
    
    Add reference count and disable ACPI PCI Interrupt Link
    when no device still uses it.
    
    Warn when drivers have not released Link at suspend time.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=3469
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 68ac767686fd72f37a25bb4895fb4ab0080ba755
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Mon Apr 25 14:38:00 2005 -0400

    [ACPI] delete boot-time printk()s from processor_idle.c
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4401
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 90158b83204842c0108d744326868d91cc9c4dfd
Author: Rafael J. Wysocki <rjwysocki@sisk.pl>
Date:   Sun Jul 24 14:22:00 2005 -0400

    [ACPI] fix resume issues on Asus L5D
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4416
    
    Signed-off-by: Rafael J. Wysocki <rjwysocki@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4b31e77455b868b43e665edceb111c9a330c8e0f
Author: Dominik Brodowski <linux@dominikbrodowski.net>
Date:   Wed May 18 13:49:00 2005 -0400

    [ACPI] Always set P-state on initialization
    
    Otherwise a platform that supports ACPI based cpufreq
    and boots up at lowest possible speed could stay there
    forever.  This because the governor may request max speed,
    but the code doesn't update if there is no change in
    speed, and it assumed the initial state of max speed.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4634
    
    Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 45bea1555f5bf0cd5871b208b4b02d188f106861
Author: Luming Yu <luming.yu@intel.com>
Date:   Sat Jul 23 04:08:00 2005 -0400

    [ACPI] Add "ec_polling" boot option
    
    EC burst mode benefits many machines, some of
    them significantly.  However, our current
    implementation fails on some machines such
    as Rafael's Asus L5D.
    
    This patch restores the alternative EC polling code,
    which can be enabled at boot time via "ec_polling"
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4665
    
    Signed-off-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 335f16be5d917334f56ec9ef7ecf983476ac0563
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Wed Jun 22 18:37:00 2005 -0400

    [ACPI] address boot-freeze with updated DMI blacklist for c-states
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4763
    
    Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0b6b2f08c24a65535cb18893ca27516389c5fc0f
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Fri Jul 29 16:00:13 2005 -0400

    [ACPI] Fix memset arguments in acpi processor_idle.c
    
    http://bugzilla.kernel.org/show_bug.cgi?id=4954
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4a7164023959040e687e51663dee67cff4d2b770
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Fri Jul 29 15:51:36 2005 -0400

    [ACPI] Fix the regression with c1_default_handler on some systems
    where C-states come from FADT.
    
    Thanks to Kevin Radloff for identifying the issue and
    isolating it to exact line of code that is causing the issue.
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>



