Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273184AbTHFCoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273389AbTHFCoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:44:11 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:16769 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S273184AbTHFCoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:44:03 -0400
Date: Tue, 5 Aug 2003 22:12:17 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PnP Updates for 2.6.0-test2
Message-ID: <20030805221217.GA13275@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The pnp_id variables have been corrected for the _devinitdata problem.  Only
the sound drivers were affected.  Also many pnpbios cleanups are included.
Finally the name database has been removed to make way for the upcoming driver
model changes.

Please Pull from:
bk://linux-pnp.bkbits.net/pnp-2.5

Thanks,
Adam

 drivers/pnp/idlist.h            |  322 ----------------
 drivers/pnp/names.c             |   50 --
 drivers/pnp/Kconfig             |   10 
 drivers/pnp/Makefile            |    2 
 drivers/pnp/base.h              |    1 
 drivers/pnp/core.c              |    3 
 drivers/pnp/manager.c           |   28 -
 drivers/pnp/pnpbios/Makefile    |    4 
 drivers/pnp/pnpbios/bioscalls.c |  627 ++++++++++++++++++++++++++++++++
 drivers/pnp/pnpbios/core.c      |  699 ------------------------------------
 drivers/pnp/pnpbios/pnpbios.h   |   11 
 drivers/pnp/pnpbios/rsparser.c  |  775 ++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/resource.c          |    8 
 drivers/pnp/support.c           |  657 ---------------------------------
 include/linux/pnp.h             |   28 -
 include/linux/pnpbios.h         |    1 
 sound/isa/ad1816a/ad1816a.c     |    2 
 sound/isa/als100.c              |    2 
 sound/isa/azt2320.c             |    2 
 sound/isa/cmi8330.c             |    2 
 sound/isa/cs423x/cs4236.c       |    4
 sound/isa/dt019x.c              |    2
 sound/isa/es18xx.c              |    2 
 sound/isa/gus/interwave.c       |    2 
 sound/isa/opl3sa2.c             |    2 
 sound/isa/sb/es968.c            |    2
 sound/isa/sb/sb16.c             |    2 
 sound/isa/sscape.c              |    2 
 sound/isa/wavefront/wavefront.c |    2
 29 files changed, 1465 insertions(+), 1789 deletions(-)

through these ChangeSets:

ChangeSet@1.1113, 2003-08-05 21:22:55+00:00, ambx1@neo.rr.com
  [PNP] Increment Version Number

 drivers/pnp/core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


ChangeSet@1.1112, 2003-08-05 21:21:39+00:00, ambx1@neo.rr.com
  [PNP] Remove device naming based on id
  
  This patch removes the pnp name database code.  Most buses, including
  pnp, will be using userspace to name devices in the near future.  Also
  dev->name will be removed from the driver model soon.

 drivers/pnp/idlist.h |  322 ---------------------------------------------------
 drivers/pnp/names.c  |   50 -------
 drivers/pnp/Kconfig  |   10 -
 drivers/pnp/Makefile |    2 
 drivers/pnp/base.h   |    1 
 drivers/pnp/core.c   |    1 
 6 files changed, 1 insertion(+), 385 deletions(-)


ChangeSet@1.1111, 2003-08-05 20:34:05+00:00, ambx1@neo.rr.com
  [PNPBIOS] Move low level code into a separate file
  
  This patch moves the low level bios calls to a separate file,
  "bioscalls.c".  It is a cleanup that will improve organization of the
  pnpbios driver code.

 drivers/pnp/pnpbios/Makefile    |    2 
 drivers/pnp/pnpbios/bioscalls.c |  627 ++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/pnpbios/core.c      |  610 --------------------------------------
 drivers/pnp/pnpbios/pnpbios.h   |    3 
 include/linux/pnpbios.h         |    1 
 5 files changed, 639 insertions(+), 604 deletions(-)


ChangeSet@1.1110, 2003-08-05 20:18:25+00:00, ambx1@neo.rr.com
  [SOUND] Remove __(dev)initdata from all pnp sound drivers
  
  This patch is needed in order to avoid a potential oops.  It is
  similiar to the changes made to pci.
  

 sound/isa/ad1816a/ad1816a.c     |    2 +-
 sound/isa/als100.c              |    2 +-
 sound/isa/azt2320.c             |    2 +-
 sound/isa/cmi8330.c             |    2 +-
 sound/isa/cs423x/cs4236.c       |    4 ++--
 sound/isa/dt019x.c              |    2 +-
 sound/isa/es18xx.c              |    2 +-
 sound/isa/gus/interwave.c       |    2 +-
 sound/isa/opl3sa2.c             |    2 +-
 sound/isa/sb/es968.c            |    2 +-
 sound/isa/sb/sb16.c             |    2 +-
 sound/isa/sscape.c              |    2 +-
 sound/isa/wavefront/wavefront.c |    2 +-
 13 files changed, 14 insertions(+), 14 deletions(-)


ChangeSet@1.1109, 2003-08-05 20:15:00+00:00, ambx1@neo.rr.com
  [PNPBIOS] Move Parsing Functions to the PnPBIOS driver

  This patch moves the resource parsing functions from support.c to the
  pnpbios driver.  Originally these functions were intended for other
  pnp protocols but in reality they are only used by the PnPBIOS driver.
  This patch greatly cleans up the code in both the parsing functions
  and their connection with the pnpbios driver.  Also note that
  pnpbios.h has been added for local pnpbios functions.

 drivers/pnp/pnpbios/Makefile   |    2 
 drivers/pnp/pnpbios/core.c     |   89 ----
 drivers/pnp/pnpbios/pnpbios.h  |    8 
 drivers/pnp/pnpbios/rsparser.c |  775 +++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/support.c          |  657 ----------------------------------
 include/linux/pnp.h            |    6 
 6 files changed, 790 insertions(+), 747 deletions(-)


ChangeSet@1.1108, 2003-08-05 14:36:01+00:00, ambx1@neo.rr.com
  [PNP] Remove protocol_data from pnp_dev and pnp_card
  
  This is not needed.


 include/linux/pnp.h |   22 ----------------------
 1 files changed, 22 deletions(-)


ChangeSet@1.1107, 2003-08-05 14:29:11+00:00, ambx1@neo.rr.com
    [PNP] Handle unset resources properly
  
    This patch is similar to the disabled resource patch in that it
    avoids direct numeric comparisons with data in unset resource
    structures.

 drivers/pnp/manager.c  |   28 ++++++++++++++++------------
 drivers/pnp/resource.c |    8 ++++----
 2 files changed, 20 insertions(+), 16 deletions(-)
