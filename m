Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWGYHiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWGYHiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 03:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWGYHiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 03:38:08 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:4879 "EHLO
	www262.sakura.ne.jp") by vger.kernel.org with ESMTP
	id S1751387AbWGYHiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 03:38:07 -0400
Message-Id: <200607250738.k6P7c67G089452@www262.sakura.ne.jp>
Subject: [PATCH][IPv4/IPv6] Setting 0 for unused port field.
From: from-linux-kernel@i-love.sakura.ne.jp
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Jul 2006 16:38:05 +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

The recvmsg() for raw socket seems to return random u16 value
from the kernel stack memory since port field is not initialized.
But I'm not sure this patch is correct.
Does raw socket return any information stored in port field?

---------- Start of patch ----------
diff -ur before/net/ipv4/raw.c after/net/ipv4/raw.c
--- before/net/ipv4/raw.c       2006-06-18 10:49:35.000000000 +0900
+++ after/net/ipv4/raw.c        2006-07-25 16:15:26.000000000 +0900
@@ -609,6 +609,7 @@
        if (sin) {
                sin->sin_family = AF_INET;
                sin->sin_addr.s_addr = skb->nh.iph->saddr;
+               sin->sin_port = 0;
                memset(&sin->sin_zero, 0, sizeof(sin->sin_zero));
        }
        if (inet->cmsg_flags)
diff -ur before/net/ipv6/raw.c after/net/ipv6/raw.c
--- before/net/ipv6/raw.c       2006-06-18 10:49:35.000000000 +0900
+++ after/net/ipv6/raw.c        2006-07-25 16:16:52.000000000 +0900
@@ -411,6 +411,7 @@
        /* Copy the address. */
        if (sin6) {
                sin6->sin6_family = AF_INET6;
+               sin6->sin6_port = 0;
                ipv6_addr_copy(&sin6->sin6_addr, &skb->nh.ipv6h->saddr);
                sin6->sin6_flowinfo = 0;
                sin6->sin6_scope_id = 0;
---------- End of patch ----------

Regards.
