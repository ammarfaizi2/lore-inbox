Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267082AbSL3WPL>; Mon, 30 Dec 2002 17:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267085AbSL3WPL>; Mon, 30 Dec 2002 17:15:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:50959 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267082AbSL3WPJ>;
	Mon, 30 Dec 2002 17:15:09 -0500
Date: Mon, 30 Dec 2002 14:18:37 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, perex@perex.cz
Subject: [BK PATCH] PnP changes for 2.5.53
Message-ID: <20021230221836.GA814@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PnP changes from Jaroslav Kysela that finally remove the
isa pnp fields from the pci_dev and pci_bus structures.  They also fix
up a few other problems in some of the pnp drivers.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pnp-2.5

thanks,

greg k-h

 Documentation/isapnp.txt    |  193 +-------------------------------------------
 drivers/pcmcia/i82365.c     |   26 ++---
 drivers/pnp/card.c          |   14 ++-
 drivers/pnp/core.c          |    3 
 drivers/pnp/driver.c        |   16 ++-
 drivers/pnp/idlist.h        |    3 
 drivers/pnp/interface.c     |   20 ++++
 drivers/pnp/isapnp/Makefile |    4 
 drivers/pnp/isapnp/compat.c |   27 ++----
 drivers/pnp/isapnp/core.c   |   58 ++++++-------
 drivers/pnp/isapnp/proc.c   |    1 
 drivers/pnp/pnpbios/core.c  |   27 +++---
 drivers/pnp/resource.c      |  107 ++++++++++++++++--------
 drivers/serial/8250_pnp.c   |    7 +
 include/linux/isapnp.h      |  138 -------------------------------
 include/linux/pci.h         |   32 +++----
 include/linux/pnp.h         |   47 ++++++++--
 17 files changed, 253 insertions(+), 470 deletions(-)
-----

ChangeSet@1.970.3.2, 2002-12-30 13:49:02-08:00, greg@kroah.com
  Merge

 include/linux/pci.h |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)
------

ChangeSet@1.865.47.2, 2002-12-26 19:42:08+01:00, perex@suse.cz
  PnP update
    - removed ISAPnP members from PCI structures
    - isapnp.h cleanups (removal of duplicates)
    - added compatible functions (pnp_find_dev and pnp_find_card)
    - i82365 (pcmcia driver) - ported to new PnP layer

 drivers/pcmcia/i82365.c     |   26 +++-----
 drivers/pnp/isapnp/Makefile |    4 -
 drivers/pnp/isapnp/compat.c |   27 ++++----
 drivers/pnp/isapnp/core.c   |   54 ++++++++---------
 drivers/pnp/isapnp/proc.c   |    1 
 include/linux/isapnp.h      |  138 --------------------------------------------
 include/linux/pci.h         |   19 ------
 include/linux/pnp.h         |   12 ++-
 8 files changed, 66 insertions(+), 215 deletions(-)
------

ChangeSet@1.865.47.1, 2002-12-26 16:56:19+01:00, perex@suse.cz
  PnP update
    - added configuration templates - configuration can be changed from the probe() callback
    - new PnP ID - NSC6001
    - fixes in PnP BIOS code - no more oopses
    - fixed typos and thinkos in 8250_pnp.c

 Documentation/isapnp.txt   |  193 +--------------------------------------------
 drivers/pnp/card.c         |   14 ++-
 drivers/pnp/core.c         |    3 
 drivers/pnp/driver.c       |   16 ++-
 drivers/pnp/idlist.h       |    3 
 drivers/pnp/interface.c    |   20 ++++
 drivers/pnp/isapnp/core.c  |    4 
 drivers/pnp/pnpbios/core.c |   27 +++---
 drivers/pnp/resource.c     |  107 +++++++++++++++++-------
 drivers/serial/8250_pnp.c  |    7 +
 include/linux/pnp.h        |   35 ++++++--
 11 files changed, 176 insertions(+), 253 deletions(-)
------

