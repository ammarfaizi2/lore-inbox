Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVF2KrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVF2KrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 06:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVF2KrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 06:47:08 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:19648 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262503AbVF2KrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 06:47:04 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: dev_kfree_skb[_irq,_any] usage rules
Date: Wed, 29 Jun 2005 13:46:28 +0300
User-Agent: KMail/1.5.4
Cc: "David S. Miller" <davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506291346.28142.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have this hard_start_xmit code (simplified):

int start_xmit(struct sk_buff *skb, netdevice_t * dev)
{
        struct mydevice *priv = acx_netdev_priv(dev);

        if (!skb) goto end;
        if (!priv) goto end;

        /* there is no one to talk to */
        if (priv->status != ACX_STATUS_4_ASSOCIATED) {
                printk("start_xmit() called but not associated yet\n");
                /* silently drop the packet, since we're not connected yet */
                dev_kfree_skb(skb);
                priv->stats.tx_errors++;
                goto end;
        }
	...
}

Should I use dev_kfree_skb(skb) here or dev_kfree_skb_irq(skb)?
(IIRC hard_start_xmit is in atomic context, no?)

There is also a dev_kfree_skb_any(skb). What are the rules?
--
vda

