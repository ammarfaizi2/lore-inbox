Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbTEHL3R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTEHL3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:29:17 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:45327 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261320AbTEHL3Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:29:16 -0400
Date: Thu, 8 May 2003 13:32:35 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: linux-kernel@vger.kernel.org
Cc: chas williams <chas@locutus.cmf.nrl.navy.mil>, davem@redhat.com
Subject: [PATCH] drivers/atm/iphase.c - ioremap() cookie dereferencing
Message-ID: <20030508133235.B26472@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sneak variant of "ioremap() return dereferencing".


 drivers/atm/iphase.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/atm/iphase.c~drivers-atm-iphase-yuck-yuck-yuck drivers/atm/iphase.c
--- linux-2.5.69-1.1042.92.10-to-1.1097/drivers/atm/iphase.c~drivers-atm-iphase-yuck-yuck-yuck	Thu May  8 13:12:02 2003
+++ linux-2.5.69-1.1042.92.10-to-1.1097-fr/drivers/atm/iphase.c	Thu May  8 13:14:53 2003
@@ -2809,10 +2809,10 @@ static int ia_ioctl(struct atm_dev *dev,
 	     rfL = &regs_local->rfredn;
              /* Copy real rfred registers into the local copy */
  	     for (i=0; i<(sizeof (rfredn_t))/4; i++)
-                ((u_int *)rfL)[i] = ((u_int *)iadev->reass_reg)[i] & 0xffff;
+                ((u_int *)rfL)[i] = readl(iadev->reass_reg + i) & 0xffff;
              	/* Copy real ffred registers into the local copy */
 	     for (i=0; i<(sizeof (ffredn_t))/4; i++)
-                ((u_int *)ffL)[i] = ((u_int *)iadev->seg_reg)[i] & 0xffff;
+                ((u_int *)ffL)[i] = readl(iadev->seg_reg + i) & 0xffff;
 
              if (copy_to_user(ia_cmds.buf, regs_local,sizeof(ia_regs_t))) {
                 kfree(regs_local);

_
