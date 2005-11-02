Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbVKBQys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbVKBQys (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbVKBQys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:54:48 -0500
Received: from agmk.net ([217.73.31.34]:1802 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S965134AbVKBQyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:54:47 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6.14] ipt_TARPIT vs sysctl_ip_default_ttl.
Date: Wed, 2 Nov 2005 17:54:41 +0100
User-Agent: KMail/1.8.3
Cc: netfilter-devel@lists.netfilter.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511021754.41694.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The ipt_TARPIT module uses sysctl_ip_default_ttl
variable but kernel doesn't export this symbol.

ipt_TARPIT.c:
(...)
        /* Adjust IP TTL */
#ifdef CONFIG_SYSCTL
        nskb->nh.iph->ttl = sysctl_ip_default_ttl;
#else
        nskb->nh.iph->ttl = IPDEFTTL;
#endif
(...)

Finally we get undefined symbol in TARPIT module.

--- linux-2.6.14/net/ipv4/ip_output.c.orig
+++ linux-2.6.14/net/ipv4/ip_output.c
@@ -1329,3 +1329,4 @@
 EXPORT_SYMBOL(ip_generic_getfrag);
 EXPORT_SYMBOL(ip_queue_xmit);
 EXPORT_SYMBOL(ip_send_check);
+EXPORT_SYMBOL(sysctl_ip_default_ttl);

-- 
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke
