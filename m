Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVCKVKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVCKVKx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 16:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVCKVKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 16:10:51 -0500
Received: from khc.piap.pl ([195.187.100.11]:3844 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261468AbVCKVKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 16:10:11 -0500
To: Chris Wright <chrisw@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: Linux 2.6.11.2
References: <20050309083923.GA20461@kroah.com>
	<m3acpa9qta.fsf@defiant.localdomain>
	<20050311173808.GZ28536@shell0.pdx.osdl.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 11 Mar 2005 22:07:55 +0100
In-Reply-To: <20050311173808.GZ28536@shell0.pdx.osdl.net> (Chris Wright's
 message of "Fri, 11 Mar 2005 09:38:08 -0800")
Message-ID: <m3acp9rivo.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> * Krzysztof Halasa (khc@pm.waw.pl) wrote:
>> Another patch for 2.6.11.x: already in main tree, fixes kernel panic
>> on receive with WAN cards based on Hitachi SCA/SCA-II: N2, C101,
>> PCI200SYN.
>> Also a documentation change fixing user-panic can-t-find-required-software
>> failure (just the same patch as in mainline) :-)
>
> We are not accepting documentation fixes.  Could you please send just
> the panic fix to stable@kernel.org (cc lkml)?  And add Signed-off-by...

Sure:

Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>

--- linux/drivers/net/wan/hd6457x.c	28 Oct 2004 06:16:08 -0000	1.15
+++ linux/drivers/net/wan/hd6457x.c	1 Mar 2005 00:58:08 -0000
@@ -315,7 +315,7 @@
 #endif
 	stats->rx_packets++;
 	stats->rx_bytes += skb->len;
-	skb->dev->last_rx = jiffies;
+	dev->last_rx = jiffies;
 	skb->protocol = hdlc_type_trans(skb, dev);
 	netif_rx(skb);
 }

-- 
Krzysztof Halasa
