Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUDXVlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUDXVlb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 17:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbUDXVlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 17:41:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5083 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262585AbUDXVla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 17:41:30 -0400
Date: Sat, 24 Apr 2004 23:41:22 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>, Dag Brattli <dagb@cs.uit.no>,
       shemminger@osdl.org
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: Re: 2.6.5-rc3: unknown symbol in tekram.ko
Message-ID: <20040424214121.GD10976@fs.tum.de>
References: <200403311042.25265.rjwysocki@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403311042.25265.rjwysocki@sisk.pl>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 10:42:24AM +0200, R. J. Wysocki wrote:
> I get something like this after 'make modules_install':
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.5-rc3; fi
> WARNING: /lib/modules/2.6.5-rc3/kernel/drivers/net/irda/tekram.ko needs 
> unknown symbol irda_task_delete

Thanks for this report, and sorry for the late answer.

drivers/net/irda/tekram.c uses irda_task_delete, but this function is 
not EXPORT_SYMBOL'ed in net/irda/irda_device.c .

The most simple solution would be to change TEKRAM_DONGLE_OLD to be a 
bool (as does the patch below), but perhaps the IrDA people know a 
better solution.

cu
Adrian

--- linux-2.6.6-rc2-mm1-full/drivers/net/irda/Kconfig.old	2004-04-24 23:34:06.000000000 +0200
+++ linux-2.6.6-rc2-mm1-full/drivers/net/irda/Kconfig	2004-04-24 23:40:26.000000000 +0200
@@ -189,8 +189,8 @@
 	  "irattach -d actisys" or "irattach -d actisys+".
 
 config TEKRAM_DONGLE_OLD
-	tristate "Tekram IrMate 210B dongle"
-	depends on DONGLE_OLD && IRDA
+	bool "Tekram IrMate 210B dongle"
+	depends on DONGLE_OLD && IRDA=y
 	help
 	  Say Y here if you want to build support for the Tekram IrMate 210B
 	  dongle.  To compile it as a module, choose M here.  The Tekram dongle
