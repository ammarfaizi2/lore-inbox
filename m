Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSFBUSN>; Sun, 2 Jun 2002 16:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSFBUSM>; Sun, 2 Jun 2002 16:18:12 -0400
Received: from 12-252-146-102.client.attbi.com ([12.252.146.102]:7443 "EHLO
	archimedes") by vger.kernel.org with ESMTP id <S313558AbSFBUSM>;
	Sun, 2 Jun 2002 16:18:12 -0400
Date: Sun, 2 Jun 2002 14:17:58 -0600
To: Hanno B?ck <hanno@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: radeon framebuffer problem
Message-ID: <20020602201758.GA19815@galileo>
Mail-Followup-To: James Mayer <james.mayer@acm.org>,
	Hanno B?ck <hanno@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020602211014.3ccbe57e.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: James Mayer <james@cobaltmountain.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Jun  2 19:55:35 hannonb kernel: radeonfb: cannot map FB
> 
> My card is a Radeon Mobility M6 LY.
> All kernels are with radeon framebuffer compiled in as the only
> framebuffer.

You might want to try this, I have an M6 LY with what I suspect is the
same problem.

Good luck!

--- radeonfb.c.orig	Thu May  9 16:51:26 2002
+++ radeonfb.c	Thu May  9 16:48:46 2002
@@ -877,6 +877,14 @@
 	/* mem size is bits [28:0], mask off the rest */
 	rinfo->video_ram = tmp & CONFIG_MEMSIZE_MASK;
 
+	/* According to XFree86 4.2.0, some production M6's return 0
+	   for 8MB. */
+	if (rinfo->video_ram == 0 && 
+	    (pdev->device == PCI_DEVICE_ID_RADEON_LY || 
+	     pdev->device == PCI_DEVICE_ID_RADEON_LZ)) {
+	    rinfo->video_ram = 8192 * 1024;
+	  }
+
 	/* ram type */
 	tmp = INREG(MEM_SDRAM_MODE_REG);
 	switch ((MEM_CFG_TYPE & tmp) >> 30) {
