Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbSLFQiL>; Fri, 6 Dec 2002 11:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbSLFQiL>; Fri, 6 Dec 2002 11:38:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:1043 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263366AbSLFQiK>;
	Fri, 6 Dec 2002 11:38:10 -0500
Date: Fri, 6 Dec 2002 08:45:23 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: [BK PATCH] PNP driver changes for 2.5.50
Message-ID: <20021206164522.GA10376@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a set of updated PNP driver patches from Adam Belay.

Please pull from:  bk://linuxusb.bkbits.net/pnp-2.5

thanks,

greg k-h

 drivers/input/gameport/ns558.c |  132 ++++++---------
 drivers/net/e100/e100_main.c   |    4 
 drivers/parport/parport_pc.c   |    3 
 drivers/pnp/Kconfig            |   15 +
 drivers/pnp/Makefile           |    6 
 drivers/pnp/base.h             |    3 
 drivers/pnp/card.c             |  342 +++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/core.c             |   87 +++++-----
 drivers/pnp/driver.c           |   86 +++-------
 drivers/pnp/interface.c        |    8 
 drivers/pnp/isapnp/Makefile    |    4 
 drivers/pnp/isapnp/core.c      |   39 +---
 drivers/pnp/isapnp/proc.c      |    2 
 drivers/pnp/names.c            |    2 
 drivers/pnp/pnpbios/core.c     |   49 +++--
 drivers/pnp/quirks.c           |    2 
 drivers/pnp/system.c           |   10 -
 drivers/serial/8250_pnp.c      |   22 --
 include/linux/pnp.h            |  230 ++++++++++++++++++++++-----
 include/linux/pnpbios.h        |   13 +
 include/linux/sunrpc/stats.h   |   18 +-
 sound/isa/opl3sa2.c            |  131 ++++++---------
 sound/oss/opl3sa2.c            |    6 
 23 files changed, 818 insertions(+), 396 deletions(-)
-----

ChangeSet@1.837.4.3, 2002-12-06 10:08:34-06:00, ambx1@neo.rr.com
  [PATCH] PnP gameport driver update
  
  This trivial patch updates the gameport driver to the new id scheme.

 drivers/input/gameport/ns558.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.837.4.2, 2002-12-05 23:31:41-06:00, ambx1@neo.rr.com
  [PATCH] PnP bugfix
  
  I forgot the errno.h.  Without this patch, things may not compile when
  pnp support or pnp card support is disabled.
  
  Hope you had a good trip.  I noticed a small mistake in pnp 0.93 and I have
  a fix for it.

 include/linux/pnp.h |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.837.4.1, 2002-12-05 23:31:21-06:00, ambx1@neo.rr.com
  [PATCH] Linux PnP Support V0.93 - 2.5.50
  
  Attached is a patch, that updates the 2.5.50 to the latest pnp
  version.  It includes all 9 of the previously submitted patches.
  
  Highlights are as follows:
  -PnP BIOS fixes
  -Several new macros
  -PnP Card Services
  -Various bug fixes
  -more drivers converted to the new APIs

 drivers/input/gameport/ns558.c |  128 ++++++---------
 drivers/net/e100/e100_main.c   |    4 
 drivers/parport/parport_pc.c   |    3 
 drivers/pnp/Kconfig            |   15 +
 drivers/pnp/Makefile           |    6 
 drivers/pnp/base.h             |    3 
 drivers/pnp/card.c             |  342 +++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/core.c             |   87 +++++-----
 drivers/pnp/driver.c           |   86 +++-------
 drivers/pnp/interface.c        |    8 
 drivers/pnp/isapnp/Makefile    |    4 
 drivers/pnp/isapnp/core.c      |   39 +---
 drivers/pnp/isapnp/proc.c      |    2 
 drivers/pnp/names.c            |    2 
 drivers/pnp/pnpbios/core.c     |   49 +++--
 drivers/pnp/quirks.c           |    2 
 drivers/pnp/system.c           |   10 -
 drivers/serial/8250_pnp.c      |   22 --
 include/linux/pnp.h            |  229 ++++++++++++++++++++++-----
 include/linux/pnpbios.h        |   13 +
 include/linux/sunrpc/stats.h   |   18 +-
 sound/isa/opl3sa2.c            |  131 ++++++---------
 sound/oss/opl3sa2.c            |    6 
 23 files changed, 815 insertions(+), 394 deletions(-)
------

