Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbVKVVJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbVKVVJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbVKVVJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:09:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2207 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965189AbVKVVIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:08:49 -0500
Date: Tue, 22 Nov 2005 13:07:51 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Harald Welte <laforge@netfilter.org>,
       Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [patch 11/23] [PATCH] [NETFILTER] ctnetlink: check if protoinfo is present
Message-ID: <20051122210751.GL28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ctnetlink-check-if-protoinfo-is-present.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This fixes an oops triggered from userspace. If we don't pass information
about the private protocol info, the reference to attr will be NULL. This is
likely to happen in update messages.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Harald Welte <laforge@netfilter.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/netfilter/ip_conntrack_proto_tcp.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.14.2.orig/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
+++ linux-2.6.14.2/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
@@ -362,6 +362,11 @@ static int nfattr_to_tcp(struct nfattr *
 	struct nfattr *attr = cda[CTA_PROTOINFO_TCP-1];
 	struct nfattr *tb[CTA_PROTOINFO_TCP_MAX];
 
+	/* updates could not contain anything about the private
+	 * protocol info, in that case skip the parsing */
+	if (!attr)
+		return 0;
+
         if (nfattr_parse_nested(tb, CTA_PROTOINFO_TCP_MAX, attr) < 0)
                 goto nfattr_failure;
 

--
