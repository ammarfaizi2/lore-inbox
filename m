Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTJFOBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 10:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTJFOBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 10:01:54 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:37003 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262188AbTJFOBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 10:01:50 -0400
Message-ID: <3F81769B.1060508@terra.com.br>
Date: Mon, 06 Oct 2003 11:05:15 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: support@comtrol.com
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] release_region in RocketPort char driver
Content-Type: multipart/mixed;
 boundary="------------010903010308010506050604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010903010308010506050604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Andrew/Comtrol people :),

	Patch against 2.6.0-test6.

	- Release a previous requested region if tty_register_driver fails. 
Found by smatch

	Please consider applying,

	Thanks.

Felipe

--------------010903010308010506050604
Content-Type: text/plain;
 name="rocket-release_region.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rocket-release_region.patch"

--- linux-2.6.0-test6/drivers/char/rocket.c.orig	2003-10-06 10:57:29.000000000 -0300
+++ linux-2.6.0-test6/drivers/char/rocket.c	2003-10-06 11:00:29.000000000 -0300
@@ -2468,6 +2468,7 @@
 	if (retval < 0) {
 		printk(KERN_INFO "Couldn't install tty RocketPort driver (error %d)\n", -retval);
 		put_tty_driver(rocket_driver);
+		release_region(controller, 4);
 		return -1;
 	}
 

--------------010903010308010506050604--

