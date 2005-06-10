Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVFJNzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVFJNzQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 09:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVFJNzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 09:55:16 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:46754 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262525AbVFJNya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 09:54:30 -0400
Date: Fri, 10 Jun 2005 14:54:29 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] drm fixes needed before 2.6.12 gets released..
In-Reply-To: <Pine.LNX.4.58.0506101443410.11775@skynet>
Message-ID: <Pine.LNX.4.58.0506101453400.11775@skynet>
References: <Pine.LNX.4.58.0506101443410.11775@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> I've created a tree with two patches, one is a new PCI ID for i945G
> chipset, the other fixes a bug in the IRQ handler for Radeon (a more
> complete fix is worked out but this is the most I'm willing to commit
> without more testing...
>
> Please pull from:
>
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git
>
> I'll reply to this mail with the patch for completeness.
>

diff --git a/drivers/char/drm/drm_pciids.h b/drivers/char/drm/drm_pciids.h
--- a/drivers/char/drm/drm_pciids.h
+++ b/drivers/char/drm/drm_pciids.h
@@ -220,5 +220,6 @@
 	{0x8086, 0x2572, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x8086, 0x2582, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x8086, 0x2592, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
+	{0x8086, 0x2772, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0, 0, 0}

diff --git a/drivers/char/drm/radeon_irq.c b/drivers/char/drm/radeon_irq.c
--- a/drivers/char/drm/radeon_irq.c
+++ b/drivers/char/drm/radeon_irq.c
@@ -123,11 +123,6 @@ static int radeon_wait_irq(drm_device_t

 	dev_priv->stats.boxes |= RADEON_BOX_WAIT_IDLE;

-	/* This is a hack to work around mysterious freezes on certain
-	 * systems:
-	 */
-	radeon_acknowledge_irqs( dev_priv );
-
 	DRM_WAIT_ON( ret, dev_priv->swi_queue, 3 * DRM_HZ,
 		     RADEON_READ( RADEON_LAST_SWI_REG ) >= swi_nr );

