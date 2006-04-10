Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWDJKNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWDJKNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWDJKNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:13:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:45016 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751118AbWDJKNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 06:13:24 -0400
X-Authenticated: #704063
Subject: [Patch] Overrun in sound/pci/au88x0/au88x0_pcm.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 10 Apr 2006 12:13:21 +0200
Message-Id: <1144664001.15821.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

since idx is used as an index for vortex_pcm_prettyname[VORTEX_PCM_LAST],
it should not be equal to VORTEX_PCM_LAST. This fixes coverity bug id #572

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc1/sound/pci/au88x0/au88x0_pcm.c.orig	2006-04-10 12:10:22.000000000 +0200
+++ linux-2.6.17-rc1/sound/pci/au88x0/au88x0_pcm.c	2006-04-10 12:10:41.000000000 +0200
@@ -506,7 +506,7 @@ static int __devinit snd_vortex_new_pcm(
 	int i;
 	int err, nr_capt;
 
-	if ((chip == 0) || (idx < 0) || (idx > VORTEX_PCM_LAST))
+	if ((chip == 0) || (idx < 0) || (idx >= VORTEX_PCM_LAST))
 		return -ENODEV;
 
 	/* idx indicates which kind of PCM device. ADB, SPDIF, I2S and A3D share the 


