Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265117AbUFRLgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUFRLgc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 07:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUFRLgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 07:36:32 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:54284 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265117AbUFRLg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 07:36:29 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: vitalyvb@ukr.net (Vitaly V. Bursov)
Subject: Re: linux-2.6.7 Equalizer Load-balancer.  eql.c. local non-privileged DoS
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, davem@redhat.com,
       jgarzik@pobox.com, netdev@oss.sgi.com
Organization: Core
In-Reply-To: <20040618115153.3ad2dc32.vitalyvb@ukr.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BbHeo-00053Z-00@gondolin.me.apana.org.au>
Date: Fri, 18 Jun 2004 21:35:42 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly V. Bursov <vitalyvb@ukr.net> wrote:
> 
> there are multiple vulns in drivers/net/eql.c
> 
> if there is no such device, dev_get_by_name returns NULL and everything dies.
> Exploiting this is trivial.

Thanks for the report.  This patch should fix them.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
===== drivers/net/eql.c 1.13 vs edited =====
--- 1.13/drivers/net/eql.c	2004-06-05 01:50:36 +10:00
+++ edited/drivers/net/eql.c	2004-06-18 21:30:49 +10:00
@@ -497,6 +497,8 @@
 	slave_dev = dev_get_by_name(sc.slave_name);
 
 	ret = -EINVAL;
+	if (!slave_dev)
+		return ret;
 
 	spin_lock_bh(&eql->queue.lock);
 	if (eql_is_slave(slave_dev)) {
@@ -531,6 +533,8 @@
 	slave_dev = dev_get_by_name(sc.slave_name);
 
 	ret = -EINVAL;
+	if (!slave_dev)
+		return ret;
 
 	spin_lock_bh(&eql->queue.lock);
 	if (eql_is_slave(slave_dev)) {
