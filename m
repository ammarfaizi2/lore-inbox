Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSLPXmm>; Mon, 16 Dec 2002 18:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbSLPXmm>; Mon, 16 Dec 2002 18:42:42 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:18700 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261349AbSLPXmk>;
	Mon, 16 Dec 2002 18:42:40 -0500
Date: Mon, 16 Dec 2002 15:48:17 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI Hotplug changes for 2.4.21-pre1
Message-ID: <20021216234817.GD17214@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an update for the PCI Hotplug core and the PCI ACPI Hotplug
driver.  This fixes a problem for ia64 machines, enabling the driver to
now work properly.  Thanks go out to Matthew Wilcox for finally fixing
this problem.

Please pull from:  bk://linuxusb.bkbits.net/pci_hp-2.4

The raw patches will follow.

thanks,

greg k-h


 drivers/hotplug/acpiphp.h          |    2 
 drivers/hotplug/acpiphp_glue.c     |   16 --
 drivers/hotplug/acpiphp_pci.c      |   48 +++----
 drivers/hotplug/pci_hotplug.h      |   12 +
 drivers/hotplug/pci_hotplug_util.c |  223 ++++++++++++++++++++++---------------
 5 files changed, 176 insertions(+), 125 deletions(-)
-----

ChangeSet@1.886, 2002-12-16 11:47:08-08:00, willy@debian.org
  [PATCH] Convert acpiphp to pci_bus_*() API [2/2]
  
  Convert the acpiphp driver from the pci_*_nodev() API to the pci_bus_*() API.
  This patch is relative to 2.4.21-bk.

 drivers/hotplug/acpiphp.h      |    2 -
 drivers/hotplug/acpiphp_glue.c |   16 ++-----------
 drivers/hotplug/acpiphp_pci.c  |   48 +++++++++++++++++++----------------------
 3 files changed, 26 insertions(+), 40 deletions(-)
------

ChangeSet@1.885, 2002-12-16 11:46:55-08:00, willy@debian.org
  [PATCH] Add pci_bus_*() API for 2.4 [1/2]
  
  Introduce the pci_bus_(read|write)_config(byte|word|dword) functions from
  Linux 2.5.  Reimplement the pci_(read|write)_config(byte|word|dword)_nodev
  functions as compatibility wrappers.

 drivers/hotplug/pci_hotplug.h      |   12 +
 drivers/hotplug/pci_hotplug_util.c |  223 ++++++++++++++++++++++---------------
 2 files changed, 150 insertions(+), 85 deletions(-)
------

