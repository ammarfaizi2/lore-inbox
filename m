Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265759AbSKTFQg>; Wed, 20 Nov 2002 00:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbSKTFQg>; Wed, 20 Nov 2002 00:16:36 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:1298 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265759AbSKTFQe>;
	Wed, 20 Nov 2002 00:16:34 -0500
Date: Tue, 19 Nov 2002 21:17:02 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] pcibios removal changes for 2.5.48
Message-ID: <20021120051702.GB21953@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few changesets that removes almost all of the remaining usages
of pcibios_read_config* and pcibios_write_config* calls.  It also
removes them from pci.h and deletes drivers/pci/compat.c.

These changes have been in the -ac tree for a while, and I have been
running a lot of different types of machines with them for a number of
weeks (servers to laptops).



Please pull from:  bk://linuxusb.bkbits.net/pci-2.5



There are still a small number of places in the tree where these
functions show up, but the usage falls into one of three categories:

 - compatibility code for older kernels.  This includes the following
   files:
	drivers/scsi/gdth.c
	drivers/scsi/sym53c8xx.c
	drivers/scsi/sym53c8xx_comm.h
	drivers/scsi/tmscsim.c
	drivers/scsi/megaraid.c
	drivers/net/wan/sdladrv.c
	drivers/char/ip2main.c
	linux/compatmac.h

 - drivers that are outdated and do not build anyway:
	drivers/isdn/hisax/hfc_pci.c
	drivers/isdn/eicon/lincfg.c
	drivers/isdn/eicon/linio.c

 - arch specific code that I can not build, nor test.  A number of these
   instances contain code that directly touches hardware (the network
   driver is an example of that), or is doing other platform specific
   stuff that I do not know how to fix:
	drivers/video/S3triofb.c
	drivers/net/gt96100eth.c
	alpha/kernel/sys_nautilus.c
	alpha/kernel/sys_sio.c


I also think that a number of older pcibios functions can be removed
from m68knommu/kernel/comempci.c, but will have to ask the author of
that file first.

thanks,

greg k-h



 drivers/pci/compat.c        |   37 -------------------------------------
 drivers/isdn/hisax/bkm_a8.c |   23 ++++++++---------------
 drivers/pci/Makefile        |    4 ++--
 drivers/pcmcia/cistpl.c     |    5 ++++-
 include/linux/pci.h         |   17 -----------------
 5 files changed, 14 insertions(+), 72 deletions(-)
-----

ChangeSet@1.872.3.3, 2002-11-19 20:30:40-08:00, greg@kroah.com
  PCI: removed pcibios_read_config_* and pcibios_write_config_* functions.

 drivers/pci/compat.c |   37 -------------------------------------
 drivers/pci/Makefile |    4 ++--
 include/linux/pci.h  |   17 -----------------
 3 files changed, 2 insertions(+), 56 deletions(-)
------

ChangeSet@1.872.3.2, 2002-11-19 20:24:56-08:00, greg@kroah.com
  PCMCIA: remove usage of pcibios_read_config_dword

 drivers/pcmcia/cistpl.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)
------

ChangeSet@1.872.3.1, 2002-11-19 20:23:31-08:00, greg@kroah.com
  ISDN: Convert usages of pcibios_* functions to pci_*

 drivers/isdn/hisax/bkm_a8.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)
------

