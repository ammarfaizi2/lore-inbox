Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274196AbSITAtS>; Thu, 19 Sep 2002 20:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274198AbSITAtS>; Thu, 19 Sep 2002 20:49:18 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:37386 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274196AbSITAtR>;
	Thu, 19 Sep 2002 20:49:17 -0400
Date: Thu, 19 Sep 2002 17:54:08 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI hotplug changes for 2.5.36
Message-ID: <20020920005408.GA18583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI hotplug changes for 2.5.36.
	  
Please pull from:  bk://linuxusb.bkbits.net/pci_hp-2.5

thanks,

greg k-h


 drivers/hotplug/cpqphp.h           |    9 -
 drivers/hotplug/cpqphp_core.c      |   66 ++++++--
 drivers/hotplug/cpqphp_ctrl.c      |    4 
 drivers/hotplug/ibmphp_core.c      |   32 ++--
 drivers/hotplug/pci_hotplug.h      |   28 +++
 drivers/hotplug/pci_hotplug_core.c |  290 +++++++++++++++++++++++++++++++------
 drivers/pci/proc.c                 |    3 
 kernel/ksyms.c                     |    2 
 8 files changed, 353 insertions(+), 81 deletions(-)
-----

ChangeSet@1.564, 2002-09-19 17:47:49-07:00, greg@kroah.com
  PCI Hotplug: created /proc/bus/pci/slots for pcihpfs to be mounted on.
  
  proc_bus_pci_dir had to be exported for this to work properly.

 drivers/hotplug/pci_hotplug_core.c |   17 +++++++++++++++++
 drivers/pci/proc.c                 |    3 ++-
 2 files changed, 19 insertions(+), 1 deletion(-)
------

ChangeSet@1.563, 2002-09-19 17:45:19-07:00, greg@kroah.com
  PCI Hotplug Core: Add allocation sanity checks.  Patch from Silvio Cesare

 drivers/hotplug/pci_hotplug_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.562, 2002-09-19 17:43:34-07:00, greg@kroah.com
  PCI Hotplug: added speed status to the IBM driver.

 drivers/hotplug/ibmphp_core.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)
------

ChangeSet@1.561, 2002-09-19 17:43:07-07:00, greg@kroah.com
  PCI Hotplug: added speed status to the Compaq driver.

 drivers/hotplug/cpqphp.h      |    9 +----
 drivers/hotplug/cpqphp_core.c |   66 ++++++++++++++++++++++++++++++++++--------
 drivers/hotplug/cpqphp_ctrl.c |    4 +-
 3 files changed, 59 insertions(+), 20 deletions(-)
------

ChangeSet@1.560, 2002-09-19 17:40:04-07:00, greg@kroah.com
  PCI Hotplug: added max bus speed and current bus speed files to the pci hotplug core.
        
  Patch based on work done by Irene Zubarev <zubarev@us.ibm.com>

 drivers/hotplug/pci_hotplug.h      |   28 ++++
 drivers/hotplug/pci_hotplug_core.c |  249 +++++++++++++++++++++++++++++++------
 2 files changed, 242 insertions(+), 35 deletions(-)
------

ChangeSet@1.559, 2002-09-19 17:37:13-07:00, greg@kroah.com
  export __inode_dir_notify so that dnotify can be called from filesystems in modules.

 kernel/ksyms.c |    2 ++
 1 files changed, 2 insertions(+)
------

ChangeSet@1.558, 2002-09-19 17:29:16-07:00, scottm@somanetworks.com
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

