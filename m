Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbTKRTHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 14:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263768AbTKRTHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 14:07:15 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9692 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263767AbTKRTHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 14:07:13 -0500
Date: Tue, 18 Nov 2003 20:07:05 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, paulkf@microgate.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] fixup after synclink update
Message-ID: <20031118190704.GQ326@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.23-rc contains a synclink update that contains the following change:

<--  snip  -->

 static struct pci_driver synclink_pci_driver = {
        name:           "synclink",
        id_table:       synclink_pci_tbl,
        probe:          synclink_init_one,
-       remove:         __devexit_p(synclink_remove_one),
+       remove:         synclink_remove_one,
 };

<--  snip  -->


This change causes the following compile error when compiling the driver 
statically into a kernel without hotplug support:

<--  snip  -->

...
        --end-group \
        -o vmlinux
local symbol 0: discarded in section `.text.exit' from drivers/char/char.o
make: *** [vmlinux] Error 1

<--  snip  -->


The following patch reverts this bogus change:

--- linux-2.4.23-rc1-full-nohotplug/drivers/char/synclink.c.old	2003-11-18 18:30:06.000000000 +0100
+++ linux-2.4.23-rc1-full-nohotplug/drivers/char/synclink.c	2003-11-18 18:31:14.000000000 +0100
@@ -945,7 +945,7 @@
 	name:		"synclink",
 	id_table:	synclink_pci_tbl,
 	probe:		synclink_init_one,
-	remove:		synclink_remove_one,
+	remove:		__devexit_p(synclink_remove_one),
 };
 
 static struct tty_driver serial_driver, callout_driver;



Please apply for 2.4.23-rc2.


TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

