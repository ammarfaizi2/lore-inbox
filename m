Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbUKCQUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUKCQUn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbUKCQUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:20:43 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:56580 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261681AbUKCQUe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:20:34 -0500
Date: Thu, 04 Nov 2004 01:21:28 +0900 (JST)
Message-Id: <20041104.012128.51410945.yoshfuji@linux-ipv6.org>
To: davem@davemloft.net, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, akpm@osdl.org,
       davem@davemloft.net, yoshfuji@linux-ipv6.org
Subject: Re: IPv6 dead in -bk11
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20041103.012923.102810732.yoshfuji@linux-ipv6.org>
References: <20041102.225343.06193184.yoshfuji@linux-ipv6.org>
	<4187A4E3.8010600@pobox.com>
	<20041103.012923.102810732.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041103.012923.102810732.yoshfuji@linux-ipv6.org> (at Wed, 03 Nov 2004 01:29:23 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

> So... I guess that kernel failed to add "default route" on receipt of RA.
> Right?
:

Sorry, this bug was introduced by my changeset:
<http://linux.bkbits.net:8080/linux-2.5/cset@417dca81tJ4RRAxhWTbn0p6hI-1XIQ>.

David, this should fix the issue.
Please apply.

D: Don't purge default routes by RA.
D:
D: Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

===== net/ipv6/ndisc.c 1.103 vs edited =====
--- 1.103/net/ipv6/ndisc.c	2004-10-26 12:55:42 +09:00
+++ edited/net/ipv6/ndisc.c	2004-11-04 01:05:19 +09:00
@@ -1078,13 +1078,6 @@
 			return;
 		}
 		neigh->flags |= NTF_ROUTER;
-
-		/*
-		 *	If we where using an "all destinations on link" route
-		 *	delete it
-		 */
-
-		rt6_purge_dflt_routers();
 	}
 
 	if (rt)

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
