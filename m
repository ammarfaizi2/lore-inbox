Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136508AbREDVLV>; Fri, 4 May 2001 17:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136510AbREDVLL>; Fri, 4 May 2001 17:11:11 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:24071 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S136508AbREDVK5>; Fri, 4 May 2001 17:10:57 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105042110.XAA20705@green.mif.pg.gda.pl>
Subject: Re: 2.4.4-ac4 - oops on unload "cdrom" module
To: proski@gnu.org
Date: Fri, 4 May 2001 23:10:22 +0200 (CEST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (kernel list), axboe@suse.de
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This oops happens when I run "rmmod cdrom" on a 2.4.4-ac4 kernel with
> CONFIG_SYSCTL enabled. It doesn't happen if CONFIG_SYSCTL is disabled.
> 
> sr_mod isn't loaded at this point. Reference to sd_mod looks weird. After
> this oops the "cdrom" module remains in memory in the "deleted" state.

> Unable to handle kernel NULL pointer dereference at virtual address 00000008
[...]
> >>EIP; c0118051 <unregister_sysctl_table+5/2c>   <=====

The following patch fixes unloading of cdrom module when no cdrom driver
loaded (2.4.5-pre, 2.4.4-ac):

--- drivers/cdrom/cdrom.c.old	Fri May  4 22:44:31 2001
+++ drivers/cdrom/cdrom.c	Fri May  4 22:54:36 2001
@@ -2698,7 +2698,8 @@
 
 static void cdrom_sysctl_unregister(void)
 {
-	unregister_sysctl_table(cdrom_sysctl_header);
+	if (cdrom_sysctl_header)
+		unregister_sysctl_table(cdrom_sysctl_header);
 }
 
 #endif /* CONFIG_SYSCTL */


Andrzej


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  tel.  (0-58) 347 14 61
Wydz.Fizyki Technicznej i Matematyki Stosowanej Politechniki Gdanskiej
