Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVAHHx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVAHHx7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVAHHxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:53:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:38021 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261849AbVAHFsL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:11 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <11051627753704@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:35 -0800
Message-Id: <1105162775137@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.445.1, 2004/12/15 11:29:09-08:00, johnpol@2ka.mipt.ru

[PATCH] w1: Documentation bits for generic w1 behaviour.

Documentation bits for generic w1 behaviour.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/w1/w1.generic |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+)


diff -Nru a/Documentation/w1/w1.generic b/Documentation/w1/w1.generic
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/w1/w1.generic	2005-01-07 14:56:22 -08:00
@@ -0,0 +1,19 @@
+Any w1 device must be connected to w1 bus master device - for example
+ds9490 usb device or w1-over-GPIO or RS232 converter.
+Driver for w1 bus master must provide several functions(you can find
+them in struct w1_bus_master definition in w1.h) which then will be
+called by w1 core to send various commands over w1 bus(by default it is
+reset and search commands). When some device is found on the bus, w1 core
+checks if driver for it's family is loaded.
+If driver is loaded w1 core creates new w1_slave object and registers it
+in the system(creates some generic sysfs files(struct w1_family_ops in
+w1_family.h), notifies any registered listener and so on...).
+It is device driver's business to provide any communication method
+upstream.
+For example w1_therm driver(ds18?20 thermal sensor family driver)
+provides temperature reading function which is bound to ->rbin() method
+of the above w1_family_ops structure.
+w1_smem - driver for simple 64bit memory cell provides ID reading
+method.
+
+You can call above methods by reading appropriate sysfs files.

