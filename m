Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbTEYO6O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 10:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTEYO6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 10:58:14 -0400
Received: from mail-3.tiscali.it ([195.130.225.149]:13481 "EHLO
	mail-3.tiscali.it") by vger.kernel.org with ESMTP id S262820AbTEYO6M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 10:58:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniele Bellucci <bellucda@tiscali.it> (by way of Daniele Bellucci
	<danielebellucci@libero.it>)
Subject: Re: [linux-usb-devel] replaced BKL in rio500.c [2.5.69]
Date: Sun, 25 May 2003 17:11:20 +0200
User-Agent: KMail/1.4.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305251711.20197.danielebellucci@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

..sorry, this one is correct.


--- linux-2.5.69/drivers/usb/misc/rio500.c       2003-05-26
 16:23:20.000000000 +0200 +++ linux-2.5.69-new/drivers/usb/misc/rio500.c 
 2003-05-26 16:24:36.000000000 +0200 @@ -23,6 +23,9 @@
  *
  * Based upon mouse.c (Brad Keryan) and printer.c (Michael Gee).
  *
+ * Changelog:
+ * 25/05/03  replaced lock/unlock_kernel with up/down in open_rio.
+ *           Daniele Bellucci (bellucda@tiscali.it)
  * */

 #include <linux/module.h>
@@ -81,17 +84,17 @@
 {
        struct rio_usb_data *rio = &rio_instance;

-       lock_kernel();
+       down(&(rio->lock));

        if (rio->isopen || !rio->present) {
-               unlock_kernel();
+               up(&(rio->lock));
                return -EBUSY;
        }
        rio->isopen = 1;

        init_waitqueue_head(&rio->wait_q);

-       unlock_kernel();
+       up(&(rio->lock));

        info("Rio opened.");




-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
--- PGP PKEY     
 http://pgp.mit.edu:11371/pks/lookup?search=belch76@libero.it&op=index ICQ#  
             104896040
Netphone/Fax  178.605.7063
Homepage       http://web.tiscali.it/bellucda
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
---

Daniele Bellucci

