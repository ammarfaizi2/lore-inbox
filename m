Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUH3HBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUH3HBk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 03:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266703AbUH3HBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 03:01:40 -0400
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:4 "EHLO
	darkwood.somewhere") by vger.kernel.org with ESMTP id S266807AbUH3G7r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 02:59:47 -0400
Date: Mon, 30 Aug 2004 07:52:44 +0000
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jacekpoplawski@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc1 stv0299 fix
Message-ID: <20040830075244.GA166@bokowka>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I use SkyStar 2.6c DVB card. I noticed that I can't watch digital television
anymore, after 2.6.7 to 2.6.9-rc1 upgrade. First reason was change of DVB
device, but second one is little bug in kernel.

Name of device has been changed in 2.6.9-rc1 to "SkyStar2", but module stv0299
still compares name with "Technisat SkyStar2 driver", strings are different,
and result is that stv0299 detects invalid tuner type. Not only I am not able
to tune anything, but also I can crash system just by reloading DVB modules and
being in X at same time.

Following obvious patch fixes problem.

--- linux-2.6.9-rc1/drivers/media/dvb/frontends/stv0299.c	2004-08-25 21:40:56.000000000 +0200
+++ linux/drivers/media/dvb/frontends/stv0299.c	2004-08-30 02:08:00.902739808 +0200
@@ -1271,7 +1271,7 @@
 
 	printk ("%s: try to attach to %s\n", __FUNCTION__, adapter->name);
 
-	if ( strcmp(adapter->name, "Technisat SkyStar2 driver") == 0 )
+	if ( strcmp(adapter->name, "SkyStar2") == 0 )
 	{
 	    printk ("%s: setup for tuner Samsung TBMU24112IMB\n", __FILE__)


-- 
Free Software - find interesting programs and change them
NetHack - meet interesting creatures, kill them and eat their bodies
Usenet - meet interesting people from all over the world and flame them
Decopter - unrealistic helicopter simulator, get it from http://decopter.sf.net
