Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbTGCRbI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 13:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265085AbTGCRbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 13:31:08 -0400
Received: from freeside.toyota.com ([63.87.74.7]:61902 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP id S265079AbTGCRbG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 13:31:06 -0400
Message-ID: <3F046BB5.3040202@daveigh.net>
Date: Thu, 03 Jul 2003 10:45:25 -0700
From: Ring Fan <ringfan@daveigh.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Covici <covici@ccs.covici.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: local nntp connections much slower in 2.5.73 than in 2.4.x
References: <m3znjvbjft.fsf@ccs.covici.com>
In-Reply-To: <m3znjvbjft.fsf@ccs.covici.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Covici wrote:

>Hi.  I have been noticing an nntp problem in my 2.5.73 kernel.  I
>have inn 2.3 set up on my machine and I use gnus to read mail and
>news.  Now what happens is that when gnus starts up it connects to
>the server (same box) and gets all the active newsgroups.  What I
>have noticed is a drastic slowdown in 2.5.73 (or other 7x) than in my
>2.4.20 kernel and I was wondering if anyone else has seen this or can
>tell me either a workaround or what is going on with this.
>
Loopback interface has debugging code in current 2.5.x -

Does this patch speed things up?

diff -urN linux-2.5.66/drivers/net/loopback.c 
linux-2.5.66-faster/drivers/net/lo
opback.c
--- linux-2.5.66/drivers/net/loopback.c 2003-03-24 14:00:04.000000000 -0800
+++ linux-2.5.66-faster/drivers/net/loopback.c  2003-04-05 
10:15:00.000000000 -0
800
@@ -193,8 +193,8 @@
 
        /* Current netfilter will die with oom linearizing large skbs,
         * however this will be cured before 2.5.x is done.
-        */
        dev->features          |= NETIF_F_TSO;
+        */
 
        dev->priv = kmalloc(sizeof(struct net_device_stats), GFP_KERNEL);
        if (dev->priv == NULL)


