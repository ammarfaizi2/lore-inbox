Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262716AbTCJEue>; Sun, 9 Mar 2003 23:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262717AbTCJEud>; Sun, 9 Mar 2003 23:50:33 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:5762 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S262716AbTCJEub>;
	Sun, 9 Mar 2003 23:50:31 -0500
Date: Mon, 10 Mar 2003 00:05:14 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PnP Changes for 2.5.64
Message-ID: <20030310000514.GC574@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This set of changes prepares the pnp layer to support ALSA. it also converts the
ALSA ALS100 driver as a sample.  More driver conversions are comming soon.

Please Pull from: bk://linux-pnp.bkbits.net/linux-pnp

 drivers/pnp/Kconfig       |   11 -
 drivers/pnp/Makefile      |    4 
 drivers/pnp/card.c        |  383 ++++++++++++++++++----------------------------
 drivers/pnp/driver.c      |   25 +--
 drivers/pnp/interface.c   |   11 +
 drivers/pnp/isapnp/core.c |   10 -
 drivers/pnp/manager.c     |   37 ++++
 drivers/pnp/resource.c    |    8 
 drivers/pnp/system.c      |    4 
 include/linux/pnp.h       |  120 ++++++--------
 sound/isa/als100.c        |  283 ++++++++++++++-------------------
 sound/oss/sb_card.c       |   32 +--
 sound/oss/sb_card.h       |    2 
 13 files changed, 420 insertions(+), 510 deletions(-)

through these ChangeSets:


ChangeSet@1.1084, 2003-03-09 23:44:44+00:00, ambx1@neo.rr.com
  Aditional Card Service Changes
  
  Fixes many issues that were discovered after testing.  Also cleans up the
  card service code and fixes the card_drvdata bug in which only one driver
  at a time could have driver data.

 drivers/pnp/card.c   |   88 ++++++++++++++++++++++++++++++++++-----------------
 drivers/pnp/driver.c |    3 +
 drivers/pnp/system.c |    2 -
 include/linux/pnp.h  |   32 +++++++++++-------
 sound/isa/als100.c   |   16 ++++-----
 sound/oss/sb_card.c  |   22 ++++++------
 sound/oss/sb_card.h  |    2 -
 7 files changed, 100 insertions(+), 65 deletions(-)


ChangeSet@1.1083, 2003-03-09 23:41:56+00:00, ambx1@neo.rr.com
  OSS SB driver Updates
  
  Compatibility update for the latest changes.

 sound/oss/sb_card.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


ChangeSet@1.1082, 2003-03-09 23:39:45+00:00, ambx1@neo.rr.com
  ALS100 Updates
  
  Updates the als100 driver to use the pnp apis.  Includes resource config
  templates.

 sound/isa/als100.c |  267 +++++++++++++++++++++--------------------------------
 1 files changed, 110 insertions(+), 157 deletions(-)


ChangeSet@1.1081, 2003-03-09 23:38:08+00:00, ambx1@neo.rr.com
  PnP Card Serivice Revisions
  
  This set of changes addresses the following issues with the existing card 
  service implementation:
  
  1.) Only one driver can be bound to a card.
  2.) repetive code is required for pnp_request_card_device and other 
  functions
  
  This patch will make the card services usable by ALSA.

 drivers/pnp/Kconfig       |   11 -
 drivers/pnp/Makefile      |    4 
 drivers/pnp/card.c        |  295 +++++++++++++++-------------------------------
 drivers/pnp/driver.c      |   22 +--
 drivers/pnp/isapnp/core.c |   10 -
 drivers/pnp/system.c      |    2 
 include/linux/pnp.h       |   88 +++++--------
 7 files changed, 157 insertions(+), 275 deletions(-)


ChangeSet@1.1079, 2003-03-09 23:18:13+00:00, ambx1@neo.rr.com
  Interface Changes
  
  A few minor revisions.  Simpifies a few commands and adds config mode 
  information.

 drivers/pnp/interface.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)


ChangeSet@1.1078, 2003-03-06 21:50:43+00:00, ambx1@neo.rr.com
  Manual Resource Setting Update
  
  This patch allows for partial setting of manual resources as needed by ALSA.
  It does not change any existing APIs.

 drivers/pnp/manager.c  |   37 +++++++++++++++++++++++++++++++++++--
 drivers/pnp/resource.c |    8 ++++----
 2 files changed, 39 insertions(+), 6 deletions(-)
