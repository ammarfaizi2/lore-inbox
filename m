Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbTJNOlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 10:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTJNOlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 10:41:10 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:48109 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262412AbTJNOlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 10:41:05 -0400
Message-ID: <3F8BFDA9.5090403@terra.com.br>
Date: Tue, 14 Oct 2003 11:44:09 -0200
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: support@comtrol.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] release_region in RocketPort char driver
References: <3F81769B.1060508@terra.com.br> <20031012173117.35bd221c.akpm@osdl.org>
In-Reply-To: <20031012173117.35bd221c.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060103060207010003090606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060103060207010003090606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Andrew,

Andrew Morton wrote:
> Felipe W Damasio <felipewd@terra.com.br> wrote:
> a) If variable `controller' is zero then we never allocated this region,
>    so we should not free it.
> 
> b) There is an error exit path further on which also needs to release
>    this region (if controller != 0).

	Right.

	Please review this patch, then.

	Against 2.6.0-test7.

	Thanks,

Felipe

--------------060103060207010003090606
Content-Type: text/plain;
 name="rocket-release_region.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rocket-release_region.patch"

--- linux-2.6.0-test7/drivers/char/rocket.c.orig	2003-10-14 11:38:44.000000000 -0200
+++ linux-2.6.0-test7/drivers/char/rocket.c	2003-10-14 11:42:40.000000000 -0200
@@ -2466,6 +2466,8 @@
 	if (retval < 0) {
 		printk(KERN_INFO "Couldn't install tty RocketPort driver (error %d)\n", -retval);
 		put_tty_driver(rocket_driver);
+		if (controller)
+			release_region (controller, 4);
 		return -1;
 	}
 
@@ -2497,6 +2499,8 @@
 		del_timer_sync(&rocket_timer);
 		tty_unregister_driver(rocket_driver);
 		put_tty_driver(rocket_driver);
+		if (controller) 
+			release_region (controller, 4);
 		return -ENXIO;
 	}
 

--------------060103060207010003090606--

