Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262601AbSI0Tja>; Fri, 27 Sep 2002 15:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262598AbSI0Tj0>; Fri, 27 Sep 2002 15:39:26 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:3854 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262600AbSI0TjT>;
	Fri, 27 Sep 2002 15:39:19 -0400
Date: Fri, 27 Sep 2002 12:42:58 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More USB changes for 2.5.38
Message-ID: <20020927194258.GF12909@kroah.com>
References: <20020927193723.GA12909@kroah.com> <20020927193855.GB12909@kroah.com> <20020927194025.GC12909@kroah.com> <20020927194054.GD12909@kroah.com> <20020927194240.GE12909@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927194240.GE12909@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.611.1.4 -> 1.611.1.5
#	drivers/usb/storage/sddr55.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/26	tim@physik3.uni-rostock.de	1.611.1.5
# [PATCH] fix compares of jiffies
# 
# on rechecking the current stable kernel code, I found some places where jiffies
# were compared in a way that seems to break when they wrap. For these,
# I made up patches to use the macros "time_before()" or "time_after()"
# that are supposed to handle wraparound correctly.
# --------------------------------------------
#
diff -Nru a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
--- a/drivers/usb/storage/sddr55.c	Fri Sep 27 12:30:17 2002
+++ b/drivers/usb/storage/sddr55.c	Fri Sep 27 12:30:17 2002
@@ -788,7 +788,7 @@
 	/* only check card status if the map isn't allocated, ie no card seen yet
 	 * or if it's been over half a second since we last accessed it
 	 */
-	if (info->lba_to_pba == NULL || jiffies > (info->last_access + HZ/2)) {
+	if (info->lba_to_pba == NULL || time_after(jiffies, info->last_access + HZ/2)) {
 
 		/* check to see if a card is fitted */
 		result = sddr55_status (us);
