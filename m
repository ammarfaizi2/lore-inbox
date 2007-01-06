Return-Path: <linux-kernel-owner+w=401wt.eu-S932280AbXAGAPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbXAGAPi (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 19:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbXAGAPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 19:15:38 -0500
Received: from mout2.freenet.de ([194.97.50.155]:51196 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932280AbXAGAPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 19:15:37 -0500
X-Greylist: delayed 2617 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2007 19:15:37 EST
From: Sascha Sommer <saschasommer@freenet.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Experimental driver for Ricoh Bay1Controller SD Card readers
Date: Sun, 7 Jan 2007 00:32:26 +0100
User-Agent: KMail/1.9.5
Cc: rmk+mmc@arm.linux.org.uk
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LGDoFDotAVEdIza"
Message-Id: <200701070032.27234.saschasommer@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_LGDoFDotAVEdIza
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Attached is a very experimental driver for a Ricoh SD Card reader that can be 
found in some notebooks like the Samsung P35.

Whenever a sd card is inserted into one of these notebooks, a virtual pcmcia 
card will show up:

Socket 0:
  product info: "RICOH", "Bay1Controller", "", ""
  manfid: 0x0000, 0x0000

In order to write this driver I hacked qemu to have access to the cardbus 
bridge containing this card. I then logged the register accesses of the 
windows xp driver and tryed to analyse them.

As the meanings of most of the register are still unknown to me, I consider 
this driver very experimental. It is possible that this driver might destroy 
your data or your hardware. Use at your own risk! 

Other problems:
- I only implemented reading support
- I only tested with a 128 MB SD card, no idea what would be needed to support
  other card types
- irqs are not supported
- dma is not supported
- it is very slow
- the registers can be found on the cardbus bridge and not on the virtual 
  pcmcia card. The cardbus bridge is already claimed by yenta_socket. 
  Therefore the driver currently uses pci_find_device to find the cardbus
  bridge containing the sd card reader registers.
- it will probably crash when you remove the sd card without unmounting first
- the ios stuff is not really understood
- there are a bunch of extra MMC_APP_CMDs inside the driver
- only tested with kernel 2.6.18

apart from all these problems reading an image from my sd card seems to have 
worked ;) 

If you are still brave enough to try it out make at least a backup of the data 
on your sd card.

Feedback is highly appreciated.

Regards

Sascha


--Boundary-00=_LGDoFDotAVEdIza
Content-Type: text/x-makefile;
  charset="us-ascii";
  name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Makefile"

KERNEL_VERSION = $(shell uname -r)
KERNEL_DIR = /lib/modules/$(KERNEL_VERSION)/build
MDIR = /lib/modules/$(KERNEL_VERSION)/kernel/drivers/mmc

obj-m += sdricoh_cs.o

default:
	$(MAKE) -C $(KERNEL_DIR) SUBDIRS=$(PWD) modules

install:
	if test ! -d $(MDIR) ; then mkdir -p $(MDIR) ; fi
	install -D -m 644 *.ko $(MDIR)
	depmod -a

clean:
	rm -f *.o *.ko *.mod.c .*o.cmd .*o.d .*o.flags
	rm -rf .tmp_versions

--Boundary-00=_LGDoFDotAVEdIza
Content-Type: application/x-gzip;
  name="sdricoh_cs.c.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="sdricoh_cs.c.gz"

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

--Boundary-00=_LGDoFDotAVEdIza--
