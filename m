Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbUJYAOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbUJYAOs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 20:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbUJYANT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 20:13:19 -0400
Received: from [203.2.177.22] ([203.2.177.22]:65031 "EHLO pinot.tusc.com.au")
	by vger.kernel.org with ESMTP id S261637AbUJYAMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 20:12:54 -0400
Subject: [PATCH TRIVIAL 2.6.8.1] X.25 : Stop /proc/net/x25/route infinitely
	reading
From: Andrew Hendry <ahendry@tusc.com.au>
To: linux-x25@vger.kernel.org, eis@baty.hanse.de
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1098663048.3099.166.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 25 Oct 2004 10:10:48 +1000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Oct 2004 00:13:27.0546 (UTC) FILETIME=[73613DA0:01C4BA27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem:
route add --x25 0/0 eth0
cat /proc/net/x25/route
reads the single routing entry forever.

This patch makes x25_get_route_idx behave the same as x25_get_socket_idx
which works correctly.

Signed-off-by: Andrew Hendry <ahendry@tusc.com.au>

Andrew.

diff -up linux-2.6.8.1/net/x25/x25_proc.c.orig
linux-2.6.8.1/net/x25/x25_proc.c
--- linux-2.6.8.1/net/x25/x25_proc.c.orig       2004-10-25
09:27:58.600069976 +1000
+++ linux-2.6.8.1/net/x25/x25_proc.c    2004-10-25 09:29:30.079163040
+1000
@@ -32,10 +32,11 @@ static __inline__ struct x25_route *x25_
  
        list_for_each(route_entry, &x25_route_list) {
                rt = list_entry(route_entry, struct x25_route, node);
-               if (--pos)
-                       break;
+               if (!pos--)
+                       goto found;
        }
-
+       rt = NULL;
+found:
        return rt;
 }

