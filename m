Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUERAVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUERAVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 20:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUERAVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 20:21:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:19687 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262932AbUERAVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 20:21:37 -0400
Date: Mon, 17 May 2004 17:20:57 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI and PCI Hotplug update for 2.6.6
Message-ID: <20040518002057.GA26925@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI and PCI hotplug patches for 2.6.6.  The majority of
these are PCI Hotplug code cleanups, with some good PCI core bug fixes
too.  These have all been in the -mm tree for a number of weeks now.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'm not going to send these patches to the lkml as the majority of
them are minor cleanup fixes.  But they will end up in my kernel.org
directory in a few days if people are interested.


 CREDITS                                 |    8 
 arch/i386/pci/irq.c                     |    4 
 drivers/pci/hotplug/acpiphp.h           |    5 
 drivers/pci/hotplug/acpiphp_core.c      |  270 --
 drivers/pci/hotplug/acpiphp_glue.c      |  106 -
 drivers/pci/hotplug/acpiphp_res.c       |    8 
 drivers/pci/hotplug/cpci_hotplug.h      |    3 
 drivers/pci/hotplug/cpci_hotplug_core.c |  162 -
 drivers/pci/hotplug/cpci_hotplug_pci.c  |    2 
 drivers/pci/hotplug/cpcihp_generic.c    |   67 
 drivers/pci/hotplug/cpcihp_zt5550.c     |   11 
 drivers/pci/hotplug/cpqphp.h            |  242 --
 drivers/pci/hotplug/cpqphp_core.c       |  510 ++---
 drivers/pci/hotplug/cpqphp_ctrl.c       | 1565 ++++++++--------
 drivers/pci/hotplug/cpqphp_pci.c        |   82 
 drivers/pci/hotplug/ibmphp.h            |    2 
 drivers/pci/hotplug/ibmphp_core.c       |    2 
 drivers/pci/hotplug/ibmphp_res.c        |    1 
 drivers/pci/hotplug/pci_hotplug_core.c  |    9 
 drivers/pci/hotplug/pciehp.h            |   72 
 drivers/pci/hotplug/pciehp_core.c       |  393 +---
 drivers/pci/hotplug/pciehp_ctrl.c       | 1269 +++++++------
 drivers/pci/hotplug/pciehp_hpc.c        |   82 
 drivers/pci/hotplug/pciehp_pci.c        |  367 +--
 drivers/pci/hotplug/pciehprm.h          |    1 
 drivers/pci/hotplug/pciehprm_acpi.c     |    2 
 drivers/pci/hotplug/pciehprm_nonacpi.c  |    5 
 drivers/pci/hotplug/pcihp_skeleton.c    |  255 +-
 drivers/pci/hotplug/rpadlpar_core.c     |   20 
 drivers/pci/hotplug/rpaphp.h            |    3 
 drivers/pci/hotplug/rpaphp_core.c       |  106 -
 drivers/pci/hotplug/rpaphp_pci.c        |   38 
 drivers/pci/hotplug/rpaphp_slot.c       |   88 
 drivers/pci/hotplug/rpaphp_vio.c        |    1 
 drivers/pci/hotplug/shpchp.h            |    1 
 drivers/pci/hotplug/shpchp_core.c       |  247 --
 drivers/pci/hotplug/shpchp_ctrl.c       |  218 +-
 drivers/pci/hotplug/shpchp_pci.c        |  368 +--
 drivers/pci/hotplug/shpchprm.h          |    1 
 drivers/pci/hotplug/shpchprm_acpi.c     |    4 
 drivers/pci/hotplug/shpchprm_legacy.c   |    5 
 drivers/pci/hotplug/shpchprm_nonacpi.c  |    5 
 drivers/pci/pci.c                       |    2 
 drivers/pci/pci.ids                     | 2948 +++++++++++++++++++++++++++-----
 drivers/pci/probe.c                     |    2 
 include/linux/pci_ids.h                 |    1 
 46 files changed, 5356 insertions(+), 4207 deletions(-)
-----


Alan Cox:
  o PCI crash with pciless box or pci=off workaround on Vaio's

Andrew Morton:
  o PCI Hotplug: pciehp-linkage-fix.patch

Deepak Saxena:
  o PCI: pci.ids update from sf.net + add IXP4xx to pci_ids.h

Greg Kroah-Hartman:
  o PCI Hotplug: clean up a lot of global symbols that do not need to be
  o PCI Hotplug: revert broken PCI Express hotplug patch
  o PCI Hotplug: fix build error due to previous patches
  o PCI Hotplug: fix stupid build bugs caused by previous patches

Herbert Xu:
  o acpiphp_glue.c oops fix

Jochen Hein:
  o PCI: message cleanup in PCI probe
  o PCI: I'm moving

John Rose:
  o PCI Hotplug: RPA DLPAR remove slot, return code fix

Linda Xie:
  o PCI Hotplug: rpaphp doesn't initialize slot's name
  o PCI Hotplug: rpaphp: set eeh option (enabled ) prior to any i/o to newly added IOA

Luiz Capitulino:
  o PCI Hotplug: fix wrong var used in hotplug/shpchp_ctrl.c

Matt Domsch:
  o PCI: PCI devices with no PCI_CACHE_LINE_SIZE implemented

Rolf Eike Beer:
  o SHPC PCI Hotplug: fix cleanup_slots again
  o PCI Express, SHPCHP: fix freeing wrong resources
  o CompactPCI: remove two useless functions
  o CompactPCI: remove slot_paranoia_check and get_slot
  o CompactPCI: remove useless NULL checks
  o CompactPCI: use goto for error handling
  o CompactPCI: remove two useless checks
  o CompactPCI: remove set_attention_status
  o SHPC PCI Hotplug: remove some useless casts
  o SHPC PCI Hotplug: more coding style fixes
  o SHPC PCI Hotplug: kill useless NULL checks
  o SHPC PCI Hotplug: codingstyle fixes
  o SHPC PCI Hotplug: use goto for error handling
  o SHPC PCI Hotplug: fix cleanup_slots to use a release function
  o SHPC PCI Hotplug: kill hardware_test
  o SHPC PCI Hotplug: use new style of module parameters
  o RPA PCI Hotplug: codingstyle fixes for rpaphp_pci.c
  o RPA PCI Hotplug: use goto for error handling in rpaphp_slot.c
  o RPA PCI Hotplug: remove useless NULL checks from rpaphp_core.c
  o RPA PCI Hotplug: fix up init_slots in rpaphp_core.c
  o RPA PCI Hotplug: codingstyle fixes for rpaphp_core.c
  o RPA PCI Hotplug: kill get_cur_bus_speed from rpaphp_core.c
  o RPA PCI Hotplug: use new style of module parameters
  o PCI Express Hotplug: codingstyle fixes for pciehp_pci.c
  o PCI Express Hotplug: kill more useless casts
  o PCI Express Hotplug: mark global variables static
  o PCI Express Hotplug: some cleanups
  o PCI Express Hotplug: remove useless kmalloc casts
  o PCI Express Hotplug: codingstyle fixes for pciehp.h
  o PCI Express Hotplug: use goto for error handling
  o Compaq PCI Hotplug: remove useless NULL checks from cpqphp_ctrl.c
  o PCI Express Hotplug: kill hardware_test
  o Compaq PCI Hotplug: kill useless kmalloc casts
  o RPA PCI Hotplug: Remove useless NULL checks
  o PCI Express Hotplug: remove useless NULL checks
  o Compaq PCI Hotplug: fix missing braces
  o PCI Express Hotplug: use new style of module parameters
  o PCI Hotplug: Move an often used while loop to an inline function
  o PCI Hotplug Core: use new style of module parameters
  o [BUGFIX] shpchp_pci.c: fix missing braces after if
  o PCI Hotplug: Remove type magic from kmalloc
  o Compaq PCI Hotplug: some final fixes for cpqphp_core.c
  o Compaq PCI Hotplug: coding style fixes for cpqphp_ctrl.c
  o Compaq PCI Hotplug: use goto for error handling in cpqphp_ctrl.c
  o Compaq PCI Hotplug: fix C++ style comments
  o Compaq PCI Hotplug: remove useless NULL checks from cpqphp_core.c
  o Compaq PCI Hotplug: use goto for error handling
  o Compaq PCI Hotplug: split up hardware_test
  o Compaq PCI Hotplug: more coding style fixes
  o Compaq PCI Hotplug: use new style of module parameters
  o Compaq PCI Hotplug: move huge inline function out of header file
  o Compaq PCI Hotplug: remove useless NULL checks
  o Compaq PCI Hotplug: coding style fixes
  o PCI Express Hotplug: splut pciehp_ctrl.c::configure_new_function
  o PCI Express Hotplug: remove useless kmalloc casts
  o PCI Express Hotplug: fix coding style
  o PCI Hotplug skeleton: final cleanups
  o PCI Hotplug skeleton: use goto for error handling
  o PCI Hotplug skeleton: mark functions __init/__exit
  o PCI Hotplug skeleton: fix codingstyle
  o PCI Hotplug skeleton: remove useless NULL checks
  o PCI Hotplug skeleton: use new style of module parameters
  o ACPI PCI Hotplug: add a BUG() where one should be
  o ACPI PCI Hotplug: coding style fixes
  o ACPI PCI Hotplug: use goto for error handling
  o ACPI PCI Hotplug: kill magic number
  o ACPI PCI Hotplug: use new style of module parameters
  o CompactPCI Hotplug ZT5550: use new style of module parameters
  o CompactPCI Hotplug: kill magic number
  o CompactPCI Hotplug: remove unneeded funtion for parameter handling
  o PCI Hotplug: Clean up acpiphp_core.c: remove 3 get_* functions
  o PCI Hotplug: Clean up acpiphp_core.c: return
  o PCI Hotplug: Clean up acpiphp_core.c: use goto for error handling
  o PCI Hotplug: Clean up acpiphp_core.c: kill hardware_test
  o PCI Hotplug: Clean up acpiphp_core.c: coding style
  o PCI Hotplug: Clean up acpiphp_core.c: slot_paranoia_check
  o PCI Hotplug: Clean up acpiphp_core.c: null checks

