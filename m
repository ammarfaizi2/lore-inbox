Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265468AbTGCWt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265474AbTGCWt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:49:56 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:16012 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265468AbTGCWtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:49:55 -0400
Date: Thu, 3 Jul 2003 18:38:27 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PnP Fixes for 2.5.74
Message-ID: <20030703183827.GA31086@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some pnp related fixes.  The main focus of this release
is to fix disabled resource handling.  Also included is an
important bug fix for manual resource setting (used by ALSA
drivers).

Please Pull from: bk://linux-pnp.bkbits.net/pnp-2.5

Thanks,
Adam

 drivers/pnp/interface.c |   22 ++++++++++++++---
 drivers/pnp/manager.c   |   61 ++++++++++++++++++++++++++++++++----------------
 drivers/pnp/resource.c  |    8 ++++++
 drivers/pnp/support.c   |   24 +++++++++++++++---
 include/linux/ioport.h  |    1
 5 files changed, 88 insertions(+), 28 deletions(-)

through these ChangeSets:

ChangeSet@1.1387, 2003-07-03 15:45:44+00:00, ambx1@neo.rr.com
  [PNP] Fix manual resource setting API

  This patch corrects a trivial thinko in the manual resource api.

 drivers/pnp/manager.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)


ChangeSet@1.1386, 2003-07-03 15:42:36+00:00, ambx1@neo.rr.com
  [PNP] Allow resource auto config to assign disabled resources

  This patch updates the resource manager so that it actually assigns
  disabled resources when they are requested by the device.

 drivers/pnp/manager.c |   40 +++++++++++++++++++++++++---------------
 1 files changed, 25 insertions(+), 15 deletions(-)


ChangeSet@1.1385, 2003-07-03 15:39:09+00:00, ambx1@neo.rr.com
  [PNP] Handle Disabled Resources Properly

  Some devices will allow for individual resources to be disabled,
  even when the device as a whole is active.  The current PnP
  resource manager is not handling this situation properly.  This
  patch corrects the issue by detecting disabled resources and then
  flagging them. The pnp layer will now skip over any disabled
  resources.  Interface updates have also been included so that we
  can properly display resource tables when a resource is disabled.

  Also note that a new flag "IORESOURCE_DISABLED" has been added to
  linux/ioports.h.


 drivers/pnp/interface.c |   22 ++++++++++++++++++----
 drivers/pnp/manager.c   |   12 ++++++++++++
 drivers/pnp/resource.c  |    8 ++++++++
 drivers/pnp/support.c   |   24 ++++++++++++++++++++----
 include/linux/ioport.h  |    1 +
 5 files changed, 59 insertions(+), 8 deletions(-)
