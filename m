Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbUAYAtO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 19:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbUAYAtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 19:49:14 -0500
Received: from dsl081-085-091.lax1.dsl.speakeasy.net ([64.81.85.91]:61569 "EHLO
	mrhankey.megahappy.net") by vger.kernel.org with ESMTP
	id S262714AbUAYAtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 19:49:12 -0500
Date: Sat, 24 Jan 2004 16:48:18 -0800 (PST)
From: Bryan Whitehead <driver@megahappy.net>
X-X-Sender: driver@mrhankey.homeip.net
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       tulip-users@lists.sourceforge.net
Subject: Re: [PATCH 2.6.2-rc1-mm2] drivers/net/tulip/tulip_core.c
In-Reply-To: <4012E0DA.7050808@pobox.com>
Message-ID: <Pine.LNX.4.58.0401241646240.32008@mrhankey.homeip.net>
References: <20040124080217.ED53113A354@mrhankey.megahappy.net>
 <4012E0DA.7050808@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You needed -p0 or I'm still on crack and don't know how to diff... Either 
way let me know...

This should work for patch -sp1:
--- linux-2.6.2-rc1-mm2/drivers/net/tulip/tulip_core.c.orig     2004-01-24 
16:41:06.799528688 -0800
+++ linux-2.6.2-rc1-mm2/drivers/net/tulip/tulip_core.c  2004-01-24 
16:40:14.521476160 -0800
@@ -246,21 +246,23 @@
 static void tulip_tx_timeout(struct net_device *dev);
 static void tulip_init_ring(struct net_device *dev);
 static int tulip_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static int tulip_open(struct net_device *dev);
 static int tulip_close(struct net_device *dev);
 static void tulip_up(struct net_device *dev);
 static void tulip_down(struct net_device *dev);
 static struct net_device_stats *tulip_get_stats(struct net_device *dev);
 static int private_ioctl(struct net_device *dev, struct ifreq *rq, int 
cmd);
 static void set_rx_mode(struct net_device *dev);
+#ifdef CONFIG_NET_POLL_CONTROLLER
 static void poll_tulip(struct net_device *dev);
+#endif
  
  
 static void tulip_set_power_state (struct tulip_private *tp,
                                   int sleep, int snooze)
 {
        if (tp->flags & HAS_ACPI) {
                u32 tmp, newtmp;
                pci_read_config_dword (tp->pdev, CFDD, &tmp);
                newtmp = tmp & ~(CFDD_Sleep | CFDD_Snooze);
                if (sleep)


On Sat, 24 Jan 2004, Jeff Garzik wrote:

> Bryan Whitehead wrote:
> > This fixes a warning if CONFIG_NET_POLL_CONTROLLER is NOT set.
> > 
> > --- drivers/net/tulip/tulip_core.c.orig 2004-01-23 23:53:17.484261904 -0800
> > +++ drivers/net/tulip/tulip_core.c      2004-01-23 23:53:53.675759960 -0800
> > @@ -253,7 +253,9 @@
> >  static struct net_device_stats *tulip_get_stats(struct net_device *dev);
> >  static int private_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
> >  static void set_rx_mode(struct net_device *dev);
> > +#ifdef CONFIG_NET_POLL_CONTROLLER
> >  static void poll_tulip(struct net_device *dev);
> > +#endif
> 
> 
> Hum... doesn't apply here, and also it breaks my automated
> "patch -sp1 < patch" script :/
> 
> 

-- 
Bryan Whitehead
Email:driver@megahappy.net
WorkE:driver@jpl.nasa.gov
