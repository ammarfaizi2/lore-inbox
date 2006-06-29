Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932914AbWF2VsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbWF2VsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbWF2Vrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:47:39 -0400
Received: from mx.pathscale.com ([64.160.42.68]:38031 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932916AbWF2VoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:10 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 28 of 39] IB/ipath - Fixes a bug where our delay for EEPROM no
	longer works due to compiler reordering
X-Mercurial-Node: 5f3c0b2d446d78e3327fd7b8b0d45bfd8764e514
Message-Id: <5f3c0b2d446d78e3327f.1151617279@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:19 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mb() prevents the compiler from reordering on this function, with some versions
of gcc and -Os optimization.   The result is random failures in the EEPROM read
without this change.


Signed-off-by: Dave Olson <dave.olson@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 7d22a8963bda -r 5f3c0b2d446d drivers/infiniband/hw/ipath/ipath_eeprom.c
--- a/drivers/infiniband/hw/ipath/ipath_eeprom.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_eeprom.c	Thu Jun 29 14:33:26 2006 -0700
@@ -186,6 +186,7 @@ bail:
  */
 static void i2c_wait_for_writes(struct ipath_devdata *dd)
 {
+	mb();
 	(void)ipath_read_kreg32(dd, dd->ipath_kregs->kr_scratch);
 }
 
