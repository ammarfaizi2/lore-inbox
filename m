Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbTDDEv2 (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 23:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTDDEv2 (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 23:51:28 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:16517 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261374AbTDDEu5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 23:50:57 -0500
Date: Fri, 4 Apr 2003 00:06:03 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PnP Changes for 2.5.66
Message-ID: <20030404000603.GA11574@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This set of changes includes driver conversions, pnpbios updates, and a few bug fixes.

Please Pull from: bk://linux-pnp.bkbits.net/pnp-2.5
(Note: this is different from the previous address)

Thanks,
Adam

 drivers/isdn/hisax/hisax_fcpcipnp.c |    4
 drivers/pnp/card.c                  |   74 ++++---
 drivers/pnp/core.c                  |    2
 drivers/pnp/manager.c               |    6
 drivers/pnp/pnpbios/core.c          |  137 +++++++++---
 drivers/pnp/pnpbios/proc.c          |   65 ++----
 include/linux/pnp.h                 |    7 
 include/linux/pnpbios.h             |   11 -
 sound/isa/als100.c                  |   11 -
 sound/isa/azt2320.c                 |  230 +++++++++------------
 sound/isa/dt019x.c                  |  251 +++++++++--------------
 sound/isa/sb/es968.c                |   10 
 sound/isa/sb/sb16.c                 |  380 +++++++++++++++++-------------------
 sound/oss/sb_card.c                 |    2 
 sound/oss/sb_card.h                 |    2 
 15 files changed, 600 insertions(+), 592 deletions(-)

through these ChangeSets:

ChangeSet@1.1023, 2003-04-03 23:31:47+00:00, ambx1@neo.rr.com
  [PATCH 2.5] ES968: kmalloc params fix
  
  Date: Mon, 31 Mar 2003 14:39:54 -0300 (ART)
  From: Pablo Menichini <pablo@menichini.com.ar>
  
  This patch swaps the arguments of kmalloc, and relax the type
  of allocation to GFP_KERNEL as others PnP functions do.
  
  Pablo

 sound/isa/sb/es968.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


ChangeSet@1.1022, 2003-04-03 23:27:53+00:00, ambx1@neo.rr.com
  [PATCH 2.5] ALS100: kmalloc params fix
  
  Date: Mon, 31 Mar 2003 14:39:54 -0300 (ART)
  From: Pablo Menichini <pablo@menichini.com.ar>
  
  This patch swaps the arguments of kmalloc, and relax the type
  of allocation to GFP_KERNEL as others PnP functions do.
  
  Pablo
  

 sound/isa/als100.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


ChangeSet@1.1021, 2003-04-03 23:22:22+00:00, ambx1@neo.rr.com
  ALSA DT019X PnP Updates
  
  Converts this driver to the pnp api.

 sound/isa/dt019x.c |  251 ++++++++++++++++++++++-------------------------------
 1 files changed, 105 insertions(+), 146 deletions(-)


ChangeSet@1.1020, 2003-04-03 23:21:01+00:00, ambx1@neo.rr.com
  AZT2320 PnP Updates
  
  Converts this driver to the pnp api.

 sound/isa/azt2320.c |  230 ++++++++++++++++++++++------------------------------
 1 files changed, 101 insertions(+), 129 deletions(-)


ChangeSet@1.977.1.26, 2003-03-25 21:37:30+00:00, ambx1@neo.rr.com
  Increment Version Number

 drivers/pnp/core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


ChangeSet@1.977.1.25, 2003-03-25 21:34:45+00:00, ambx1@neo.rr.com
  Silently Ignore if the device is already active/disabled
  
  Some drivers will try to activate a device even though it is already
  active.  Instead of returning an error, the resource manager will now
  just ignore this.  This should solve some of the recently seen problems.
  Also it doesn't make sense to return an error if the device is already
  in the correct state.

 drivers/pnp/manager.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


ChangeSet@1.977.1.24, 2003-03-25 21:21:48+00:00, ambx1@neo.rr.com
  ALSA SB16 PnP Update
  
  Updates the driver to the new pnp apis.  Although it has only been tested
  for compiliation, it is an improvement over the existing broken code. 
  These changes are based on a update by Shaheed Haque <srhaque@iee.org>.

 sound/isa/sb/sb16.c |  380 +++++++++++++++++++++++++---------------------------
 1 files changed, 188 insertions(+), 192 deletions(-)


ChangeSet@1.977.12.8, 2003-03-25 17:31:57+00:00, ambx1@neo.rr.com
  [PATCH 2.5] PnP changes to allow MODULE_DEVICE_TABLE()
  
  This patch fixes the MODULE_DEVICE_TABLE problems, the correct code was
  accidentally lost a few merges back.  It is from Daniel Ritz
  <daniel.ritz@gmx.ch>, below is the original message.
  
  hello adam, jaroslav, list
  
  this patch does:
  - rename struct pnp_card_id to pnp_card_device_id
  - fix all references to it
  
  this is needed for the MODULE_DEVICE_TABLE() macro to work with pnp_card's.
  jaroslav did this a while ago (changeset 1.879.79.1), but adam undid it a bit
  later (changeset 1.889.202.3). but why?
  
  w/o the patch gcc dies when compiling als100.c with the message 'storage size
  of __mod_pnp_card_device_table unknown' (this is from the macro).
  
  any reasons why i should not send this to linus?
  against 2.5.65-bk
  
  rgds
  -daniel

 drivers/isdn/hisax/hisax_fcpcipnp.c |    4 ++--
 drivers/pnp/card.c                  |    6 +++---
 include/linux/pnp.h                 |    6 +++---
 sound/isa/als100.c                  |    8 ++++----
 sound/isa/sb/es968.c                |    8 ++++----
 sound/oss/sb_card.c                 |    2 +-
 sound/oss/sb_card.h                 |    2 +-
 7 files changed, 18 insertions(+), 18 deletions(-)


ChangeSet@1.977.12.7, 2003-03-24 22:36:22+00:00, ambx1@neo.rr.com
  ALS100 Memory Leak Fix
  
  This trivial patch adds a missing kfree, the leak occurs when 
  pnp_activate_dev fails.

 sound/isa/als100.c |    1 +
 1 files changed, 1 insertion(+)


ChangeSet@1.977.12.6, 2003-03-24 22:30:41+00:00, ambx1@neo.rr.com
  PnPBIOS Update
  
  - Prevents calling the node_info call more than necessary in order to take
  load off the pnpbios
  - intregrates the proc registration code with the device scanning code
  - adds human readable error messages instead of number codes
  - other small cleanups

 drivers/pnp/pnpbios/core.c |  137 +++++++++++++++++++++++++++++++++------------
 drivers/pnp/pnpbios/proc.c |   65 ++++++++-------------
 include/linux/pnpbios.h    |   11 +++
 3 files changed, 137 insertions(+), 76 deletions(-)


ChangeSet@1.977.12.5, 2003-03-24 22:24:04+00:00, ambx1@neo.rr.com
  PnP Card Service Cleanups
  
  Moves probing code to a central location and matches when new cards are 
  added instead of only when new drivers are added.

 drivers/pnp/card.c  |   68 +++++++++++++++++++++++++++++++++-------------------
 include/linux/pnp.h |    1 
 2 files changed, 45 insertions(+), 24 deletions(-)


