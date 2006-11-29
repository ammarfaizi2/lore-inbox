Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758222AbWK2WBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758222AbWK2WBg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758244AbWK2WBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:01:36 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:44465 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758222AbWK2WBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:01:35 -0500
Message-Id: <20061129220322.878392000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:14 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Patrick McHardy <kaber@trash.net>,
       davem@davemloft.net, Vasily Averin <vvs@openvz.org>,
       Dmitry Mishin <dim@openvz.org>, Kirill Korotaev <dev@openvz.org>
Subject: [patch 03/23] NETFILTER: ip_tables: compat error way cleanup
Content-Disposition: inline; filename=netfilter-ip_tables-compat-error-way-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Patrick McHardy <kaber@trash.net>

This patch adds forgotten compat_flush_offset() call to error way of
translate_compat_table().  May lead to table corruption on the next
compat_do_replace().

Signed-off-by: Vasily Averin <vvs@openvz.org>
Acked-by: Dmitry Mishin <dim@openvz.org>
Acked-by: Kirill Korotaev <dev@openvz.org>
Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
commit efb1447a67abac93048ad7af0c59cd9b5a9177a6
tree 9d56a6e758a3ad0e617f2527ac4b4efdeba5b64a
parent 4410392a8258fd972fc08a336278b14c82b2774f
author Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 06:22:39 +0100
committer Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 06:22:39 +0100

 net/ipv4/netfilter/ip_tables.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.18.4.orig/net/ipv4/netfilter/ip_tables.c
+++ linux-2.6.18.4/net/ipv4/netfilter/ip_tables.c
@@ -1775,6 +1775,7 @@ free_newinfo:
 out:
 	return ret;
 out_unlock:
+	compat_flush_offsets();
 	xt_compat_unlock(AF_INET);
 	goto out;
 }

--
