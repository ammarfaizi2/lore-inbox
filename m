Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUBDLwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 06:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbUBDLwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 06:52:09 -0500
Received: from broremann2.ux.his.no ([152.94.1.11]:24765 "EHLO
	broremann2.ux.his.no") by vger.kernel.org with ESMTP
	id S262580AbUBDLwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 06:52:06 -0500
Date: Wed, 4 Feb 2004 12:51:28 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Sun Keyboard driver
Message-ID: <20040204115128.GA25798@badne4.ux.his.no>
Reply-To: Erlend Aasland <erlend-a@ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed a small bug in the sunkbd.c driver: After the keyboard name is
set, it is mistakenly overwritten by serio->phys. Path is against 2.6.2.

Regards,
		Erlend Aasland

--- drivers/input/keyboard/sunkbd.c~	2004-02-04 13:06:44.603610000 +0100
+++ drivers/input/keyboard/sunkbd.c	2004-02-04 13:09:00.603610000 +0100
@@ -275,7 +275,7 @@
 		set_bit(sunkbd->keycode[i], sunkbd->dev.keybit);
 	clear_bit(0, sunkbd->dev.keybit);
 
-	sprintf(sunkbd->name, "%s/input", serio->phys);
+	sprintf(sunkbd->phys, "%s/input", serio->phys);
 
 	sunkbd->dev.name = sunkbd->name;
 	sunkbd->dev.phys = sunkbd->phys;
