Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319738AbSIMS1d>; Fri, 13 Sep 2002 14:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319739AbSIMS1d>; Fri, 13 Sep 2002 14:27:33 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:63754 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319738AbSIMS1c>;
	Fri, 13 Sep 2002 14:27:32 -0400
Date: Fri, 13 Sep 2002 11:28:46 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI Hotplug changes for 2.4.20-pre7
Message-ID: <20020913182846.GA26589@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some fixes and updates for the IBM PCI Hotplug driver from
Irene Zubarev that enable the driver to work for older IBM machines, and
fixes some problems with large numbers of slots in the newer machines.

	Pull from:  bk://linuxusb.bkbits.net/pci_hp-2.4

Patches will follow.

thanks,

greg k-h

 drivers/hotplug/ibmphp.h      |   39 +-
 drivers/hotplug/ibmphp_core.c |  279 +++++++++++------
 drivers/hotplug/ibmphp_ebda.c |  673 ++++++++++++++++++++++++++++++++++--------
 drivers/hotplug/ibmphp_hpc.c  |  277 ++++++++++++-----
 drivers/hotplug/ibmphp_pci.c  |   53 ++-
 drivers/hotplug/ibmphp_res.c  |  317 ++++++++++++-------
 drivers/pci/pci.c             |    1 
 7 files changed, 1192 insertions(+), 447 deletions(-)
-----

ChangeSet@1.665, 2002-09-13 10:56:28-07:00, greg@kroah.com
  IBM PCI Hotplug driver: sync up with the 2.5 version (__init and formatting fixes)

 drivers/hotplug/ibmphp.h      |    1 
 drivers/hotplug/ibmphp_core.c |   46 +++++++++++++++++-------------------------
 drivers/hotplug/ibmphp_ebda.c |   29 +++++++++++++-------------
 drivers/hotplug/ibmphp_hpc.c  |   17 ++++++++-------
 drivers/hotplug/ibmphp_res.c  |   16 ++++++++------
 5 files changed, 52 insertions(+), 57 deletions(-)
------

ChangeSet@1.664, 2002-09-13 10:43:40-07:00, greg@kroah.com
  [PATCH] export pci_scan_bus, as the IBM pci hotplug driver needs it.
  

 drivers/pci/pci.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.663, 2002-09-13 10:43:27-07:00, zubarev@us.ibm.com
  [PATCH] IBM PCI Hotplug driver update for PCI based controllers
  

 drivers/hotplug/ibmphp.h      |    1 
 drivers/hotplug/ibmphp_core.c |    5 ++
 drivers/hotplug/ibmphp_ebda.c |   71 ++++++++++++++++++++++++++++++++++++++----
 drivers/hotplug/ibmphp_hpc.c  |   26 +++++++++++++++
 4 files changed, 97 insertions(+), 6 deletions(-)
------

ChangeSet@1.662, 2002-09-13 10:43:08-07:00, zubarev@us.ibm.com
  [PATCH] IBM PCI Hotplug driver update for ISA based devices
  

 drivers/hotplug/ibmphp_ebda.c |   13 ++++++++++---
 drivers/hotplug/ibmphp_hpc.c  |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)
------

ChangeSet@1.661, 2002-09-13 10:42:55-07:00, zubarev@us.ibm.com
  [PATCH] IBM PCI Hotplug driver update
  
  - fix polling logic
  - add ability to write [chassis/rxe]#slot# instead of just slot#

 drivers/hotplug/ibmphp.h      |   37 ++
 drivers/hotplug/ibmphp_core.c |  228 +++++++++++------
 drivers/hotplug/ibmphp_ebda.c |  560 ++++++++++++++++++++++++++++++++++--------
 drivers/hotplug/ibmphp_hpc.c  |  200 +++++++++------
 drivers/hotplug/ibmphp_pci.c  |   53 ++-
 drivers/hotplug/ibmphp_res.c  |  301 ++++++++++++++--------
 6 files changed, 998 insertions(+), 381 deletions(-)
------

