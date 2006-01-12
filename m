Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWALHQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWALHQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 02:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWALHQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 02:16:47 -0500
Received: from c-24-21-35-152.hsd1.or.comcast.net ([24.21.35.152]:60574 "EHLO
	Gecko.tarbal.com") by vger.kernel.org with ESMTP id S1030271AbWALHQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 02:16:46 -0500
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
CC: John Ronciak <john.ronciak@intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH ] ethtool: Remove duplex info from CTRL register dump
Date: Wed, 11 Jan 2006 23:16:42 -0800
Message-Id: <20060112071642.29428.23880.stgit@Gecko.tarbal.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The duplex control register is used for setting the driver and is not
necessary for debug purposes.  The value of the duplex control register is
what the register's current value is and may not reflect the correct status
of te current connection.  That is what the duplex status register is used
for.  To keep from confusing the user, we are removing the duplex register
from the ethtool dump of the registers.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: John Ronciak <john.ronciak@intel.com>
---

 e1000.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/e1000.c b/e1000.c
index 77d799f..6de27ca 100644
--- a/e1000.c
+++ b/e1000.c
@@ -282,7 +282,6 @@ e1000_dump_regs(struct ethtool_drvinfo *
 	reg = regs_buff[0];
 	fprintf(stdout,
 		"0x00000: CTRL (Device control register)  0x%08X\n"
-		"      Duplex:                            %s\n"
 		"      Endian mode (buffers):             %s\n"
 		"      Link reset:                        %s\n"
 		"      Set link up:                       %s\n"
@@ -291,7 +290,6 @@ e1000_dump_regs(struct ethtool_drvinfo *
 		"      Transmit flow control:             %s\n"
 		"      VLAN mode:                         %s\n",
 		reg,
-		reg & E1000_CTRL_FD     ? "full"     : "half",
 		reg & E1000_CTRL_BEM    ? "big"      : "little",
 		reg & E1000_CTRL_LRST   ? "reset"    : "normal",
 		reg & E1000_CTRL_SLU    ? "1"        : "0",

