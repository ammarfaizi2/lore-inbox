Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbTIVANF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 20:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbTIVANF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 20:13:05 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:12685 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262672AbTIVAMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 20:12:53 -0400
Date: Sun, 21 Sep 2003 20:05:46 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PnP Fixes for 2.6.0-test5
Message-ID: <20030921200546.GA24897@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This release has several small fixes for various pnp related areas.
Highlights include a compilation fix for the pnpbios driver and the removal
of the dma 0 restriction.

Please Pull from: bk://linux-pnp.bkbits.net/pnp-2.5

Thanks,
Adam

 drivers/pnp/card.c              |    8 +++
 drivers/pnp/isapnp/compat.c     |    1
 drivers/pnp/isapnp/core.c       |    2
 drivers/pnp/isapnp/proc.c       |    1
 drivers/pnp/pnpbios/bioscalls.c |   89 +---------------------------------------
 drivers/pnp/pnpbios/core.c      |   84 +++++++++++++++++++++++++++++++++----
 drivers/pnp/pnpbios/pnpbios.h   |   40 +++++++++++++++++
 drivers/pnp/pnpbios/proc.c      |   14 +++++-
 drivers/pnp/quirks.c            |   24 ----------
 drivers/pnp/resource.c          |   18 --------
 include/linux/pnpbios.h         |    8 ---
 11 files changed, 137 insertions(+), 152 deletions(-)

through these ChangeSets:

ChangeSet@1.1361, 2003-09-21 19:24:48+00:00, ambx1@neo.rr.com
  [PNPBIOS] move some more functions to local include file

  This patch moves some unnecessary global functions to the local
  pnpbios include file.


 drivers/pnp/pnpbios/pnpbios.h |    2 ++
 include/linux/pnpbios.h       |    3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)


ChangeSet@1.1360, 2003-09-21 19:20:41+00:00, ambx1@neo.rr.com
  [PNPBIOS] return proper error codes on init failure

 drivers/pnp/pnpbios/core.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)


ChangeSet@1.1359, 2003-09-21 19:10:33+00:00, ambx1@neo.rr.com
  [ISAPNP] remove unused isapnp_allow_dma0 modparam

  It looks like this option has been moved from isapnp to resource.c,
  but the MODULE_PARM line is still there:

  patch from: Gerald Teschl <gt@esi.ac.at>

 drivers/pnp/isapnp/core.c |    1 -
 1 files changed, 1 deletion(-)


ChangeSet@1.1358, 2003-09-21 19:05:42+00:00, ambx1@neo.rr.com
  [PATCH] janitor: remove unneeded includes (isapnp)

  From: Randy Hron <rwhron@earthlink.net>

 drivers/pnp/isapnp/compat.c |    1 -
 drivers/pnp/isapnp/core.c   |    1 -
 drivers/pnp/isapnp/proc.c   |    1 -
 3 files changed, 3 deletions(-)


ChangeSet@1.1357, 2003-09-21 19:02:08+00:00, ambx1@neo.rr.com
  [PNP] remove DMA 0 restrictions

  The original argument for blocking DMA 0 was to avoid conflicts with
  "memory refresh"  but such configurations are only found on very old
  8-bit systems that are likely not supported by the linux kernel.
  This patch allows dma 0 to be assigned to PnP devices by default.  If
  for whatever reason dma 0 cannot be used, one can avoid allocating it
  by setting the pnp_reserve_dma= kernel parameter.

 drivers/pnp/quirks.c   |   24 ------------------------
 drivers/pnp/resource.c |   18 ++----------------
 2 files changed, 2 insertions(+), 40 deletions(-)


ChangeSet@1.1356, 2003-09-21 18:39:11+00:00, ambx1@neo.rr.com
  [PNPBIOS] move detection code into core.c

  This patch moves the detection code to a more appropriate file.

 drivers/pnp/pnpbios/bioscalls.c |   89 +---------------------------------------
 drivers/pnp/pnpbios/core.c      |   65 ++++++++++++++++++++++++++++-
 drivers/pnp/pnpbios/pnpbios.h   |   28 +++++++++++-
 3 files changed, 92 insertions(+), 90 deletions(-)


ChangeSet@1.1355, 2003-09-21 18:25:50+00:00, ambx1@neo.rr.com
  [PNP] release card devices on probe failure

  When a driver's probe routine fails, it may not release all of the
  card devices it requested.  This patch allows the pnp layer to ensure
  that all devices claimed by the failing driver are released properly.

 drivers/pnp/card.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)


ChangeSet@1.1354, 2003-09-21 17:55:37+00:00, ambx1@neo.rr.com
  [PNPBIOS] compilation fix for pnpbios without proc support

  Here's an updated patch that will correct the compile error when PROC
  FS is disabled.  It also introduces better proc error recovery and
  moves the local proc functions to the local include file.  Thanks to
  Daniele Bellucci for finding the problem and contributing to this
  patch.


 drivers/pnp/pnpbios/core.c    |    9 +++++----
 drivers/pnp/pnpbios/pnpbios.h |   10 ++++++++++
 drivers/pnp/pnpbios/proc.c    |   14 ++++++++++++--
 include/linux/pnpbios.h       |    5 +----
 4 files changed, 28 insertions(+), 10 deletions(-)
