Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbTDDOit (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 09:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263724AbTDDOiO (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 09:38:14 -0500
Received: from [61.11.16.46] ([61.11.16.46]:15372 "EHLO mailpune.cygnet.co.in")
	by vger.kernel.org with ESMTP id S263714AbTDDOaK (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 09:30:10 -0500
Subject: Re: Deactivating TCP checksumming
From: Abhishek Agrawal <abhishek@abhishek.agrawal.name>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3E8C9DDD.3080205@pobox.com>
References: <F91mkXMUIhAumscmKC00000f517@hotmail.com>
	<20030401122824.GY29167@mea-ext.zmailer.org> <b6fda2$oec$1@main.gmane.org>
	<20030402203653.GA2503@gtf.org> <b6fi8m$j4g$1@main.gmane.org>
	<20030402205855.GA4125@gtf.org> <b6i5t1$h0t$1@main.gmane.org>
	<3E8C9DDD.3080205@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Date: 04 Apr 2003 19:38:12 +0530
Message-Id: <1049465292.3352.31.camel@abhilinux.cygnet.co.in>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-04 at 02:17, Jeff Garzik wrote:

>
> CHECKSUM_HW is for receive, not transmit.  Read the comments at the top
> of include/linux/skbuff.h.
>
Actually CHECKSUM_HW can be set at either of the "producer" ends. At
least this is what I gather from  tcp_output.c

// tcp_output.c:454
if (!skb_shinfo(skb)->nr_frags && skb->ip_summed != CHECKSUM_HW) {
  //...
        }
else {
                skb->ip_summed = CHECKSUM_HW;
                skb_split(skb, buff, len);
     }

AND

//1014 dev.c:dev_queue_xmit()
        /* If packet is not checksummed and device does not support
         * checksumming for this protocol, complete checksumming here.
         */
        if (skb->ip_summed == CHECKSUM_HW &&
            (!(dev->features&(NETIF_F_HW_CSUM|NETIF_F_NO_CSUM)) &&
             (!(dev->features&NETIF_F_IP_CSUM) ||
              skb->protocol != htons(ETH_P_IP)))) {
                if ((skb = skb_checksum_help(skb)) == NULL)
                        return -ENOMEM;
        }



