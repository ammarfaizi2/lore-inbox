Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267050AbTBLWpB>; Wed, 12 Feb 2003 17:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267899AbTBLWpB>; Wed, 12 Feb 2003 17:45:01 -0500
Received: from air-2.osdl.org ([65.172.181.6]:57220 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267050AbTBLWo7>;
	Wed, 12 Feb 2003 17:44:59 -0500
Date: Wed, 12 Feb 2003 14:51:56 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: rudmer@legolas.dynup.net, andmike@us.ibm.com, linux-kernel@vger.kernel.org,
       fischer@norbit.de
Subject: Re: [PATCH] fix scsi/aha15*.c for 2.5.60
Message-Id: <20030212145156.52312fd1.rddunlap@osdl.org>
In-Reply-To: <1045089866.1763.3.camel@mulgrave>
References: <3E49DC38.52D278C4@verizon.net>
	<200302122246.19225@gandalf>
	<1045089866.1763.3.camel@mulgrave>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| > > Here are patches to aha152x.c and aha1542.c so that they will build
| > > in 2.5.60.
| > > 
| > > Please review and apply or comment...
| > 
| > well it applies, compiles, but it gives a warning on depmod in make 
| > modules_install:
| > 
| > <snip>
| > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.60; fi
| > WARNING: /lib/modules/2.5.60/kernel/drivers/scsi/aha152x.ko needs unknown 
| > symbol scsi_put_command
| > WARNING: /lib/modules/2.5.60/kernel/drivers/scsi/aha152x.ko needs unknown 
| > symbol scsi_get_command
| > 
| > this is the relevant part of my .config:
| > CONFIG_SCSI=m
| > CONFIG_SCSI_AHA152X=m
| > 
| > this gives these modules in /lib/modules/2.5.60/kernel/drivers/scsi/:
| > aha152x.ko  scsi_mod.ko  sg.ko
| > 
| > what am i missing??
| 
| Nothing really, the symbols need to be exported from the SCSI core. 
| I'll add them to the export list.

I generated a patch for Rudmer in case he needs it.

~Randy


patch_name:	scsi-exports-2560.patch
patch_version:	2003-02-12.14:44:43
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	_
product:	Linux
product_versions: linux-2560
changelog:	_
URL:		_
requires:	_
conflicts:	_
diffstat:	TBD

diff -Naur ./drivers/scsi/scsi_syms.c%EXP ./drivers/scsi/scsi_syms.c
--- ./drivers/scsi/scsi_syms.c%EXP	Mon Feb 10 10:38:37 2003
+++ ./drivers/scsi/scsi_syms.c	Wed Feb 12 14:42:43 2003
@@ -80,6 +80,8 @@
 EXPORT_SYMBOL(scsi_slave_detach);
 EXPORT_SYMBOL(scsi_device_get);
 EXPORT_SYMBOL(scsi_device_put);
+EXPORT_SYMBOL(scsi_get_command);
+EXPORT_SYMBOL(scsi_put_command);
 
 /*
  * This symbol is for the highlevel drivers (e.g. sg) only.
