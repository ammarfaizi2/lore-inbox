Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267504AbUH3I6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbUH3I6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 04:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267514AbUH3I6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 04:58:36 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:9740 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267504AbUH3I62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 04:58:28 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Peter Holik" <peter@holik.at>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: fix fealnx.c hangs on SMP, 2.4.27
Date: Mon, 30 Aug 2004 11:57:02 +0300
User-Agent: KMail/1.5.4
References: <38386.192.168.1.2.1093850895.squirrel@www.it-technology.at>
In-Reply-To: <38386.192.168.1.2.1093850895.squirrel@www.it-technology.at>
Cc: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       netdev@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408301157.03334.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 August 2004 10:28, Peter Holik wrote:
> static void set_rx_mode(struct net_device *dev)
> {
>    spinlock_t *lp = &((struct netdev_private *)dev->priv)->lock;
>    unsigned long flags;
>    spin_lock_irqsave(lp, flags);
>    __set_rx_mode(dev);
> -  spin_unlock_irqrestore(&lp, flags);
> +  spin_unlock_irqrestore(lp, flags);
> }

Oh... it was my change which was buggy... Thanks for the fix!

Jeff, 2.6 most probably has the same bug.
--
vda

