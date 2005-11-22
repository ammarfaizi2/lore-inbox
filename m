Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbVKVVKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbVKVVKX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbVKVVKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:10:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44447 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965198AbVKVVKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:10:02 -0500
Date: Tue, 22 Nov 2005 13:08:13 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Harald Welte <laforge@netfilter.org>, Vlad Drukker <vlad@storewiz.com>
Subject: [patch 14/23] [PATCH] [NETFILTER] ip_conntrack TCP: Accept SYN+PUSH like SYN
Message-ID: <20051122210813.GO28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ip_conntrack-tcp-accept-syn+push-like-syn.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Some devices (e.g. Qlogic iSCSI HBA hardware like QLA4010 up to firmware
3.0.0.4) initiates TCP with SYN and PUSH flags set.

The Linux TCP/IP stack deals fine with that, but the connection tracking
code doesn't.

This patch alters TCP connection tracking to accept SYN+PUSH as a valid
flag combination.

Signed-off-by: Vlad Drukker <vlad@storewiz.com>
Signed-off-by: Harald Welte <laforge@netfilter.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/netfilter/ip_conntrack_proto_tcp.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.14.2.orig/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
+++ linux-2.6.14.2/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
@@ -818,6 +818,7 @@ static u8 tcp_valid_flags[(TH_FIN|TH_SYN
 {
 	[TH_SYN]			= 1,
 	[TH_SYN|TH_ACK]			= 1,
+	[TH_SYN|TH_PUSH]		= 1,
 	[TH_SYN|TH_ACK|TH_PUSH]		= 1,
 	[TH_RST]			= 1,
 	[TH_RST|TH_ACK]			= 1,

--
