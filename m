Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbUCWKoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUCWKoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:44:00 -0500
Received: from fmr05.intel.com ([134.134.136.6]:1745 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S262461AbUCWKnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:43:45 -0500
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1080038602.21688.317.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Mar 2004 05:43:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.26

	Several key fixes.
	SCI polarity/trigger fix
	cardbus bridge interrupt fix
	maxcpus=N/2 can now be used (like NR_CPUS) to disable HT

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.26/acpi-20040311-2.4.26.diff.gz

This will update the following files:

 Documentation/kernel-parameters.txt |    5 -
 arch/i386/kernel/acpi.c             |  111 +++++++++++++++++-------
 arch/i386/kernel/dmi_scan.c         |   13 +-
 arch/i386/kernel/mpparse.c          |   81 +++--------------
 arch/i386/kernel/setup.c            |   30 +++++-
 arch/i386/kernel/smpboot.c          |   16 ---
 arch/ia64/kernel/acpi.c             |    2 
 arch/x86_64/kernel/acpi.c           |  109 ++++++++++++++++-------
 arch/x86_64/kernel/e820.c           |   28 +++++-
 arch/x86_64/kernel/mpparse.c        |   74 +++-------------
 arch/x86_64/kernel/setup.c          |    3 
 arch/x86_64/kernel/smpboot.c        |   17 ---
 drivers/acpi/bus.c                  |   39 +++-----
 drivers/acpi/pci_irq.c              |   14 ++-
 drivers/acpi/processor.c            |    4 
 drivers/acpi/toshiba_acpi.c         |   55 +++++------
 drivers/char/sonypi.h               |    1 
 include/acpi/acpi_bus.h             |    2 
 include/asm-i386/acpi.h             |    3 
 include/asm-i386/mpspec.h           |    3 
 include/asm-ia64/acpi.h             |    2 
 include/asm-x86_64/acpi.h           |    5 -
 include/asm-x86_64/mpspec.h         |    1 
 include/asm-x86_64/proto.h          |    1 
 24 files changed, 315 insertions(+), 304 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/03/23 1.1063.46.88)
   [ACPI] ACPI SCI shall be level/low unless explicit over-ride
   http://bugzilla.kernel.org/show_bug.cgi?id=1622
   add "acpi_sci=edge" and "acpi_sci=high" manual over-ride

<len.brown@intel.com> (04/03/23 1.1063.46.87)
   [ACPI]   toshiba_acpi 0.18 from John Belmonte
     add missing copyin

<len.brown@intel.com> (04/03/22 1.1063.46.86)
   [ACPI] delete POWER_OF_2 array (Pavel Machek)

<len.brown@intel.com> (04/03/21 1.1063.46.85)
   [ACPI] fix interrupt behind yenta cardbus bridge (David Shaohua Li)
   http://bugzilla.kernel.org/show_bug.cgi?id=1564

<len.brown@intel.com> (04/03/20 1.1136.93.18)
   [ACPI] create disable_acpi()

<len.brown@intel.com> (04/03/18 1.1136.93.17)
   [ACPI] clean up acpi_disabled use
   __initdata on IA64 was a bug since it is referenced by modules.

<len.brown@intel.com> (04/03/17 1.1063.46.84)
   [ACPI] check "maxcpus=N" early -- same as NR_CPUS check.
   http://bugzilla.kernel.org/show_bug.cgi?id=2317
   
   When the BIOS enumerates physical processors before logical,
   maxcpus=N/2 will now effectively disable HT.
   
   This can be verified by boot messages warning that HT is off:
   eg. "maxcpus=2" on a 2xHT system:
   
   Total of 2 processors activated (11141.12 BogoMIPS).
   WARNING: No sibling found for CPU 0.
   WARNING: No sibling found for CPU 1.




