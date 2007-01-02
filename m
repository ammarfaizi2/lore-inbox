Return-Path: <linux-kernel-owner+w=401wt.eu-S1755272AbXABFbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbXABFbN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 00:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755273AbXABFbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 00:31:13 -0500
Received: from hera.kernel.org ([140.211.167.34]:42093 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755270AbXABFbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 00:31:11 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Linus Torvalds <torvalds@osdl.org>
Subject: [GIT PATCH] ACPI related patches for 2.6.20-rc3
Date: Tue, 2 Jan 2007 00:30:28 -0500
User-Agent: KMail/1.9.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, Doug Chapman <doug.chapman@hp.com>,
       Guillaume Chazarain <guichaz@yahoo.fr>,
       Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701020030.29177.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

A couple of small self-explanatory patches,
they will will update the files shown below.

thanks!

-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.20/acpi-release-20060707-2.6.20-rc3.diff.gz

 arch/i386/kernel/acpi/boot.c        |    2 +-
 drivers/acpi/ec.c                   |    2 +-
 drivers/video/backlight/corgi_bl.c  |    2 +-
 drivers/video/backlight/hp680_bl.c  |    2 +-
 drivers/video/backlight/locomolcd.c |    2 +-
 include/acpi/acconfig.h             |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

through these commits:

Doug Chapman (1):
      ACPI: increase ACPI_MAX_REFERENCE_COUNT for larger systems

Guillaume Chazarain (1):
      ACPI: EC: move verbose printk to debug build only

Len Brown (1):
      ACPI: fix section mis-match build warning

Richard Purdie (1):
      backlight: fix backlight_device_register compile failures

with this log:

commit e82c354bb26a9da6fed1fadf7082d68055b7d1db
Author: Len Brown <len.brown@intel.com>
Date:   Thu Dec 21 01:29:59 2006 -0500

    ACPI: fix section mis-match build warning
    
    Dunno why this pops out in only in the allmodconfig build.
    Though the warning is accurate, all the callers of the flagged
    non __init function are __init, this is not a functional change.
    
    WARNING: vmlinux - Section mismatch: reference to .init.data:acpi_sci_flags from .text between 'acpi_sci_ioapic_setup' (at offset 0xc010f0a
    6) and 'acpi_gsi_to_irq'                                                                                                                   WARNING: vmlinux - Section mismatch: reference to .init.text:mp_override_legacy_irq from .text between 'acpi_sci_ioapic_setup' (at offset 0
    xc010f0de) and 'acpi_gsi_to_irq'                                                                                                           WARNING: vmlinux - Section mismatch: reference to .init.data:acpi_sci_override_gsi from .text between 'acpi_sci_ioapic_setup' (at offset 0x
    c010f0e4) and 'acpi_gsi_to_irq'
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9a654b522234615a76717f35365ca4a8beb757df
Author: Doug Chapman <doug.chapman@hp.com>
Date:   Thu Dec 21 12:11:43 2006 -0500

    ACPI: increase ACPI_MAX_REFERENCE_COUNT for larger systems
    
    We have some new larger ia64 systems in HP that trip over the
    ACPI_MAX_REFERENCE_COUNT limit which triggers a large number of these
    debug messages:
    
    ACPI Warning (utdelete-0397): Large Reference Count (XXX) in object e0000a0ff6797ab0  [20060707]
    
    This was increased once in the past as described in this very brief thread:
    
    http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg00890.html
    
    Signed-off-by: Doug Chapman <doug.chapman@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c6e19194b6e1a565f8fe18d56d509e9892c32ee1
Author: Guillaume Chazarain <guichaz@yahoo.fr>
Date:   Sun Dec 24 22:19:02 2006 +0100

    ACPI: EC: move verbose printk to debug build only
    
    The recent EC cleanup left a printk enabled on handler evaluation
    resulting in a bunch of messages on normal operation, like so:
    
    ACPI: EC: evaluating _Q60
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 27c5d745ac685c3f48cebd7a9c07707755b4b711
Author: Richard Purdie <rpurdie@rpsys.net>
Date:   Sat Dec 30 15:40:11 2006 +0000

    backlight: fix backlight_device_register compile failures
    
    Fix breakage from commit 519ab5f2be65b72cf12ae99c89752bbe79b44df6 which
    didn't update all references to backlight_device_register causing
    compile failures.
    
    Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
    Signed-off-by: Len Brown <len.brown@intel.com>
