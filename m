Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbUBHWjQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 17:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbUBHWjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 17:39:16 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:34179 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S264257AbUBHWjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 17:39:10 -0500
Date: Sun, 8 Feb 2004 17:22:42 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PnP Updates for 2.6.3-rc1
Message-ID: <20040208172242.GB3158@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This update includes all of the pnp patches that are in the -mm tree.
They have been tested for some time now and appear to be stable.
Highlights include module device table support, an update to the
resource flag code, and various fixes.

Please Pull from: bk://linux-pnp.bkbits.net/pnp-2.6

Note: this tree has been renamed and was originally pnp-2.5

Thanks,
Adam

P.S.: The regular patches for these changes have already been posted
to lkml.

 drivers/pnp/Kconfig             |   28 +-------------------
 drivers/pnp/card.c              |   55 ++++++++++++++++++++++++++++++++++++++--
 drivers/pnp/isapnp/Kconfig      |   11 ++++++++
 drivers/pnp/isapnp/core.c       |    8 ++---
 drivers/pnp/manager.c           |   18 ++++++-------
 drivers/pnp/pnpbios/Kconfig     |   41 +++++++++++++++++++++++++++++
 drivers/pnp/pnpbios/Makefile    |    2 -
 drivers/pnp/pnpbios/core.c      |   34 +++++++++++++++++++++++-
 drivers/pnp/pnpbios/pnpbios.h   |    4 +-
 drivers/pnp/pnpbios/rsparser.c  |    8 ++---
 drivers/pnp/resource.c          |   19 ++++++++-----
 drivers/serial/8250_pnp.c       |    6 ++--
 include/linux/mod_devicetable.h |   17 ++++++++++++
 include/linux/pnp.h             |   32 +++++++++--------------
 scripts/file2alias.c            |   29 +++++++++++++++++++++
 15 files changed, 233 insertions(+), 79 deletions(-)

through these ChangeSets:

ChangeSet@1.1455, 2004-02-08 15:52:11+00:00, ambx1@neo.rr.com
  [PNP]: Cleanup Kconfig

  This patch cleans up the kconfig options for the pnp subsystem.  It
  updates the comments and makes pnpbios proc support an optional
  feature.

 drivers/pnp/Kconfig           |   28 ++--------------------------
 drivers/pnp/isapnp/Kconfig    |   11 +++++++++++
 drivers/pnp/pnpbios/Kconfig   |   41 +++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/pnpbios/Makefile  |    2 +-
 drivers/pnp/pnpbios/pnpbios.h |    4 ++--
 5 files changed, 57 insertions(+), 29 deletions(-)


ChangeSet@1.1454, 2004-02-08 15:47:23+00:00, ambx1@neo.rr.com
  [PNP]: Add additonal sysfs entries
  
  This patch adds some aditional information to sysfs for pnp cards.  It
  should be useful for userland tools.

 drivers/pnp/card.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+)


ChangeSet@1.1453, 2004-02-08 15:44:15+00:00, ambx1@neo.rr.com
  [PNP]: Card matching code fix
  
  This patch updates the matching code to ensure that all requested
  devices are present on the card, even if they are in use.  It is
  necessary for some ALSA drivers to work properly because early vendors
  would have different sets of devices on the same card ids.  It is from
  Takashi Iwai <tiwai@suse.de>.

 drivers/pnp/card.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)


ChangeSet@1.1452, 2004-02-08 15:40:52+00:00, ambx1@neo.rr.com
  [PNP]: file2alias support
  
  This patch updates file2alias.c to support pnp ids.  It is from
  Takashi Iwai <tiwai@suse.de>.

 scripts/file2alias.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+)


ChangeSet@1.1451, 2004-02-08 15:36:08+00:00, ambx1@neo.rr.com
  [PNP] Move ID declarations
  
  This patch moves the PnP ID declarations to mod_devicetable.h like
  most of the other buses.  It is from Takashi Iwai <tiwai@suse.de>.
  

 include/linux/mod_devicetable.h |   17 +++++++++++++++++
 include/linux/pnp.h             |   16 +---------------
 2 files changed, 18 insertions(+), 15 deletions(-)


ChangeSet@1.1450, 2004-02-08 15:33:34+00:00, ambx1@neo.rr.com
  [PNP]: Avoid static requests
  
  Recently many PnPBIOS bugs have been triggered by static resource
  information requests.  This patch makes an effort to further avoid
  making them.

 drivers/pnp/pnpbios/core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


ChangeSet@1.1449, 2004-02-08 15:31:19+00:00, ambx1@neo.rr.com
  [PNP]: Disable resources fix
  
  Some PnPBIOSes do not follow the specifications with regard to
  disabling devices.  This patch preserves the tag bits, while zeroing
  the resource settings.  Previously we would zero the entire buffer.
  It has been tested and appears to correct the issue while remaining
  compatible with unbroken PnPBIOSes.

 drivers/pnp/pnpbios/core.c |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletion(-)


ChangeSet@1.1448, 2004-02-08 15:28:23+00:00, ambx1@neo.rr.com
  [PNP]: Resource flags update
  
  This patch reorganizes resource flags to ensure that manual resource
  settings are properly recognized.  This fix is necessary for many ALSA
  drivers.  It also prevents comparisons between unset resource
  structures.  The bug was discovered by Rene Herman
  <rene.herman@keyaccess.nl>, who also wrote an initial version of this
  patch.  I made further improvements to ensure that the pnp subsystem 
  was compatible with this initial change.

 drivers/pnp/isapnp/core.c      |    8 ++++----
 drivers/pnp/manager.c          |   18 +++++++++---------
 drivers/pnp/pnpbios/rsparser.c |    8 ++++----
 drivers/pnp/resource.c         |   19 +++++++++++--------
 include/linux/pnp.h            |   16 ++++++++++++----
 5 files changed, 40 insertions(+), 29 deletions(-)


ChangeSet@1.1447, 2004-02-08 15:23:01+00:00, ambx1@neo.rr.com
  [PNP]: Fix Serial PnP driver
  
  The serial driver currently fails to unregister its pnp driver upon
  module unload.  This patch corrects the problem by calling
  pnp_unregister_driver and implementing a proper remove function.

 drivers/serial/8250_pnp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
