Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbTAFNyw>; Mon, 6 Jan 2003 08:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266649AbTAFNyw>; Mon, 6 Jan 2003 08:54:52 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19402 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266645AbTAFNyw>; Mon, 6 Jan 2003 08:54:52 -0500
Date: Mon, 6 Jan 2003 15:03:26 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [2.5 patch] ALSA rme9652: remove __exit from hammerfall_free_buffers
Message-ID: <20030106140326.GT6114@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaroslav,

a mid-november ALSA update from you included a patch that added __exit 
to hammerfall_free_buffers in sound/pci/rme9652/hammerfall_mem.c. This 
patch is wrong since hammerfall_free_buffers is also called from the 
__init function alsa_hammerfall_mem_init resulting in a .exit.text 
linking error when trying to compile this driver statically into the 
kernel.

The following patch removes the __exit:

--- linux-2.5.54/sound/pci/rme9652/hammerfall_mem.c.old	2003-01-06 14:51:42.000000000 +0100
+++ linux-2.5.54/sound/pci/rme9652/hammerfall_mem.c	2003-01-06 14:52:29.000000000 +0100
@@ -178,7 +178,7 @@
 	printk ("Hammerfall memory allocator: unknown buffer address or PCI device ID");
 }
 
-static void __exit hammerfall_free_buffers (void)
+static void hammerfall_free_buffers (void)
 
 {
 	int i;


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

