Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbTALNpN>; Sun, 12 Jan 2003 08:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266433AbTALNpN>; Sun, 12 Jan 2003 08:45:13 -0500
Received: from tag.witbe.net ([81.88.96.48]:45831 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S266367AbTALNpM>;
	Sun, 12 Jan 2003 08:45:12 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Jens Axboe'" <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Cc: "'Sam Ravnborg'" <sam@ravnborg.org>
Subject: Re: [BUG 2.5.56] IDE/CDROM Oops at boot time without /proc
Date: Sun, 12 Jan 2003 14:53:59 +0100
Message-ID: <00a101c2ba42$0ed2d060$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20030112133700.GF14017@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hellon

> > Please note that, however, I've tested this change, and it is
> > working fine on my machine.
> 
> Thanks for the raport, the proposed change is fine with me. 
> Care to generate a real patch?
> 
Here it is :

4 [14:52] rol@donald:/kernels> diff -uN
linux-2.5.56/drivers/cdrom/cdrom.c
linux-2.5.56-work/drivers/cdrom/cdrom.c 
--- linux-2.5.56/drivers/cdrom/cdrom.c  2003-01-10 21:11:26.000000000
+0100
+++ linux-2.5.56-work/drivers/cdrom/cdrom.c     2003-01-12
14:30:55.000000000 +0100
@@ -2579,7 +2579,9 @@
                return;
 
        cdrom_sysctl_header = register_sysctl_table(cdrom_root_table,
1);
+#ifdef CONFIG_PROC_FS
        cdrom_root_table->child->de->owner = THIS_MODULE;
+#endif
 
        /* set the defaults */
        cdrom_sysctl_settings.autoclose = autoclose;

Regards,
Paul Rolland, rol@as2917.net

