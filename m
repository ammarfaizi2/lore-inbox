Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbRGPAV3>; Sun, 15 Jul 2001 20:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267140AbRGPAVT>; Sun, 15 Jul 2001 20:21:19 -0400
Received: from james.kalifornia.com ([208.179.59.2]:2111 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S267135AbRGPAVI>; Sun, 15 Jul 2001 20:21:08 -0400
Message-ID: <3B52335C.7040005@blue-labs.org>
Date: Sun, 15 Jul 2001 20:20:44 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010713
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <laughing@shared-source.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-ac4
In-Reply-To: <20010716004933.A18030@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Have you reviewed the patch I posted yesterday regarding net_dev_init() 
and double lock in sch_teql.c?

net_dev_init() is originally called in genhd.c, I don't see as it's 
necessary to call it again.

David

--- linux-2.4.6.orig/net/core/dev.c     Sat Jul 14 17:48:57 2001
+++ linux-2.4.6/net/core/dev.c  Wed Jun 20 21:00:55 2001
@@ -2405,6 +2401,9 @@
 #ifdef CONFIG_NET_FASTROUTE
        dev->fastpath_lock=RW_LOCK_UNLOCKED;
 #endif
-
-       if (dev_boot_phase)
-               net_dev_init();
 
 #ifdef CONFIG_NET_DIVERT
        ret = alloc_divert_blk(dev);


