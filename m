Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135653AbRDXOfT>; Tue, 24 Apr 2001 10:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135654AbRDXOfJ>; Tue, 24 Apr 2001 10:35:09 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:44806 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S135653AbRDXOfE>;
	Tue, 24 Apr 2001 10:35:04 -0400
Date: Tue, 24 Apr 2001 16:35:09 +0200
From: Stephane List <stephane.list@fr.alcove.com>
To: linux-kernel@vger.kernel.org
Subject: Network driver: problem with insane (ported in 2.4.3)
Message-ID: <20010424163509.A32453@alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
X-Operating-System: Linux morgan 2.2.18
Organization: =?iso-8859-1?Q?Alc=F4ve=2C_l'informatique_est_libre?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Has anybody ported insane or snull from Rubini to kernel 2.4.3?

I'm porting Rubini's example: "insane".


/* --------------------------------------------------------------------------
 * definition of the "private" data structure used by this interface
 */
struct insane_private {
    struct net_device_stats priv_stats;
    struct net_device *priv_device; /* interface used to xmit data */
    int priv_mode; /* how to drop packets */
    int priv_arg1; /* arguments to the dropping mode */
    int priv_arg2;
};




int insane_open(struct net_device *dev)
{
    /* mark the device as operational */
/*    dev->start = 1;
    dev->tbusy = 0;*/
    netif_start_queue(dev);
    MOD_INC_USE_COUNT;
    return 0;
}
int insane_close(struct net_device *dev)
{
/*    dev->start = 0;
    dev->tbusy = 1;*/
    netif_stop_queue(dev);
    MOD_DEC_USE_COUNT;
    return 0;
}



int insane_xmit(struct sk_buff *skb, struct net_device *dev)
{

... /* state if the packet must be transmit or nor, and if it must */

    skb->dev = priv->priv_device;
    skb->priority = 1;
  printk("enqueue len=%d\n", skb->len); 
  {
          int ret = dev_queue_xmit (skb);
          printk("enqueue ret=%d\n", ret);
         }
    return 0;
}

Everything looks OK, dev_queue_xmit returns 0, but nothing comes back when I
ping through insane.

Has anybody ported insane or snull from Rubini to kernel 2.4.3?

Thanks a lot

Stephane

-- 
Stéphane LIST                     -- <stephane.list@fr.alcove.com>
Alcôve, liberating software       -- <http://www.alcove.com/>
