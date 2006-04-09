Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWDIRss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWDIRss (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 13:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWDIRss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 13:48:48 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38150 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750827AbWDIRsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 13:48:47 -0400
Date: Sun, 9 Apr 2006 19:48:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] dvb/bt8xx/bt878.c: don't export static variables
Message-ID: <20060409174846.GJ8454@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Static variables mustn't be EXPORT_SYMBOL'ed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/dvb/bt8xx/bt878.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.17-rc1-mm2-full/drivers/media/dvb/bt8xx/bt878.c.old	2006-04-09 18:43:28.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/media/dvb/bt8xx/bt878.c	2006-04-09 18:44:26.000000000 +0200
@@ -54,26 +54,24 @@
 static unsigned int bt878_verbose = 1;
 static unsigned int bt878_debug;
 
 module_param_named(verbose, bt878_verbose, int, 0444);
 MODULE_PARM_DESC(verbose,
 		 "verbose startup messages, default is 1 (yes)");
 module_param_named(debug, bt878_debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off debugging, default is 0 (off).");
 
 int bt878_num;
 struct bt878 bt878[BT878_MAX];
 
-EXPORT_SYMBOL(bt878_debug);
-EXPORT_SYMBOL(bt878_verbose);
 EXPORT_SYMBOL(bt878_num);
 EXPORT_SYMBOL(bt878);
 
 #define btwrite(dat,adr)    bmtwrite((dat), (bt->bt878_mem+(adr)))
 #define btread(adr)         bmtread(bt->bt878_mem+(adr))
 
 #define btand(dat,adr)      btwrite((dat) & btread(adr), adr)
 #define btor(dat,adr)       btwrite((dat) | btread(adr), adr)
 #define btaor(dat,mask,adr) btwrite((dat) | ((mask) & btread(adr)), adr)
 
 #if defined(dprintk)
 #undef dprintk

