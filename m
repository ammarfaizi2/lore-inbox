Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262209AbSJZQEN>; Sat, 26 Oct 2002 12:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262218AbSJZQEN>; Sat, 26 Oct 2002 12:04:13 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:45572 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S262209AbSJZQEM>; Sat, 26 Oct 2002 12:04:12 -0400
Date: Sun, 27 Oct 2002 01:10:25 +0900 (JST)
Message-Id: <20021027.011025.86893867.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: usagi@linux-ipv6.org
Subject: [PATCH] IPv6: Fix for Refine IPv6 Address Validation Timer
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We sent a patch to refine timing of IPv6 address validation timer.
However, timer was not recalculated on receipt of RA.
This patch fixes this bug.

Patch is for 2.4.20-pre11.

Thanks.

Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.26.1
diff -u -r1.1.1.2 -r1.1.1.2.26.1
--- net/ipv6/addrconf.c	9 Oct 2002 01:35:53 -0000	1.1.1.2
+++ net/ipv6/addrconf.c	26 Oct 2002 15:55:14 -0000	1.1.1.2.26.1
@@ -947,6 +947,7 @@
 				ipv6_ifa_notify((flags&IFA_F_DEPRECATED) ?
 						0 : RTM_NEWADDR, ifp);
 			in6_ifa_put(ifp);
+			addrconf_verify(0);
 		}
 	}
 	in6_dev_put(in6_dev);

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
