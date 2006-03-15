Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWCOGoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWCOGoM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 01:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWCOGoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 01:44:12 -0500
Received: from metis.starhub.net.sg ([203.117.3.21]:55344 "EHLO
	metis.starhub.net.sg") by vger.kernel.org with ESMTP
	id S1750811AbWCOGoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 01:44:10 -0500
X-SBRS: 3.5
X-HAT: Message received through Sender Group RELAYLIST,Policy $RELAYED applied.
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Date: Wed, 15 Mar 2006 14:44:01 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Re: Fix hostap_cs double kfree
In-reply-to: <20060315031422.GD9384@jm.kir.nu>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Jouni Malinen <jkmaline@cc.hut.fi>
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060315064401.GA12284@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
References: <20060315023900.GA8179@eugeneteo.net>
 <20060315031422.GD9384@jm.kir.nu>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Jouni Malinen">
> On Wed, Mar 15, 2006 at 10:39:00AM +0800, Eugene Teo wrote:
> > prism2_config() kfree's twice if kmalloc fails.
> > 
> > Coverity bug #930
> 
> Thanks. I'm going through the issues related to Host AP driver in
> Coverity database and send a set of patches after some testing.

Ok, here's a resend. Thanks.

Eugene

--
prism2_config() kfree's twice if kmalloc fails.

Coverity bug #930

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/drivers/net/wireless/hostap/hostap_cs.c~	2006-03-15 10:05:36.000000000 +0800
+++ linux-2.6/drivers/net/wireless/hostap/hostap_cs.c	2006-03-15 14:38:54.000000000 +0800
@@ -585,8 +585,6 @@
 	parse = kmalloc(sizeof(cisparse_t), GFP_KERNEL);
 	hw_priv = kmalloc(sizeof(*hw_priv), GFP_KERNEL);
 	if (parse == NULL || hw_priv == NULL) {
-		kfree(parse);
-		kfree(hw_priv);
 		ret = -ENOMEM;
 		goto failed;
 	}

-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }
