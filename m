Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTFEUrl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265129AbTFEUqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:46:49 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:18356 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265127AbTFEUqJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:46:09 -0400
Date: Thu, 5 Jun 2003 14:00:13 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] More PCI fixes for 2.5.70
Message-ID: <20030605210013.GA6917@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's some more PCI changes against the latest 2.5.70 bk tree.  They contain
the following:
	- fix up the fusion driver due to errors from my last round of
	  pci patches.
	- remove last direct accesses of the pci_devices variable.
Now the pci_devices variable is not exported for drivers to touch
directly.  Only the pci core and arch specific pci code should access
this variable.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.5

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 arch/m68k/atari/hades-pci.c           |    4 +--
 drivers/ide/setup-pci.c               |    2 -
 drivers/macintosh/via-pmu68k.c        |   11 +++++----
 drivers/message/fusion/linux_compat.h |    7 +----
 drivers/message/fusion/mptbase.c      |    2 -
 drivers/pci/probe.c                   |    1 
 drivers/pci/search.c                  |   40 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h                   |   20 +++++++----------
 8 files changed, 61 insertions(+), 26 deletions(-)
-----

Greg Kroah-Hartman:
  o PCI: remove EXPORT_SYMBOL(pci_devices)
  o PCI: move pci_present() into drivers/pci/search.c
  o PCI: remove pci_for_each_dev_reverse() now that all users of it are gone
  o PCI: remove usage of pci_for_each_dev_reverse() in
  o PCI: add pci_find_device_reverse() for users of pci_find_each_dev_reverse() to use
  o PCI: fix up previous fusion driver pci changes
  o PCI: remove direct access of pci_devices from drivers/macintosh/via-pmu68k.c
  o PCI: remove direct access of pci_devices from arch/m68k/atari/hades-pci.c

