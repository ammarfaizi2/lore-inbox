Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbTDIGc5 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 02:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTDIGc5 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 02:32:57 -0400
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:1408 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP id S262853AbTDIGcz (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 02:32:55 -0400
Date: Wed, 9 Apr 2003 15:42:31 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH 2.5.67] Trivial for ip_amanda_lock
Message-ID: <20030409064231.GA876@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SMP=y and CONFIG_IP_NF_AMANDA=m cause depmod error.
Here is a quick fix patch.

diff -Nru linux-2.5.67/net/ipv4/netfilter/ip_conntrack_amanda.c linux-2.5.67-quick-fix/net/ipv4/netfilter/ip_conntrack_amanda.c
--- linux-2.5.67/net/ipv4/netfilter/ip_conntrack_amanda.c	2003-04-05 10:06:24.000000000 +0900
+++ linux-2.5.67-quick-fix/net/ipv4/netfilter/ip_conntrack_amanda.c	2003-04-05 12:26:05.000000000 +0900
@@ -37,6 +37,7 @@
 MODULE_PARM_DESC(master_timeout, "timeout for the master connection");
 
 DECLARE_LOCK(ip_amanda_lock);
+EXPORT_SYMBOL(ip_amanda_lock);
 struct module *ip_conntrack_amanda = THIS_MODULE;
 
 #define MAXMATCHLEN	6

Regards,
Osamu Tomita <tomita@cinet.co.jp>

