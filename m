Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbTBUB3u>; Thu, 20 Feb 2003 20:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbTBUB3t>; Thu, 20 Feb 2003 20:29:49 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:35752 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S264790AbTBUB3r>;
	Thu, 20 Feb 2003 20:29:47 -0500
Date: Thu, 20 Feb 2003 20:39:08 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [BK PATCH] PnP Changes for 2.5.62
Message-ID: <20030220203908.GG25172@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@transmeta.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The PnP changes I submitted earlier are now in BK format.  They include
improvements in the resources management area and driver conversions such as the
popular OSS Sound Blaster Driver.  Also the PnPBIOS GPF issue has been resolved.

Please Pull from: bk://linux-pnp.bkbits.net/linus-2.5

Thanks,

Adam



 drivers/ide/Kconfig               |   13
 drivers/ide/Makefile              |    2
 drivers/ide/ide-pnp.c             |  112 ---
 drivers/ide/ide.c                 |    9
 drivers/media/radio/radio-cadet.c |   66 +-
 drivers/pnp/Makefile              |    3
 drivers/pnp/base.h                |   37 -
 drivers/pnp/card.c                |   14
 drivers/pnp/core.c                |   26
 drivers/pnp/driver.c              |    7
 drivers/pnp/interface.c           |  366 ++++++++---
 drivers/pnp/isapnp/core.c         |  204 +++---
 drivers/pnp/manager.c             |  831 ++++++++++++++++++++++++-
 drivers/pnp/names.c               |    4
 drivers/pnp/pnpbios/core.c        |  741 ++---------------------
 drivers/pnp/quirks.c              |    8
 drivers/pnp/resource.c            |  884 ++++++++++-----------------
 drivers/pnp/support.c             |  678 +++++++++++++++++++++
 drivers/pnp/system.c              |    3
 drivers/serial/8250_pnp.c         |    6
 include/linux/ide.h               |    1
 include/linux/ioport.h            |    1
 include/linux/pnp.h               |  392 ++++++------
 sound/oss/sb_card.c               | 1220 ++++++++------------------------------
 sound/oss/sb_card.h               |  147 ++++
 25 files changed, 3011 insertions(+), 2764 deletions(-)

through these ChangeSets:

ChangeSet@1.1004, 2003-02-19 17:56:54+00:00, ambx1@neo.rr.com
  OSS Sound Blaster Update from Paul Laufer

 sound/oss/sb_card.c | 1220 ++++++++++------------------------------------------
 sound/oss/sb_card.h |  147 ++++++
 2 files changed, 404 insertions(+), 963 deletions(-)


ChangeSet@1.1003, 2003-02-19 17:55:08+00:00, ambx1@neo.rr.com
  PnP Bug Fixes

 drivers/pnp/driver.c       |    3 -
 drivers/pnp/interface.c    |   59 +++++++++++++++-----
 drivers/pnp/isapnp/core.c  |    7 +-
 drivers/pnp/manager.c      |  131 ++++++++++++++++++++++++---------------------
 drivers/pnp/names.c        |    2
 drivers/pnp/pnpbios/core.c |    4 -
 drivers/pnp/resource.c     |    7 +-
 drivers/pnp/support.c      |   12 +++-
 drivers/pnp/system.c       |    1
 9 files changed, 137 insertions(+), 89 deletions(-)


ChangeSet@1.1002, 2003-02-19 17:51:31+00:00, ambx1@neo.rr.com
  Trivial C99 Update

  Patch from Art Haas.

 drivers/pnp/card.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


ChangeSet@1.1001, 2003-02-19 17:49:06+00:00, ambx1@neo.rr.com
  IDE PnP Update

  Updates the IDE PnP driver to the new PnP API.

 drivers/ide/Kconfig   |   13 ++---
 drivers/ide/Makefile  |    2
 drivers/ide/ide-pnp.c |  112 +++++++++++++-------------------------------------
 drivers/ide/ide.c     |    9 ++--
 include/linux/ide.h   |    1
 5 files changed, 43 insertions(+), 94 deletions(-)


ChangeSet@1.1000, 2003-02-19 17:41:20+00:00, ambx1@neo.rr.com
  Radio-Cadet PnP Update

  Converts the Radio-Cadet driver to the new PnP API.

 drivers/media/radio/radio-cadet.c |   66 +++++++++++++++++++-------------------
 1 files changed, 34 insertions(+), 32 deletions(-)


ChangeSet@1.999, 2003-02-19 17:39:04+00:00, ambx1@neo.rr.com
  Trivial Card Service Fix
  
  This was pointed out by Ruslan Zakirov.

 drivers/pnp/card.c |    1 -
 1 files changed, 1 deletion(-)


ChangeSet@1.998, 2003-02-19 17:35:42+00:00, ambx1@neo.rr.com
  PnPBIOS Updates
  
  Fixes a very tricky GPF bug that caused crashes on a few buggy systems,
  especially laptops.  For those interested, PnPBIOS now reserves 
  segement 0x40 before any call.  Also it updates the driver to use the
  new parsing functions.

 drivers/pnp/pnpbios/core.c |  737 +++++----------------------------------------
 1 files changed, 91 insertions(+), 646 deletions(-)


ChangeSet@1.997, 2003-02-19 17:28:59+00:00, ambx1@neo.rr.com
  ISAPnP Updates

  Adds support for reading currently set resources.  Also a few other updates.

 drivers/pnp/isapnp/core.c |  197 ++++++++++++++++++++++++++--------------------
 1 files changed, 113 insertions(+), 84 deletions(-)


ChangeSet@1.996, 2003-02-19 17:06:34+00:00, ambx1@neo.rr.com
  Interface Updates
  
  Includes the ability to report exactly where conflicts are occuring and 
  several set resource improvements.

 drivers/pnp/interface.c |  307 ++++++++++++++++++++++++++++++++++++------------
 1 files changed, 234 insertions(+), 73 deletions(-)


ChangeSet@1.995, 2003-02-19 17:00:08+00:00, ambx1@neo.rr.com
  Moves the resource parsing functions to a new location "support.c".  These
  resource parsing functions contain many improvements including the ability
  to set resources according to actual value rather than dependent functions.
  The interface changes will be able to take advantage of this.

 drivers/pnp/support.c |  666 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 666 insertions(+)


ChangeSet@1.994, 2003-02-19 16:56:09+00:00, ambx1@neo.rr.com
  This patch contains an improved resource management algorithm.  It is 
  capable of resolving nearly any conflict between two or more PnP devices.
  It also contains better error reporting and a manual override capability.

 drivers/pnp/manager.c |  700 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 700 insertions(+)


ChangeSet@1.993, 2003-02-19 16:50:40+00:00, ambx1@neo.rr.com
  Preparations and Cleanups
  
  Required for the remaining patches in this series.

 drivers/pnp/Makefile      |    3 
 drivers/pnp/base.h        |   37 +
 drivers/pnp/card.c        |    9 
 drivers/pnp/core.c        |   26 -
 drivers/pnp/driver.c      |    4 
 drivers/pnp/names.c       |    2 
 drivers/pnp/quirks.c      |    8 
 drivers/pnp/resource.c    |  877 +++++++++++++++++-----------------------------
 drivers/pnp/system.c      |    2
 drivers/serial/8250_pnp.c |    6
 include/linux/ioport.h    |    1 
 include/linux/pnp.h       |  392 ++++++++++----------
 12 files changed, 587 insertions(+), 780 deletions(-)

