Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUKMQ1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUKMQ1a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 11:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbUKMQ1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 11:27:30 -0500
Received: from kenga.kmv.ru ([217.13.212.5]:12013 "EHLO kenga.kmv.ru")
	by vger.kernel.org with ESMTP id S261867AbUKMQ1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 11:27:25 -0500
Date: Sat, 13 Nov 2004 19:27:09 +0300
From: Andrey Melnikoff <temnota+news@kmv.ru>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.28-rc3
Message-ID: <20041113162709.GX24130@kmv.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041112180052.GE23215@logos.cnet>
X-Newsgroups: gmane.linux.kernel
User-Agent: Mutt/1.5.6+20040907i
X-Data-Status: msg.XXxXKLrc:3972@kenga.kmv.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041112180052.GE23215@logos.cnet> you wrote:
> Hi,

> Here goes the third release candidate.

> It contains a v2.6 backport of the binfmt_elf potential vulnerabilities
> disclosed this week, an enhanced smbfs client overflow fix, an ACPI update
> fixing a couple of nasty bugs, a NFS client bugfix and a network update
> from Davem.

Any chance to apply this patch before release?

Prevent NMI oopser kill kernel thread when megearid2 driver wating abort or
reset command completion. 

Signed-off-by: Andrey Melnikov <temnota+kernel@kmv.ru>

--- linux-2.4.28-rc3/drivers/scsi/megaraid2.c~	Thu Nov 11 19:37:13 2004
+++ linux-2.4.28-rc3/drivers/scsi/megaraid2.c	Sat Nov 13 19:20:23 2004
@@ -39,6 +39,7 @@
 #include <linux/reboot.h>
 #include <linux/module.h>
 #include <linux/list.h>
+#include <linux/nmi.h>
 
 #include "sd.h"
 #include "scsi.h"
@@ -2820,6 +2821,7 @@
 
 		if( iter++ < MBOX_ABORT_SLEEP*1000 ) {
 			mdelay(1);
+			touch_nmi_watchdog();
 		}
 		else {
 			printk(KERN_WARNING
@@ -2900,6 +2902,7 @@
 
 		if( iter++ < MBOX_RESET_SLEEP*1000 ) {
 			mdelay(1);
+			touch_nmi_watchdog();
 		}
 		else {
 			printk(KERN_WARNING


-- 
 Best regards, TEMHOTA-RIPN aka MJA13-RIPE
 System Administrator. mailto:temnota@kmv.ru

