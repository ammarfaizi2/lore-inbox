Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265730AbUFDQzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265730AbUFDQzN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUFDQzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:55:13 -0400
Received: from [203.178.140.15] ([203.178.140.15]:18192 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S265730AbUFDQzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:55:01 -0400
Date: Sat, 05 Jun 2004 01:55:44 +0900 (JST)
Message-Id: <20040605.015544.102223977.yoshfuji@linux-ipv6.org>
To: terpstra@gkec.tu-darmstadt.de
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, davem@redhat.com,
       yoshfuji@linux-ipv6.org
Subject: Re: Broken? 2.6.6 + IP_ADD_SOURCE_MEMBERSHIP + SO_REUSEADDR
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040604155423.GA5656@muffin>
References: <20040604155423.GA5656@muffin>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040604155423.GA5656@muffin> (at Fri, 4 Jun 2004 17:54:23 +0200), "Wesley W. Terpstra" <terpstra@gkec.tu-darmstadt.de> says:

> If I launch the same program twice with different senders, the first program
> ceases to receive multicast packets. (Neither from its own sender, nor the
> second program's sender) The second program receives packets from its
> designated sender only (as expected).
:
> If both programs specify the same sender, then both programs receive the
> message (as expected).

Thanks for the report.
The following patch should fix the issue. Please try.
Thanks again.

===== net/ipv4/udp.c 1.60 vs edited =====
--- 1.60/net/ipv4/udp.c	2004-05-31 03:57:26 +09:00
+++ edited/net/ipv4/udp.c	2004-06-05 01:47:07 +09:00
@@ -294,7 +294,7 @@
 		    ipv6_only_sock(s)					||
 		    (s->sk_bound_dev_if && s->sk_bound_dev_if != dif))
 			continue;
-		if (!ip_mc_sf_allow(sk, loc_addr, rmt_addr, dif))
+		if (!ip_mc_sf_allow(s, loc_addr, rmt_addr, dif))
 			continue;
 		goto found;
   	}

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
