Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWFTGlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWFTGlt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbWFTGlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:41:49 -0400
Received: from tougher.kangaroot.net ([62.213.203.135]:3755 "EHLO
	tougher.kangaroot.net") by vger.kernel.org with ESMTP
	id S965091AbWFTGls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:41:48 -0400
Date: Tue, 20 Jun 2006 08:41:28 +0200
From: Wouter Paesen <wouter@kangaroot.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.17-rc6] input/mouse/sermouse: fix memleak and potential buffer overflow
Message-ID: <20060620064127.GA25367@tougher.kangaroot.net>
References: <20060615104702.GA4866@tougher.kangaroot.net> <200606180024.32759.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606180024.32759.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Jun 18, 2006 at 12:24:31AM -0400, Dmitry Torokhov wrote:
> >   Because serio->phys is also a 32 character field the sprintf could
> >   result in 39 characters being written to the sermouse->phys.
> 
> Right, we need to change it to use snprintf.

Thanks, this patch will do just that. 
Still, keeping the array 39 characters long will prevent truncation of the string.

Signed-off-by: Wouter Paesen <wouter@kangaroot.net>

--- linux-2.6.17-rc6.orig/drivers/input/mouse/sermouse.c 2006-06-20 08:31:12.000000000 +0200
+++ linux-2.6.17-rc6/drivers/input/mouse/sermouse.c 2006-06-20 08:31:41.000000000 +0200
@@ -53,7 +53,7 @@ struct sermouse {
 	unsigned char count;
 	unsigned char type;
 	unsigned long last;
-	char phys[32];
+	char phys[39];
 };
 
 /*
@@ -254,7 +254,7 @@ static int sermouse_connect(struct serio
 		goto fail;
 
 	sermouse->dev = input_dev;
-	sprintf(sermouse->phys, "%s/input0", serio->phys);
+	snprintf(sermouse->phys, 39, "%s/input0", serio->phys);
 	sermouse->type = serio->id.proto;
 
 	input_dev->name = sermouse_protocols[sermouse->type];


