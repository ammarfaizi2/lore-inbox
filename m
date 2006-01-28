Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422797AbWA1CT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422797AbWA1CT7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422792AbWA1CTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:19:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:60600 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422793AbWA1CTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:19:09 -0500
Date: Fri, 27 Jan 2006 18:18:31 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       kaber@trash.net
Subject: [patch 5/6] [NETFILTER]: Fix crash in ip_nat_pptp (CVE-2006-0036)
Message-ID: <20060128021831.GF10362@kroah.com>
References: <20060128015840.722214000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="netfilter-fix-crash-in-ip_nat_pptp.patch"
In-Reply-To: <20060128021749.GA10362@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Patrick McHardy <kaber@trash.net>

When an inbound PPTP_IN_CALL_REQUEST packet is received the
PPTP NAT helper uses a NULL pointer in pointer arithmentic to
calculate the offset in the packet which needs to be mangled
and corrupts random memory or crashes.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/netfilter/ip_nat_helper_pptp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.6.orig/net/ipv4/netfilter/ip_nat_helper_pptp.c
+++ linux-2.6.14.6/net/ipv4/netfilter/ip_nat_helper_pptp.c
@@ -313,7 +313,7 @@ pptp_inbound_pkt(struct sk_buff **pskb,
 		break;
 	case PPTP_IN_CALL_REQUEST:
 		/* only need to nat in case PAC is behind NAT box */
-		break;
+		return NF_ACCEPT;
 	case PPTP_WAN_ERROR_NOTIFY:
 		pcid = &pptpReq->wanerr.peersCallID;
 		break;

--
