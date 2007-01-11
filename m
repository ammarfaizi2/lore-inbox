Return-Path: <linux-kernel-owner+w=401wt.eu-S1030219AbXAKIN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbXAKIN5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbXAKIN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:13:57 -0500
Received: from hera.kernel.org ([140.211.167.34]:49576 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030219AbXAKINz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:13:55 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Linus Torvalds <torvalds@osdl.org>
Subject: [GIT PATCH] ACPI patches for 2.6.20-rc4
Date: Thu, 11 Jan 2007 03:12:05 -0500
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701110312.05969.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This will update the files shown below.

thanks!

-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.20/acpi-release-20060707-2.6.20-rc4.diff.gz

 Documentation/feature-removal-schedule.txt |   45 +++++++++++++++++
 MAINTAINERS                                |   39 ++++++++++++--
 arch/i386/kernel/acpi/cstate.c             |   10 +--
 arch/ia64/kernel/acpi.c                    |    3 +
 arch/ia64/sn/kernel/io_acpi_init.c         |    3 +
 drivers/acpi/Kconfig                       |   11 ----
 drivers/acpi/bus.c                         |    3 +
 drivers/acpi/ec.c                          |    4 -
 drivers/acpi/ibm_acpi.c                    |   13 ----
 drivers/acpi/processor_core.c              |    3 -
 drivers/acpi/processor_perflib.c           |    4 -
 include/linux/acpi.h                       |    1 
 12 files changed, 97 insertions(+), 42 deletions(-)

through these commits:

Henrique de Moraes Holschuh (1):
      Revert "ACPI: ibm-acpi: make non-generic bay support optional"

John Keller (1):
      ACPI: Altix: ACPI _PRT support

Len Brown (3):
      ACPI: ec: enable printk on cmdline use
      ACPI: schedule obsolete features for deletion
      ACPI: update MAINTAINERS

Venkatesh Pallipadi (2):
      ACPI: rename cstate_entry_s to cstate_entry
      ACPI: delete two spurious ACPI messages

with this log:

commit d2fadbbbf0e42b842731da71864f222e7f119461
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Thu Jan 11 02:58:15 2007 -0500

    Revert "ACPI: ibm-acpi: make non-generic bay support optional"
    
    This reverts commit 2df910b4c3edcce9a0c12394db6f5f4a6e69c712.
    
    ACPI_BAY has not been merged into mainline yet, so the changes to ibm-acpi
    related Kconfig entries that depend on ACPI_BAY were permanently disabling
    ibm-acpi bay support.  This is a serious regression for ThinkPad users.
    
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8f6d63adf8309a412bf2d3d2e49a85e519ebf57c
Merge: 85f4544... 3948ec9...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jan 11 01:55:34 2007 -0500

    Pull sgi into release branch

commit 85f4544fbf02f60993c76f5b92517a87f220472d
Merge: f3a2c3e... 8b59a45...
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jan 11 01:55:25 2007 -0500

    Pull trivial into release branch

commit 8b59a454c421542a51c391f542c80d165f7547a0
Author: Len Brown <len.brown@intel.com>
Date:   Mon Jan 8 19:03:28 2007 -0500

    ACPI: update MAINTAINERS
    
    s/Maintained/Supported/
    and document some sub-maintainers for ACPI drivers.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1bb67c2582f4271488721001a707124fd0af347e
Author: Len Brown <len.brown@intel.com>
Date:   Thu Jan 11 01:49:44 2007 -0500

    ACPI: schedule obsolete features for deletion
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d6637b28ffb38f207015c990e481fde5bba233d7
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Wed Jan 10 23:16:36 2007 -0500

    ACPI: delete two spurious ACPI messages
    
    ACPI: Getting cpuindex for acpiid 0x4
    
    acpi_processor-0742 [00] processor_preregister_: Error while parsing _PSD domain information. Assuming no coordination
    
    http://bugzilla.kernel.org/show_bug.cgi?id=7286
    
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5d65131fa8d333d4575e7dfe5a05d3a9fa4a687e
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Wed Jan 10 23:08:38 2007 -0500

    ACPI: rename cstate_entry_s to cstate_entry
    
    style change only.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 723fe2ca82d1ffc80c9d53035babf011f84c65d4
Author: Len Brown <len.brown@intel.com>
Date:   Sat Jan 6 00:02:07 2007 -0500

    ACPI: ec: enable printk on cmdline use
    
    if somebody uses "ec_intr=", lets be sure to
    capture that in the dmesg even in the non-debug case.
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3948ec9406f9a60a43d63f23f6f5284db6529b9c
Author: John Keller <jpk@sgi.com>
Date:   Fri Dec 22 11:50:04 2006 -0600

    ACPI: Altix: ACPI _PRT support
    
    Provide ACPI _PRT support for SN Altix systems.
    
    The SN Altix platform does not conform to the
    IOSAPIC IRQ routing model, so a new acpi_irq_model
    (ACPI_IRQ_MODEL_PLATFORM) has been defined. The SN
    platform specific code sets acpi_irq_model to
    this new value, and keys off of it in acpi_register_gsi()
    to avoid the iosapic code path.
    
    Signed-off-by: John Keller <jpk@sgi.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
