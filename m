Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264051AbTJOSv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263926AbTJOSvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:51:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:62129 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263933AbTJOS01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:26:27 -0400
Date: Wed, 15 Oct 2003 11:23:21 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI fixes for 2.6.0-test7
Message-ID: <20031015182321.GA22284@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI fixes for 2.6.0-test7.  They fix up a lot of pci
drivers that mistakenly mark their probe function with "__init".  This
causes oopses if CONFIG_HOTPLUG is enabled and users write to the
"new_id" sysfs file.  I've also cleaned up some MOD_INC and MOD_DEC
compiler warnings that were present in some OSS and other char drivers.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/char/agp/ali-agp.c      |    4 ++--
 drivers/char/agp/amd-k7-agp.c   |    6 +++---
 drivers/char/agp/amd64-agp.c    |   10 +++++-----
 drivers/char/agp/ati-agp.c      |    6 +++---
 drivers/char/agp/i460-agp.c     |    4 ++--
 drivers/char/agp/intel-agp.c    |    4 ++--
 drivers/char/agp/nvidia-agp.c   |    4 ++--
 drivers/char/agp/sis-agp.c      |    6 +++---
 drivers/char/agp/sworks-agp.c   |    4 ++--
 drivers/char/agp/uninorth-agp.c |    6 +++---
 drivers/char/agp/via-agp.c      |    6 +++---
 drivers/char/ite_gpio.c         |    9 ---------
 drivers/char/synclink.c         |    4 ++--
 drivers/char/synclinkmp.c       |    4 ++--
 sound/oss/ad1889.c              |    6 ++----
 sound/oss/ali5455.c             |    8 ++++----
 sound/oss/cs4281/cs4281m.c      |   11 +++--------
 sound/oss/cs46xx.c              |    6 ------
 sound/oss/i810_audio.c          |    6 +++---
 sound/oss/maestro3.c            |    4 ++--
 sound/oss/swarm_cs4297a.c       |    8 ++------
 sound/oss/trident.c             |    4 ++--
 sound/oss/via82cxxx_audio.c     |   10 +++++-----
 23 files changed, 57 insertions(+), 83 deletions(-)
-----

Greg Kroah-Hartman:
  o OSS: fix up MOD_INC and MOD_DEC usages to remove compiler warnings
  o CHAR: Remove unneeded MOD_INC and MOD_DEC calls
  o PCI: fix up probe functions for OSS drivers
  o PCI: fix up probe functions for synclink drivers
  o PCI: fix up probe functions for agp drivers

