Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUHBN7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUHBN7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUHBN7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:59:21 -0400
Received: from [203.178.140.15] ([203.178.140.15]:28681 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S265237AbUHBN7Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:59:16 -0400
Date: Mon, 02 Aug 2004 06:59:40 -0700 (PDT)
Message-Id: <20040802.065940.86004622.yoshfuji@linux-ipv6.org>
To: suckfish@ihug.co.nz
Cc: davem@redhat.com, pekkas@netcore.fi, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org, netdev@oss.sgi.com
Subject: Re: [PATCH] Trivial ipv6 fix.
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1091434328.16469.5.camel@localhost.localdomain>
References: <1091434328.16469.5.camel@localhost.localdomain>
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

In article <1091434328.16469.5.camel@localhost.localdomain> (at Mon, 02 Aug 2004 20:12:08 +1200), Ralph Loader <suckfish@ihug.co.nz> says:

> ipv6_addr_hash doesn't do what it's comment says.  The comment was
> probably what was intended, not that it'll make much difference in
> practice.

Oops, David, please apply this.

> Signed-off-by: Ralph Loader <suckfish@ihug.co.nz>
Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

===== include/net/addrconf.h 1.17 vs edited =====
--- 1.17/include/net/addrconf.h	2004-07-29 02:00:50 +09:00
+++ edited/include/net/addrconf.h	2004-08-02 22:57:38 +09:00
@@ -178,8 +178,8 @@
 	 * This will include the IEEE address token on links that support it.
 	 */
 
-	word = addr->s6_addr[2] ^ addr->s6_addr32[3];
-	word  ^= (word>>16);
+	word = addr->s6_addr32[2] ^ addr->s6_addr32[3];
+	word ^= (word >> 16);
 	word ^= (word >> 8);
 
 	return ((word ^ (word >> 4)) & 0x0f);

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
