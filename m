Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbSKZMUn>; Tue, 26 Nov 2002 07:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSKZMUn>; Tue, 26 Nov 2002 07:20:43 -0500
Received: from mta2n.bluewin.ch ([195.186.4.220]:7618 "EHLO mta2n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S264711AbSKZMUm>;
	Tue, 26 Nov 2002 07:20:42 -0500
Date: Tue, 26 Nov 2002 13:27:30 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-ns83820@kvack.org
Subject: [PATCH][2.4/2.5] Fix ns83820 ioctl oops
Message-ID: <20021126122730.GA5484@k3.hellgate.ch>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, linux-ns83820@kvack.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.44 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Patch fixes the line mistaking a null pointer for an actual reference.
Also, to prevent this from happening again, the null pointer now is
replaced with the real one. Please apply.

Roger

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ns83820.c.diff"

--- drivers/net/ns83820.c.orig	Wed Nov 20 12:51:37 2002
+++ drivers/net/ns83820.c	Tue Nov 26 12:51:39 2002
@@ -1214,7 +1214,7 @@ static int ns83820_ethtool_ioctl (struct
 
 static int ns83820_ioctl(struct net_device *_dev, struct ifreq *rq, int cmd)
 {
-	struct ns83820 *dev = _dev->priv;
+	struct ns83820 *dev = (struct ns83820 *)_dev;
 
 	switch(cmd) {
 	case SIOCETHTOOL:
@@ -1788,6 +1788,7 @@ static int __devinit ns83820_init_one(st
 	dev->ee.cache = &dev->MEAR_cache;
 	dev->ee.lock = &dev->misc_lock;
 	dev->net_dev.owner = THIS_MODULE;
+	dev->net_dev.priv = dev;
 
 	PREPARE_TQUEUE(&dev->tq_refill, queue_refill, dev);
 	tasklet_init(&dev->rx_tasklet, rx_action, (unsigned long)dev);

--lrZ03NoBR/3+SXJZ--
