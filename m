Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274249AbRISXC7>; Wed, 19 Sep 2001 19:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274250AbRISXCw>; Wed, 19 Sep 2001 19:02:52 -0400
Received: from CPE-61-9-148-200.vic.bigpond.net.au ([61.9.148.200]:59122 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S274249AbRISXCj>; Wed, 19 Sep 2001 19:02:39 -0400
Message-ID: <3BA92171.AA6438C@eyal.emu.id.au>
Date: Thu, 20 Sep 2001 08:51:29 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "list, linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.10-pre12 ide raid undefined patch
Content-Type: multipart/mixed;
 boundary="------------ECC7BE1A21427166D7AA1E37"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------ECC7BE1A21427166D7AA1E37
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Glancing at the -ac tree it seems that put_gendisk needs to be
removed from the recently added IDE RAID drivers.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
--------------ECC7BE1A21427166D7AA1E37
Content-Type: text/plain; charset=us-ascii;
 name="2.4.10-pre12-ideraid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.10-pre12-ideraid.patch"

--- linux/drivers/ide/hptraid.c	Wed Sep 19 22:01:42 2001
+++ linux-2.4-ac/drivers/ide/hptraid.c	Wed Sep 19 08:24:40 2001
@@ -314,7 +314,6 @@
 		if (gd!=NULL) {
 			for (j=1+(minor<<gd->minor_shift);j<((minor+1)<<gd->minor_shift);j++) 
 				gd->part[j].nr_sects=0;					
-			put_gendisk(gd);
 		}
         }
 	raid[device].disk[i].device = MKDEV(major,minor);
--- linux/drivers/ide/pdcraid.c	Wed Sep 19 22:01:42 2001
+++ linux-2.4-ac/drivers/ide/pdcraid.c	Wed Sep 19 08:24:40 2001
@@ -321,7 +321,6 @@
 				if (gd!=NULL) {
 					for (j=1+(minor<<gd->minor_shift);j<((minor+1)<<gd->minor_shift);j++) 
 						gd->part[j].nr_sects=0;					
-					put_gendisk(gd);
 				}
 			}
 			raid[device].disk[i].device = MKDEV(major,minor);


--------------ECC7BE1A21427166D7AA1E37--

