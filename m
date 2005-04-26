Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVDZJIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVDZJIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVDZJHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:07:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17363 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261410AbVDZJGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:06:45 -0400
Date: Tue, 26 Apr 2005 11:06:44 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: tiwai@suse.de
Subject: [PATCH] fix via82xx resume
Message-ID: <20050426090643.GA2608@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trying software suspend on my workstation makes it crash on resume. The
problem is that via82xx marks the chip_init function as _devinit, but
calls it on resume as well.

Signed-off-by: Jens Axboe <axboe@suse.de>

Index: sound/pci/via82xx.c
===================================================================
--- 9771aaff44479c8ccac70fd18d1e7394fd9de264/sound/pci/via82xx.c  (mode:100644 sha1:f1ce808501da54e60039fd5a9ab99af30d77a0c5)
+++ uncommitted/sound/pci/via82xx.c  (mode:100644)
@@ -1836,7 +1836,7 @@
  *
  */
 
-static int __devinit snd_via82xx_chip_init(via82xx_t *chip)
+static int snd_via82xx_chip_init(via82xx_t *chip)
 {
 	unsigned int val;
 	int max_count;

-- 
Jens Axboe

