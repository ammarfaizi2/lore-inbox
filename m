Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261858AbREPJwY>; Wed, 16 May 2001 05:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbREPJwO>; Wed, 16 May 2001 05:52:14 -0400
Received: from ns.caldera.de ([212.34.180.1]:16595 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S261853AbREPJv5>;
	Wed, 16 May 2001 05:51:57 -0400
Date: Wed, 16 May 2001 11:48:42 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: PATCH: NCR53c406 missing release_region
Message-ID: <20010516114842.A30386@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There was a missing release_region in NCR53c406a.c, which fscked up
probing with 'modprobe NCR53c406' like one mode of our installer does.
(Tested by checking the contents of /proc/ioports before and after. After
 modprobe it contained junk for the probed port range. It no longer does.)

Ciao, Marcus

Index: drivers/scsi/NCR53c406a.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/scsi/NCR53c406a.c,v
retrieving revision 1.6
diff -u -r1.6 NCR53c406a.c
--- drivers/scsi/NCR53c406a.c	2001/05/03 13:03:53	1.6
+++ drivers/scsi/NCR53c406a.c	2001/05/16 09:38:11
@@ -508,6 +508,7 @@
                     VDEB(printk("port_base=%x\n", port_base));
                     break;
                 }
+                release_region(ports[i], 0x10);
             }
         }
     }
