Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267614AbUIOWRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbUIOWRt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUIOWPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:15:31 -0400
Received: from ozlabs.org ([203.10.76.45]:39912 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267649AbUIOWLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:11:21 -0400
Subject: [PATCH] ip_nat_ftp doesn't register any ports by default.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: netfilter-devel@lists.netfilter.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095286006.1940.5.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 16 Sep 2004 08:07:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply ASAP.  This would be embarrassing: ip_nat_ftp broke
in recent conversion to module_param_array().

Name: Fix ip_nat_ftp registration when no ports= arg
Status: Trivial
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

FTP NAT module doesn't register anything with no args.  Oops.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6124-linux-2.6.9-rc2-bk2/net/ipv4/netfilter/ip_nat_ftp.c .6124-linux-2.6.9-rc2-bk2.updated/net/ipv4/netfilter/ip_nat_ftp.c
--- .6124-linux-2.6.9-rc2-bk2/net/ipv4/netfilter/ip_nat_ftp.c	2004-09-16 00:17:16.000000000 +1000
+++ .6124-linux-2.6.9-rc2-bk2.updated/net/ipv4/netfilter/ip_nat_ftp.c	2004-09-16 08:05:38.000000000 +1000
@@ -297,7 +297,7 @@ static int __init init(void)
 	char *tmpname;
 
 	if (ports_c == 0)
-		ports[ports_c] = FTP_PORT;
+		ports[ports_c++] = FTP_PORT;
 
 	for (i = 0; i < ports_c; i++) {
 		ftp[i].tuple.dst.protonum = IPPROTO_TCP;

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

