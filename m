Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262134AbSJJVnT>; Thu, 10 Oct 2002 17:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262407AbSJJVnT>; Thu, 10 Oct 2002 17:43:19 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:28686 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262134AbSJJVnS>;
	Thu, 10 Oct 2002 17:43:18 -0400
Date: Thu, 10 Oct 2002 14:44:56 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI Hotplug fixes for 2.4.20-pre10
Message-ID: <20021010214455.GA27523@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some small bugfixes for the Compaq and IBM PCI Hotplug drivers.

Please pull from:  bk://linuxusb.bkbits.net/pci_hp-2.4

Patches will follow.

thanks,

greg k-h

 drivers/hotplug/cpqphp_core.c |    4 ++-
 drivers/hotplug/cpqphp_pci.c  |    4 +--
 drivers/hotplug/ibmphp_core.c |   47 ++++++++++++++++++++++++++----------------
 3 files changed, 35 insertions(+), 20 deletions(-)
-----

ChangeSet@1.741, 2002-10-10 14:42:18-07:00, greg@kroah.com
  IBM PCI Hotplug driver: typo fix for previous patch.

 drivers/hotplug/ibmphp_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.740, 2002-10-10 14:38:55-07:00, zubarev@us.ibm.com
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

ChangeSet@1.739, 2002-10-10 14:36:51-07:00, Dan.Zink@hp.com
  [PATCH] Compaq PCI Hotplug bug fix 2
  
  Your patch may fix the issue, but I think there is an
  easier way.  I found another bug that was preventing the
  existing scheme from working.  It looks like the function
  "pcibios_set_irq_routing" is returning 1 for success, but
  the hot plug driver was interpreting it as failure.
  
  The attached 2 line patch fixes it for me.  I am able to
  add an Intel NIC on an ML370 G2 and receive interrupts from
  it.

 drivers/hotplug/cpqphp_pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.738, 2002-10-10 14:36:41-07:00, Dan.Zink@hp.com
  [PATCH] Compaq PCI Hotplug bug fix
  
  Found the bug.  The following patch fixes the hot plug
  driver so that it has a fallback when there are no unused
  IRQs on a system.  At some point intialization got re-
  ordered and this was broken.
  
  Greg, this should apply to 2.4 and 2.5 if you wouldn't
  mind submitting it.
  
  Thanks,
  Dan

 drivers/hotplug/cpqphp_core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)
------

