Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUGNUnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUGNUnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUGNUnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:43:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39666 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263725AbUGNUnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:43:17 -0400
Date: Wed, 14 Jul 2004 22:43:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Dominik Karall <dominik.karall@gmx.net>, Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: [patch] 2.6.8-rc1-mm1: 8139too: uninline rtl8139_start_thread
Message-ID: <20040714204309.GM7308@fs.tum.de>
References: <20040713182559.7534e46d.akpm@osdl.org> <200407142229.20241.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200407142229.20241.dominik.karall@gmx.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 10:29:18PM +0200, Dominik Karall wrote:
> On Wednesday 14 July 2004 03:25, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc1/2.6
> >.8-rc1-mm1/
> 
>   CC [M]  drivers/net/8139too.o
> drivers/net/8139too.c: In function `rtl8139_open':
> drivers/net/8139too.c:616: nicht implementiert: >>inline<< beim Aufruf von 
> >>rtl8139_start_thread<< gescheitert: function body not available
> drivers/net/8139too.c:1362: nicht implementiert: von hier aufgerufen
> make[3]: *** [drivers/net/8139too.o] Fehler 1
> make[2]: *** [drivers/net] Fehler 2
> make[1]: *** [drivers] Fehler 2
> make[1]: Verlasse Verzeichnis »/usr/src/linux-2.6.6«
> make: *** [stamp-build] Fehler 2
> 
> gcc 3.4

I should be fast at going through my gcc 3.4 TODO list...

Fix below.

> greets
> dominik

cu
Adrian


<--  snip  -->


uninline rtl8139_start_thread in drivers/net/8139too.c .


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm6-full-gcc3.4/drivers/net/8139too.c.old	2004-07-09 00:49:24.000000000 +0200
+++ linux-2.6.7-mm6-full-gcc3.4/drivers/net/8139too.c	2004-07-09 00:52:55.000000000 +0200
@@ -613,7 +613,7 @@
 static int mdio_read (struct net_device *dev, int phy_id, int location);
 static void mdio_write (struct net_device *dev, int phy_id, int location,
 			int val);
-static inline void rtl8139_start_thread(struct net_device *dev);
+static void rtl8139_start_thread(struct net_device *dev);
 static void rtl8139_tx_timeout (struct net_device *dev);
 static void rtl8139_init_ring (struct net_device *dev);
 static int rtl8139_start_xmit (struct sk_buff *skb,
@@ -1643,7 +1643,7 @@
 	complete_and_exit (&tp->thr_exited, 0);
 }
 
-static inline void rtl8139_start_thread(struct net_device *dev)
+static void rtl8139_start_thread(struct net_device *dev)
 {
 	struct rtl8139_private *tp = dev->priv;
 
