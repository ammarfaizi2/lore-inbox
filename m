Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWJVPpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWJVPpj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 11:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWJVPpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 11:45:39 -0400
Received: from viefep15-int.chello.at ([213.46.255.20]:14879 "EHLO
	viefep14-int.chello.at") by vger.kernel.org with ESMTP
	id S1750977AbWJVPpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 11:45:38 -0400
Message-ID: <453B921D.80008@freemail.hu>
Date: Sun, 22 Oct 2006 17:45:33 +0200
From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.7.12) Gecko/20050920
X-Accept-Language: en, hu, de
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch] input: function call order in serio_exit()
Content-Type: multipart/mixed;
 boundary="------------070507060901030101080602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070507060901030101080602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the order of the bus registration and the kthread start was changed
between linux kernel 2.6.17.11 and 2.6.18. The order is now first
register the bus and then start the kthread. The serio_exit() left
unchanged.

I think that the order of the function calls in serio_exit() should also
be changed: first stop the kthread and then unregister the bus.

What do you think?

	NMarci


--------------070507060901030101080602
Content-Type: text/plain;
 name="serio-exit.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serio-exit.diff"

--- linux-2.6.19-rc2.orig/drivers/input/serio/serio.c	2006-10-13 18:25:04.000000000 +0200
+++ linux-2.6.19-rc2/drivers/input/serio/serio.c	2006-10-17 08:17:30.000000000 +0200
@@ -958,8 +958,8 @@ static int __init serio_init(void)
 
 static void __exit serio_exit(void)
 {
-	bus_unregister(&serio_bus);
 	kthread_stop(serio_task);
+	bus_unregister(&serio_bus);
 }
 
 subsys_initcall(serio_init);

--------------070507060901030101080602--
