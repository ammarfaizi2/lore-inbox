Return-Path: <linux-kernel-owner+w=401wt.eu-S932082AbXAVQ6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbXAVQ6t (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 11:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbXAVQ6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 11:58:49 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:58849 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932082AbXAVQ6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 11:58:48 -0500
Date: Mon, 22 Jan 2007 17:52:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Nicholas Miell <nmiell@comcast.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linville@tuxdriver.com
Subject: Re: [PATCH] Introduce simple TRUE and FALSE boolean macros.
In-Reply-To: <Pine.LNX.4.64.0701221039160.21545@CPE00045a9c397f-CM001225dbafb6>
Message-ID: <Pine.LNX.4.61.0701221750140.317@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0701210454590.2844@CPE00045a9c397f-CM001225dbafb6>
  <1169401892.2999.1.camel@entropy>  <Pine.LNX.4.64.0701211430020.17235@CPE00045a9c397f-CM001225dbafb6>
  <45B495F9.4@yahoo.com.au>  <Pine.LNX.4.64.0701220556580.22914@CPE00045a9c397f-CM001225dbafb6>
 <1169479123.15483.42.camel@Homer.simpson.net>
 <Pine.LNX.4.64.0701221039160.21545@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 22 2007 10:41, Robert P. J. Day wrote:
>
>as opposed to the 100+ *other* definitions currently cluttering up the
>tree, which this patch would allow to be deleted *immediately*.
>
>forget it.  i can see this argument is going nowhere and that, six
>months from now, some poor sucker is going to post, asking, "hey, you
>know all these TRUE/FALSE things?  wouldn't it be great if we could,
>you know, clean those up?  whaddya say?"
>
>and groundhog day will begin all over again ...

I don't get it why it's so hard to do (b) over (a)

  (a) remove all TRUE/FALSE and add TRUE/FALSE to linux/types.h
      as per http://lkml.org/lkml/2007/1/21/19

  (b) see below

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

Index: linux-2.6.20-rc5/drivers/net/wireless/strip.c
===================================================================
--- linux-2.6.20-rc5.orig/drivers/net/wireless/strip.c
+++ linux-2.6.20-rc5/drivers/net/wireless/strip.c
@@ -177,8 +177,6 @@ typedef struct {
 	MetricomNode node[NODE_TABLE_SIZE];
 } MetricomNodeTable;
 
-enum { FALSE = 0, TRUE = 1 };
-
 /*
  * Holds the radio's firmware version.
  */
@@ -1209,7 +1207,7 @@ static void ResetRadio(struct strip *str
 	if (!strip_info->manual_dev_addr)
 		*(MetricomAddress *) strip_info->dev->dev_addr =
 		    zero_address;
-	strip_info->working = FALSE;
+	strip_info->working = false;
 	strip_info->firmware_level = NoStructure;
 	strip_info->next_command = CompatibilityCommand;
 	strip_info->watchdog_doprobe = jiffies + 10 * HZ;
@@ -1845,7 +1843,7 @@ static void RecvErr_Message(struct strip
 		}
 #endif
 		if (!strip_info->working) {
-			strip_info->working = TRUE;
+			strip_info->working = true;
 			printk(KERN_INFO "%s: Radio now in starmode\n",
 			       strip_info->dev->name);
 			/*
@@ -2455,7 +2453,7 @@ static int strip_open_low(struct net_dev
 	strip_info->tx_left = 0;
 
 	strip_info->discard = 0;
-	strip_info->working = FALSE;
+	strip_info->working = false;
 	strip_info->firmware_level = NoStructure;
 	strip_info->next_command = CompatibilityCommand;
 	strip_info->user_baud = get_baud(strip_info->tty);
#<EOF>


	-`J'
-- 
