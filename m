Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUCFVxv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 16:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbUCFVxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 16:53:50 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:13573 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261723AbUCFVxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 16:53:49 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: typo in net/fc/iph5526.c ?
Date: Sat, 6 Mar 2004 23:33:51 +0200
User-Agent: KMail/1.5.4
Cc: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403062333.51306.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

static int __init fcdev_init(struct net_device *dev)
{
        SET_MODULE_OWNER(dev);
        dev->open = iph5526_open;
        dev->stop = iph5526_close;
        dev->hard_start_xmit = iph5526_send_packet;
        dev->get_stats = iph5526_get_stats;
        dev->set_multicast_list = NULL;
        dev->change_mtu = iph5526_change_mtu;
        dev->tx_timeout = iph5526_timeout;   <----
        dev->watchdog_timeo = 5*HZ;
        return 0;
}
...
static void iph5526_timeout(struct net_device *dev)
{
        struct fc_info *fi = (struct fc_info*)dev->priv;
        printk(KERN_WARNING "%s: timed out on send.\n", dev->name);
        fi->fc_stats.rx_dropped++;
                     ^^
        dev->trans_start = jiffies;
        netif_wake_queue(dev);
}

Shouldn't it be tx_dropped++ ?
--
vda

