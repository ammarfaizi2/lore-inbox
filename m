Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSJ2TP4>; Tue, 29 Oct 2002 14:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbSJ2TP4>; Tue, 29 Oct 2002 14:15:56 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:41485 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262038AbSJ2TPz>;
	Tue, 29 Oct 2002 14:15:55 -0500
Date: Tue, 29 Oct 2002 11:19:43 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI hotplug changes for 2.5.44
Message-ID: <20021029191942.GG27082@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI hotplug changes for 2.5.44.  These are the same as the
ones I submitted against 2.5.41 that were never pulled.
	  
Please pull from:  bk://linuxusb.bkbits.net/pci_hp-2.5

thanks,

greg k-h


 drivers/hotplug/Config.help    |   11 
 drivers/hotplug/Config.in      |    1 
 drivers/hotplug/Makefile       |   13 
 drivers/hotplug/acpiphp.h      |  263 +++++++
 drivers/hotplug/acpiphp_core.c |  502 ++++++++++++++
 drivers/hotplug/acpiphp_glue.c | 1463 +++++++++++++++++++++++++++++++++++++++++
 drivers/hotplug/acpiphp_pci.c  |  692 +++++++++++++++++++
 drivers/hotplug/acpiphp_res.c  |  699 +++++++++++++++++++
 drivers/hotplug/cpqphp_core.c  |    4 
 drivers/hotplug/cpqphp_pci.c   |    4 
 drivers/hotplug/ibmphp_core.c  |   47 -
 11 files changed, 3679 insertions(+), 20 deletions(-)
-----

ChangeSet@1.733.4.4, 2002-10-09 15:30:59-07:00, greg@kroah.com
  IBM PCI Hotplug: fix typos in previous patch

 drivers/hotplug/ibmphp_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.733.4.3, 2002-10-09 15:07:57-07:00, t-kouchi@mvf.biglobe.ne.jp
  [PATCH] ACPI PCI hotplug driver for 2.5
  

 drivers/hotplug/Config.help    |   11 
 drivers/hotplug/Config.in      |    1 
 drivers/hotplug/Makefile       |   13 
 drivers/hotplug/acpiphp.h      |  263 +++++++
 drivers/hotplug/acpiphp_core.c |  502 ++++++++++++++
 drivers/hotplug/acpiphp_glue.c | 1463 +++++++++++++++++++++++++++++++++++++++++
 drivers/hotplug/acpiphp_pci.c  |  692 +++++++++++++++++++
 drivers/hotplug/acpiphp_res.c  |  699 +++++++++++++++++++
 8 files changed, 3644 insertions(+)
------

ChangeSet@1.733.4.2, 2002-10-09 15:03:36-07:00, Dan.Zink@hp.com
  [PATCH] Compaq PCI Hotplug bug fix
  
  Found the bug.  The following patch fixes the hot plug
  driver so that it has a fallback when there are no unused
  IRQs on a system.  At some point intialization got re-
  ordered and this was broken.
  
  I found another bug that was preventing the existing scheme from
  working.  It looks like the function "pcibios_set_irq_routing" is
  returning 1 for success, but the hot plug driver was interpreting it as
  failure.

 drivers/hotplug/cpqphp_core.c |    4 +++-
 drivers/hotplug/cpqphp_pci.c  |    4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)
------

ChangeSet@1.733.4.1, 2002-10-09 15:02:46-07:00, zubarev@us.ibm.com
  [PATCH] IBM PCI Hotplug: small patch
  
  This is a small patch on top of what you sent out to the kernel
  already.  I basically uncommented out another place, where we call
  pci_hp_change_info and changed to the new method.  And also, when I sent
  you those (polling, isa, pci...) patches sometime back, I made a mistake
  when I was translating the code from the way RPM is to the way we want in
  the kernel (since in RPM we cannot have option to compile kernel).

 drivers/hotplug/ibmphp_core.c |   43 +++++++++++++++++++++++++++---------------
 1 files changed, 28 insertions(+), 15 deletions(-)
------

