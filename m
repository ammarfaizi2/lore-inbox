Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135593AbREEXaM>; Sat, 5 May 2001 19:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135594AbREEXaD>; Sat, 5 May 2001 19:30:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39831 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135593AbREEX3n>;
	Sat, 5 May 2001 19:29:43 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15092.36065.805800.935258@pizda.ninka.net>
Date: Sat, 5 May 2001 16:29:37 -0700 (PDT)
To: kernel@stirfried.vegetable.org.uk (Tim Haynes)
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: ipv6 activity causing system hang in kernel 2.4.4
In-Reply-To: <871yq3mllw.fsf@straw.pigsty.org.uk>
In-Reply-To: <871yq3mllw.fsf@straw.pigsty.org.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try this patch, posted the other day.  I bet if you inspected,
you'd find OOPSes in your logs:

--- ../vanilla/linux/net/ipv6/ndisc.c	Thu Apr 26 22:17:26 2001
+++ net/ipv6/ndisc.c	Fri May  4 18:44:54 2001
@@ -394,7 +382,7 @@
 	int send_llinfo;
 
 	len = sizeof(struct icmp6hdr) + sizeof(struct in6_addr);
-	send_llinfo = dev->addr_len && ipv6_addr_type(saddr) != IPV6_ADDR_ANY;
+	send_llinfo = dev->addr_len && saddr && ipv6_addr_type(saddr) != IPV6_ADDR_ANY;
 	if (send_llinfo)
 		len += NDISC_OPT_SPACE(dev->addr_len);
 
