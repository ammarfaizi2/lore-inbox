Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318248AbSHKTVh>; Sun, 11 Aug 2002 15:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318271AbSHKTVh>; Sun, 11 Aug 2002 15:21:37 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:61713 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S318248AbSHKTVg>;
	Sun, 11 Aug 2002 15:21:36 -0400
Message-ID: <3D56B94C.8AC7E47@torque.net>
Date: Sun, 11 Aug 2002 15:21:48 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.31
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide-cd and ide-scsi couldn't be installed as modules
on my machine in lk 2.5.31 because the EXPORT of
unregister_ata_driver() was removed.

The reversal below fixed my problem.

Doug Gilbert

--- linux/drivers/ide/main.c2531	Sun Aug 11 09:19:24 2002
+++ linux/drivers/ide/main.c	Sun Aug 11 13:10:06 2002
@@ -1124,6 +1124,8 @@
 	}
 }
 
+EXPORT_SYMBOL(unregister_ata_driver);
+
 EXPORT_SYMBOL(ide_hwifs);
 EXPORT_SYMBOL(ide_lock);
 

