Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292588AbSCGDxX>; Wed, 6 Mar 2002 22:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292554AbSCGDxN>; Wed, 6 Mar 2002 22:53:13 -0500
Received: from ppp77-4-71.miem.edu.ru ([194.226.32.71]:9344 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S291081AbSCGDxA>;
	Wed, 6 Mar 2002 22:53:00 -0500
Message-ID: <3C86E2E7.3080300@yahoo.com>
Date: Thu, 07 Mar 2002 06:47:51 +0300
From: Stas Sergeev <stssppnn@yahoo.com>
Reply-To: stas.orel@mailcity.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: twaugh@redhat.com
Subject: Re: [BUG] 2.4.18-pre/rc broke PLIP
Content-Type: multipart/mixed;
 boundary="------------060602040100010805050307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060602040100010805050307
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Tim Waugh wrote:
> Does 2.4.19-pre2 not work for you?

I had the similar problem with plip at 2.4.18
and 2.4.19-pre2 seems to fix it for me (though
I have seen a comments that it doesn't work for
others).
But I had another problem with plip for years,
which was not fixed by 2.4.19-pre2:
if I do `ifdown plip0` and then `ifup plip0`,
plip no longer works and the kernel logs timeouts,
just like in 2.4.18.
To work around the problem I removed "DISABLE(dev-irq);"
from plip_close(), and it works nice since.
So, if you are already on this, could you please
look at the attached "patch" and make a real fix
(if this is not the one already)?

--------------060602040100010805050307
Content-Type: text/plain;
 name="plip.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="plip.diff"

--- linux/drivers/net/plip.c	Sun Sep 30 23:26:07 2001
+++ linux/drivers/net/plip.c	Thu Mar  7 02:47:43 2002
@@ -163,7 +163,7 @@
 static int plip_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
 static int plip_preempt(void *handle);
 static void plip_wakeup(void *handle);
-
+
 enum plip_connection_state {
 	PLIP_CN_NONE=0,
 	PLIP_CN_RECEIVE,
@@ -1177,7 +1177,6 @@
 	struct plip_local *rcv = &nl->rcv_data;
 
 	netif_stop_queue (dev);
-	DISABLE(dev->irq);
 	synchronize_irq();
 
 	if (dev->irq == -1)

--------------060602040100010805050307--

