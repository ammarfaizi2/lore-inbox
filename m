Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbSKLTOx>; Tue, 12 Nov 2002 14:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266788AbSKLTOx>; Tue, 12 Nov 2002 14:14:53 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:6160 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266765AbSKLTOv>;
	Tue, 12 Nov 2002 14:14:51 -0500
Date: Tue, 12 Nov 2002 11:16:30 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: [BK PATCH] PNP driver changes for 2.5.47
Message-ID: <20021112191629.GA31530@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a set of updated PNP driver patches from Adam Belay.  These fix a
oops that the current kernel causes on a laptop of mine.

Please pull from:  bk://linuxusb.bkbits.net/pnp-2.5

thanks,

greg k-h


 drivers/input/gameport/ns558.c |  129 +++++++++++++++++------------------------
 drivers/net/e100/e100_main.c   |    4 -
 drivers/pnp/driver.c           |    5 -
 drivers/pnp/pnpbios/core.c     |   36 +++++++----
 drivers/serial/8250_pnp.c      |   12 +--
 include/linux/pnp.h            |   91 +++++++++++++++++++++++-----
 include/linux/pnpbios.h        |   13 ++++
 include/linux/sunrpc/stats.h   |   18 +++--
 sound/oss/opl3sa2.c            |    2 
 9 files changed, 186 insertions(+), 124 deletions(-)
-----

ChangeSet@1.853.1.7, 2002-11-11 17:59:12-08:00, ambx1@neo.rr.com
  [PATCH] PnP MODULE_DEVICE_TABLE Update - 2.5.46 (3/6)
  
  Here's a patch from Jaroslav Kysela.  It was sent in previously but doesn't
  appear to be included.  Here it is again only now against 2.5.46.

 drivers/net/e100/e100_main.c |    4 ++--
 include/linux/pnp.h          |    3 +++
 include/linux/sunrpc/stats.h |   18 ++++++++++--------
 sound/oss/opl3sa2.c          |    2 +-
 4 files changed, 16 insertions(+), 11 deletions(-)
------

ChangeSet@1.853.1.6, 2002-11-11 17:49:02-08:00, ambx1@neo.rr.com
  [PATCH] Update serial PnP driver - 2.5.46 (6/6)
  
  This patch updates the serial PnP driver to the changes.

 drivers/serial/8250_pnp.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)
------

ChangeSet@1.853.1.5, 2002-11-11 17:48:47-08:00, ambx1@neo.rr.com
  [PATCH] Convert Gameport Driver - 2.5.46 (5/6)
  
  This patch converts the gameport driver to the pnp changes.  It has been tested.

 drivers/input/gameport/ns558.c |  129 +++++++++++++++++------------------------
 1 files changed, 54 insertions(+), 75 deletions(-)
------

ChangeSet@1.853.1.4, 2002-11-11 17:48:30-08:00, ambx1@neo.rr.com
  [PATCH] Re: [PATCH] pnp.h changes - 2.5.46 (4/6)
  
  > Any reason for not just using dev_get_drvdata() and dev_set_drvdata() in
  > the drivers?  Or at the least, use them within these functions, that's
  > what they are there for :)
  
  
  Sure, here's a patch.  I think I'll use them within these functions.

 include/linux/pnp.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.853.1.3, 2002-11-11 17:48:15-08:00, ambx1@neo.rr.com
  [PATCH] pnp.h changes - 2.5.46 (4/6)
  
  This patch cleans up pnp.h.  It adds new resource macros.  Also it uses
  driver_data from the driver model instead of a local one.  Please everyone use
  the new macros instead of directly reading the structure.

 include/linux/pnp.h |   81 +++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 67 insertions(+), 14 deletions(-)
------

ChangeSet@1.853.1.2, 2002-11-11 17:47:57-08:00, ambx1@neo.rr.com
  [PATCH] Improved Debug Message Placement - 2.5.46 (2/6)
  
  Pointed out by Joe Perches.

 drivers/pnp/driver.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)
------

ChangeSet@1.853.1.1, 2002-11-11 17:47:38-08:00, ambx1@neo.rr.com
  [PATCH] PnP BIOS fixes - 2.5.46 (1/6)
  
  This Patch should at least partially fix the problems caused by broken PnP
  BIOSes.  More fixes will come later but this should boot.  Please report general
  protection faults.  The PnP BIOS proc interface may still not work if you have a
  broken PnP BIOS.  Also adds basic support for PnP BIOS flags and removes some
  currently unused stuff.

 drivers/pnp/pnpbios/core.c |   36 ++++++++++++++++++++++++------------
 include/linux/pnp.h        |    3 ++-
 include/linux/pnpbios.h    |   13 +++++++++++++
 3 files changed, 39 insertions(+), 13 deletions(-)
------

