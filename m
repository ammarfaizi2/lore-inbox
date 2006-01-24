Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWAXXV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWAXXV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWAXXV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:21:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:19637 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750828AbWAXXVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:21:25 -0500
Subject: Re: uevent buffer overflow in input layer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060124105857.GA9210@vrfy.org>
References: <1137973421.4907.14.camel@localhost.localdomain>
	 <20060124050346.GC22848@kroah.com>
	 <200601240101.21238.dtor_core@ameritech.net>
	 <20060124060741.GA23869@kroah.com>  <20060124105857.GA9210@vrfy.org>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 10:21:32 +1100
Message-Id: <1138144893.4907.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer used for kobject uevent is too small for some of the events generated
by the input layer. Bump it to 2k.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-work/lib/kobject_uevent.c
===================================================================
--- linux-work.orig/lib/kobject_uevent.c	2006-01-11 12:56:30.000000000 +1100
+++ linux-work/lib/kobject_uevent.c	2006-01-25 10:20:24.000000000 +1100
@@ -22,7 +22,7 @@
 #include <linux/kobject.h>
 #include <net/sock.h>
 
-#define BUFFER_SIZE	1024	/* buffer for the variables */
+#define BUFFER_SIZE	2048	/* buffer for the variables */
 #define NUM_ENVP	32	/* number of env pointers */
 
 #if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)


