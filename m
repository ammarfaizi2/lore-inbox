Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271009AbTGPKwA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271010AbTGPKvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:51:54 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:50953 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S271009AbTGPKvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:51:49 -0400
Date: Wed, 16 Jul 2003 20:07:28 +0900 (JST)
Message-Id: <20030716.200728.47761016.yoshfuji@linux-ipv6.org>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       yoshfuji@linux-ipv6.org, davem@redhat.com
Subject: Re: IPv6 warnings
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030716113657.A24009@flint.arm.linux.org.uk>
References: <20030716113657.A24009@flint.arm.linux.org.uk>
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

Hello.

In article <20030716113657.A24009@flint.arm.linux.org.uk> (at Wed, 16 Jul 2003 11:36:57 +0100), Russell King <rmk@arm.linux.org.uk> says:

> Linux version 2.6.0-test1 (src@tika) (gcc version 3.2.2 20030313
>  (Red Hat Linux 3.2.2-10_rmk1)) #1280 Wed Jul 16 11:07:22 BST 2003
> CPU: StrongARM-1110 [6901b118] revision 8 (ARMv4)
> 
> I'm running IPv6 the above, and I'm seeing the following messages.
> ipv6 was built as a module.  Should I be worried?
> 
> IPv6 v0.8 for NET4.0
> IPv6 over IPv4 tunneling driver
> Destroying alive neighbour c18c2a44
> [<c015bb84>] (dst_destroy+0x0/0x168) from [<bf00d024>] (ndisc_dst_gc+0x74/0xa4 [ipv6])

Please try this.

Index: linux-2.6/net/ipv6/route.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv6/route.c,v
retrieving revision 1.45
diff -u -r1.45 route.c
--- linux-2.6/net/ipv6/route.c	13 Jul 2003 06:12:30 -0000	1.45
+++ linux-2.6/net/ipv6/route.c	16 Jul 2003 09:44:39 -0000
@@ -567,6 +567,11 @@
 	if (unlikely(rt == NULL))
 		goto out;
 
+	if (dev)
+		dev_hold(dev);
+	if (neigh)
+		neigh_hold(neigh);
+
 	rt->rt6i_dev	  = dev;
 	rt->rt6i_nexthop  = neigh;
 	rt->rt6i_expires  = 0;

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
