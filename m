Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbUJYAOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbUJYAOt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 20:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUJYAN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 20:13:26 -0400
Received: from [203.2.177.22] ([203.2.177.22]:64775 "EHLO pinot.tusc.com.au")
	by vger.kernel.org with ESMTP id S261638AbUJYAMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 20:12:54 -0400
Subject: [PATCH TRIVIAL 2.6.8.1] X.25 : Stop x25_destroy_socket timer
	looping
From: Andrew Hendry <ahendry@tusc.com.au>
To: linux-x25@vger.kernel.org, eis@baty.hanse.de
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1098663044.3099.164.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 25 Oct 2004 10:10:44 +1000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Oct 2004 00:13:23.0609 (UTC) FILETIME=[71088090:01C4BA27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The sk_timer.data for the x.25 destroy_socket timer went missing at some
stage, causing a timer loop where x25_destroy_socket would keep setting
up timers to call itself.

Signed-off-by: Andrew Hendry <ahendry@tusc.com.au>


diff -up linux-2.6.8.1/net/x25/af_x25.c.orig
linux-2.6.8.1/net/x25/af_x25.c
--- linux-2.6.8.1/net/x25/af_x25.c.orig 2004-10-25 08:49:40.780391664
+1000
+++ linux-2.6.8.1/net/x25/af_x25.c      2004-10-25 09:08:22.797819088
+1000
@@ -347,6 +347,7 @@ void x25_destroy_socket(struct sock *sk)
                /* Defer: outstanding buffers */
                sk->sk_timer.expires  = jiffies + 10 * HZ;
                sk->sk_timer.function = x25_destroy_timer;
+               sk->sk_timer.data = (unsigned long)sk;
                add_timer(&sk->sk_timer);
        } else {
                /* drop last reference so sock_put will free */

