Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287880AbSABSru>; Wed, 2 Jan 2002 13:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287896AbSABSrl>; Wed, 2 Jan 2002 13:47:41 -0500
Received: from [216.219.239.237] ([216.219.239.237]:24071 "EHLO
	www.sensoria.com") by vger.kernel.org with ESMTP id <S287880AbSABSra>;
	Wed, 2 Jan 2002 13:47:30 -0500
From: "Bao C. Ha" <baoha@sensoria.com>
To: <mlord@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Ide.c and Flash drives
Date: Wed, 2 Jan 2002 10:47:18 -0800
Message-ID: <011501c193bd$e7f3a150$456c020a@SENSORIA>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mark,

In the kernel 2.4.17, ide.c makes an assumption that
CompactFlash cards and their brethern don't have a
slave unit.  Unfortunately, I have two that can do
master/slave and get caught since they are side by
side: (1) CompactFlash on an IDE/ATA adapter (as
master)and (2) Simple Tech Flash disk (as slave).

I patched the following to get it to work:

--- ide.c.orig  Wed Jan  2 10:35:38 2002
+++ ide.c       Wed Jan  2 10:39:44 2002
@@ -324,13 +324,14 @@
        struct hd_driveid *id = drive->id;

        if (drive->removable && id != NULL) {
-               if (id->config == 0x848a) return 1;     /* CompactFlash */
+               /* if (id->config == 0x848a) return 1;  */ /* CompactFlash
*/
                if (!strncmp(id->model, "KODAK ATA_FLASH", 15)  /* Kodak */
                 || !strncmp(id->model, "Hitachi CV", 10)       /* Hitachi
*/
                 || !strncmp(id->model, "SunDisk SDCFB", 13)    /* SunDisk
*/
                 || !strncmp(id->model, "HAGIWARA HPC", 12)     /* Hagiwara
*/
                 || !strncmp(id->model, "LEXAR ATA_FLASH", 15)  /* Lexar */
-                || !strncmp(id->model, "ATA_FLASH", 9))        /* Simple
Tech */
+                /* || !strncmp(id->model, "ATA_FLASH", 9)) */  /* Simple
Tech */
+                )
                {
                        return 1;       /* yes, it is a flash memory card */
                }

Could the assumption be re-evaluated?  Am I going to
get into trouble doing this?

Regards.
Bao

