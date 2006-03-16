Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752216AbWCPHK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbWCPHK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 02:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbWCPHK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 02:10:29 -0500
Received: from kbsmtao2.starhub.net.sg ([203.116.2.167]:46130 "EHLO
	kbsmtao2.starhub.net.sg") by vger.kernel.org with ESMTP
	id S1752216AbWCPHK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 02:10:29 -0500
Date: Thu, 16 Mar 2006 15:10:28 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Re: [PATCH] Hamradio: Fix a NULL pointer dereference in
 net/hamradio/6pack.c
In-reply-to: <20060316064637.GA22737@eugeneteo.net>
To: linux-kernel@vger.kernel.org
Cc: Thomas Osterried DL9SAU <thomas@x-berg.in-berlin.de>,
       Ralf Baechle DL5RB <ralf@linux-mips.org>,
       Hans Alblas PE1AYX <hans@esrac.ele.tue.nl>
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060316071028.GA22953@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
References: <20060316064637.GA22737@eugeneteo.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Eugene Teo">
> Pointer sp is dereferenced before NULL check.
> 
> Coverity bug #816
> 
> Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

Ignore the previous patch please. Here's a resend.

--
Pointer sp is dereferenced before NULL check.

Coverity bug #816

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/drivers/net/hamradio/6pack.c~	2006-03-15 10:05:35.000000000 +0800
+++ linux-2.6/drivers/net/hamradio/6pack.c	2006-03-16 15:08:43.000000000 +0800
@@ -727,12 +727,14 @@ static int sixpack_ioctl(struct tty_stru
 	unsigned int cmd, unsigned long arg)
 {
 	struct sixpack *sp = sp_get(tty);
-	struct net_device *dev = sp->dev;
+	struct net_device *dev;
 	unsigned int tmp, err;
 
 	if (!sp)
 		return -ENXIO;
 
+	dev = sp->dev;
+
 	switch(cmd) {
 	case SIOCGIFNAME:
 		err = copy_to_user((void __user *) arg, dev->name,

-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }

