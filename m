Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVE1TR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVE1TR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 15:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVE1TR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 15:17:57 -0400
Received: from smtpauth01.mail.atl.earthlink.net ([209.86.89.61]:64195 "EHLO
	smtpauth01.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261190AbVE1TRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 15:17:55 -0400
Message-ID: <4298C3DC.5040100@exmsft.com>
Date: Sat, 28 May 2005 21:17:48 +0200
From: Keith Moore <keithmo@exmsft.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Trivial module unload problem in 2.6.12-rc5[-mm1]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: bd47eb33e10cdf15d780f4a490ca69563f9fea00a6dd62bc0b5ca89ba715506c1f2e7d68f9a17464350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 83.16.113.74
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found a trivial module unload problem in the 2.6.12-rc5 and (-mm1)
kernels.

net/ipv4/multipath_drr.c can cause an oops soon after unloading. Its
module init routine calls multipath_alg_register() with the incorrect
IP_MP_ALG_RR value, but its module exit routine calls
multipath_alg_deregister() with the *correct* IP_MP_ALG_DRR value.

Easy fix:

--- linux-2.6.12-rc5-mm1/net/ipv4/multipath_drr.c.old	2005-05-28
15:03:24.000000000 +0200
+++ linux-2.6.12-rc5-mm1/net/ipv4/multipath_drr.c	2005-05-28
15:03:31.000000000 +0200
@@ -244,7 +244,7 @@ static int __init drr_init(void)
 	if (err)
 		return err;

-	err = multipath_alg_register(&drr_ops, IP_MP_ALG_RR);
+	err = multipath_alg_register(&drr_ops, IP_MP_ALG_DRR);
 	if (err)
 		goto fail;


Thanks,
KM

