Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261849AbSKCNKq>; Sun, 3 Nov 2002 08:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbSKCNKq>; Sun, 3 Nov 2002 08:10:46 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:23049 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261849AbSKCNKp>; Sun, 3 Nov 2002 08:10:45 -0500
Date: Sun, 03 Nov 2002 22:16:58 +0900 (JST)
Message-Id: <20021103.221658.52523847.yoshfuji@linux-ipv6.org>
To: kisza@securityaudit.hu
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, davem@redhat.com,
       kuznet@ms2.inr.ac.ru, usagi@linux-ipv6.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Functions Clean-up
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1036328414.1048.3.camel@arwen>
References: <20021103.115427.104445233.yoshfuji@linux-ipv6.org>
	<1036328414.1048.3.camel@arwen>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1036328414.1048.3.camel@arwen> (at Sun, 03 Nov 2002 14:00:14 +0100), Andras Kis-Szabo <kisza@securityaudit.hu> says:

> This patch removes one function from the Netfilter code and forces the
> Netfilter to use a similar function from the kernel's one!

net/ipv6/netfilter/ip6_queue.c says:

/*
 * Taken from net/ipv6/ip6_output.c
 * We should use the one there, but is defined static
 * so we put this just here and let the things as
 * they are now.
 *
 * If that one is modified, this one should be modified too.
 */

So, the reason why the copy of route6_me_harder() 
lives there is because net/ipv6/ip6_output.c has not been 
exported it.

Is this something to do with parser of extension headers?
Parser of extension headers is different thing, isn't it?

Yes, since duplication of code is bad unless there're really 
strong reasons.  I believe that there would be a better 
design for filtering.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
