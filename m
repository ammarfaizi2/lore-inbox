Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbTJKQdP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 12:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTJKQdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 12:33:15 -0400
Received: from mail-1.tiscali.it ([195.130.225.147]:64672 "EHLO
	mail-1.tiscali.it") by vger.kernel.org with ESMTP id S263320AbTJKQdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 12:33:14 -0400
Date: Sat, 11 Oct 2003 18:32:44 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: frodol@dds.nl, Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: [patch] sensors/w83781d.c creates useless sysfs entries
Message-ID: <20031011163244.GA2570@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8805A7.6080306@kmlinux.fjfi.cvut.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz> ha scritto:
> Hello,
> 
> here is a trivial fix for Winbond sensor driver, which currently creates 
> useless entries in sys/bus/i2c due to missing braces after if statements 
> - author probably forgot about the macro expansion.

IMHO it's better to fix the macro:

--- a/drivers/i2c/chips/w83781d.c	Sun Sep 28 17:47:38 2003
+++ b/drivers/i2c/chips/w83781d.c	Sat Oct 11 18:31:04 2003
@@ -422,9 +422,11 @@
 sysfs_in_offsets(8);
 
 #define device_create_file_in(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_in_input##offset); \
 device_create_file(&client->dev, &dev_attr_in_min##offset); \
-device_create_file(&client->dev, &dev_attr_in_max##offset);
+device_create_file(&client->dev, &dev_attr_in_max##offset); \
+} while (0);
 
 #define show_fan_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Windows NT: Designed for the Internet. The Internet: Designed for Unix.
