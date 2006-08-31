Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWHaKES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWHaKES (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWHaKER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:04:17 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:25363 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750788AbWHaKER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:04:17 -0400
Date: Thu, 31 Aug 2006 18:59:21 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: David Miller <davem@davemloft.net>
Subject: [PATCH] rate limiting for socket allocation failure messages
Message-ID: <20060831095921.GA13845@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Resending due to local mail server trouble)

This patch limits the warning messages when socket allocation
failures happen. It happens under memory pressure.

Cc: David Miller <davem@davemloft.net>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 net/socket.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: work-shouldfail/net/socket.c
===================================================================
--- work-shouldfail.orig/net/socket.c
+++ work-shouldfail/net/socket.c
@@ -1178,7 +1178,8 @@ static int __sock_create(int family, int
  */
 
 	if (!(sock = sock_alloc())) {
-		printk(KERN_WARNING "socket: no more sockets\n");
+		if (net_ratelimit())
+			printk(KERN_WARNING "socket: no more sockets\n");
 		err = -ENFILE;		/* Not exactly a match, but its the
 					   closest posix thing */
 		goto out;
