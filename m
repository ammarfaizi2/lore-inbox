Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291677AbSBAK2T>; Fri, 1 Feb 2002 05:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291675AbSBAK17>; Fri, 1 Feb 2002 05:27:59 -0500
Received: from web13308.mail.yahoo.com ([216.136.175.44]:6163 "HELO
	web13308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S291673AbSBAK1y>; Fri, 1 Feb 2002 05:27:54 -0500
Message-ID: <20020201102753.90799.qmail@web13308.mail.yahoo.com>
Date: Fri, 1 Feb 2002 02:27:53 -0800 (PST)
From: Joerg Pommnitz <pommnitz@yahoo.com>
Subject: RE: false positives on disk change checks
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> I don't know the original posters problem, but I suspect I see something
> similar. On a to be embedded system with a Geode (Cyrix) CPU and with a
> ATA compatible CompactFlash drive I get the following messages on 
> bootup:
> 
> invalidate: busy buffer
> VFS: busy inodes on changed media.
> 
> This seems to happen while the system tries to remount the root fs rw.

The following patch works around the problem for me:

diff -ruN linux/drivers/ide/ide-probe.c
linux-scorpio/drivers/ide/ide-probe.c
--- linux/drivers/ide/ide-probe.c       Mon Nov 26 14:29:17 2001
+++ linux-scorpio/drivers/ide/ide-probe.c       Fri Feb  1 12:06:59 2002
@@ -154,11 +154,14 @@
                return;
        }

+#if 0
        /*
         * Not an ATAPI device: looks like a "regular" hard disk
         */
        if (id->config & (1<<7))
                drive->removable = 1;
+#endif
+
        /*
         * Prevent long system lockup probing later for non-existant
         * slave drive if the hwif is actually a flash memory card of some
variety:

It's obviously not a general solution but I know for sure that
the flashdisk is not removable in our setup.

Regards
  Joerg

=====
-- 
Regards
       Joerg


__________________________________________________
Do You Yahoo!?
Great stuff seeking new owners in Yahoo! Auctions! 
http://auctions.yahoo.com
