Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVA1Bdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVA1Bdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 20:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVA1Bdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 20:33:39 -0500
Received: from [62.206.217.67] ([62.206.217.67]:21926 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261370AbVA1Bdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 20:33:37 -0500
Message-ID: <41F99656.5040304@trash.net>
Date: Fri, 28 Jan 2005 02:33:10 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050106 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: David Brownell <david-b@pacbell.net>,
       jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, ahaas@airmail.net
Subject: Re: 2.6.11-rc2 TCP ignores PMTU ICMP (Re: Linux 2.6.11-rc2)
References: <200501232251.42394.david-b@pacbell.net>	<priv$1106815487.koan@shadow.banki.hu>	<200501271128.48411.david-b@pacbell.net>	<200501271511.58086.david-b@pacbell.net> <20050127154150.360f95e2.davem@davemloft.net>
In-Reply-To: <20050127154150.360f95e2.davem@davemloft.net>
Content-Type: multipart/mixed;
 boundary="------------070303040201060207090705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070303040201060207090705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:

>I've forwarded this to netfilter-devel for inspection.
>Thanks for collecting all the data points so well.
>
Here is the fix for everyone. Please report back if it doesn't
solve the problem. Thanks.



--------------070303040201060207090705
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

===== net/ipv4/netfilter/ip_nat_proto_tcp.c 1.10 vs edited =====
--- 1.10/net/ipv4/netfilter/ip_nat_proto_tcp.c	2005-01-17 23:00:55 +01:00
+++ edited/net/ipv4/netfilter/ip_nat_proto_tcp.c	2005-01-28 02:13:06 +01:00
@@ -105,7 +105,7 @@
 		return 0;
 
 	iph = (struct iphdr *)((*pskb)->data + iphdroff);
-	hdr = (struct tcphdr *)((*pskb)->data + iph->ihl*4);
+	hdr = (struct tcphdr *)((*pskb)->data + hdroff);
 
 	if (maniptype == IP_NAT_MANIP_SRC) {
 		/* Get rid of src ip and src pt */

--------------070303040201060207090705--
