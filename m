Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274544AbSITAyr>; Thu, 19 Sep 2002 20:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274438AbSITAxi>; Thu, 19 Sep 2002 20:53:38 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:43786 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274205AbSITAw5>;
	Thu, 19 Sep 2002 20:52:57 -0400
Date: Thu, 19 Sep 2002 17:57:49 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] More PCI Hotplug changes for 2.4.20-pre7
Message-ID: <20020920005749.GI18583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more PCI Hotplug updates.

Please pull from:  bk://linuxusb.bkbits.net/pci_hp-2.4

Patches will follow.

thanks,

greg k-h

 drivers/hotplug/cpqphp.h           |    9 -
 drivers/hotplug/cpqphp_core.c      |   84 +++++++---
 drivers/hotplug/cpqphp_ctrl.c      |    4 
 drivers/hotplug/ibmphp_core.c      |   32 ++--
 drivers/hotplug/pci_hotplug.h      |   28 +++
 drivers/hotplug/pci_hotplug_core.c |  292 +++++++++++++++++++++++++++++++------
 drivers/pci/pci.c                  |    1 
 drivers/pci/proc.c                 |    2 
 include/linux/pci.h                |    1 
 kernel/ksyms.c                     |    2 
 10 files changed, 364 insertions(+), 91 deletions(-)
-----

ChangeSet@1.690, 2002-09-19 16:37:21-07:00, greg@kroah.com
  PCI Hotplug: created /proc/bus/pci/slots for pcihpfs to be mounted on.
  
  proc_bus_pci_dir had to be exported for this to work properly.

 drivers/hotplug/pci_hotplug_core.c |   19 ++++++++++++++++++-
 drivers/pci/pci.c                  |    1 +
 drivers/pci/proc.c                 |    2 +-
 include/linux/pci.h                |    1 +
 4 files changed, 21 insertions(+), 2 deletions(-)
------

ChangeSet@1.689, 2002-09-19 15:47:45-07:00, greg@kroah.com
  PCI Hotplug Core: Add allocation sanity checks.  Patch from Silvio Cesare

 drivers/hotplug/pci_hotplug_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.688, 2002-09-18 17:55:45-07:00, greg@kroah.com
  add export for __inode_dir_notify so dnotify can be used from filesystems in a modules.

 kernel/ksyms.c |    2 ++
 1 files changed, 2 insertions(+)
------

ChangeSet@1.687, 2002-09-18 17:05:59-07:00, greg@kroah.com
  PCI Hotplug: added speed status to the Compaq driver.

 drivers/hotplug/cpqphp.h      |    9 +---
 drivers/hotplug/cpqphp_core.c |   84 +++++++++++++++++++++++++++++++-----------
 drivers/hotplug/cpqphp_ctrl.c |    4 +-
 3 files changed, 68 insertions(+), 29 deletions(-)
------

ChangeSet@1.686, 2002-09-18 17:05:06-07:00, greg@kroah.com
  PCI Hotplug: added speed status to the IBM driver.

 drivers/hotplug/ibmphp_core.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)
------

ChangeSet@1.685, 2002-09-18 17:04:18-07:00, greg@kroah.com
  PCI Hotplug: added max bus speed and current bus speed files to the pci hotplug core.
      
  Patch based on work done by Irene Zubarev <zubarev@us.ibm.com>

 drivers/hotplug/pci_hotplug.h      |   28 ++++
 drivers/hotplug/pci_hotplug_core.c |  249 +++++++++++++++++++++++++++++++------
 2 files changed, 242 insertions(+), 35 deletions(-)
------

ChangeSet@1.684, 2002-09-18 15:53:50-07:00, scottm@somanetworks.com
  [PATCH] Small pcihpfs dnotify fix
  
  I've been working on a userspace daemon to go with my CompactPCI driver,
  and yesterday I discovered an oversight in pci_hp_change_slot_info - it
  doesn't call dnotify_parent, so dnotify based clients basically don't
  work against pcihpfs.  The following patch (against 2.5 BK) reworks
  things to just update the mtime (since we're modifying the file after
  all), and then call dnotify_parent.

 drivers/hotplug/pci_hotplug_core.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)
------

