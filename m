Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbTJPKxW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbTJPKxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:53:22 -0400
Received: from [212.239.226.164] ([212.239.226.164]:15488 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S262836AbTJPKxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:53:18 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test7] b44: NETDEV WATCHDOG: eth0: transmit timed out
Date: Thu, 16 Oct 2003 12:53:06 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310161253.13548.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Same bug as in 2.4:

Oct 16 12:29:14 precious kernel: NETDEV WATCHDOG: eth0: transmit timed out
Oct 16 12:29:14 precious kernel: b44: eth0: transmit timed out, resetting

after which the interface is useless.

Can the same patch (by  Pekka Pietikainen) be applied?

http://marc.theaimsgroup.com/?l=linux-kernel&m=106476776914551&w=2

- --------------------------

- --- b44.c.orig  2003-09-28 19:36:48.000000000 +0300
+++ b44.c       2003-09-28 19:37:07.000000000 +0300
@@ -870,6 +870,7 @@

        spin_unlock_irq(&bp->lock);

+       b44_enable_ints(bp);
        netif_wake_queue(dev);
 }



Thanks.

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jniXUQQOfidJUwQRAkMQAJ4nV5lDO92ldXRxEQuJn38Wb0tIOACeKwL9
7ue+PvQFtVg6GIWn0aQXjyY=
=aclj
-----END PGP SIGNATURE-----

