Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268653AbTBZFrO>; Wed, 26 Feb 2003 00:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268656AbTBZFrO>; Wed, 26 Feb 2003 00:47:14 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:48646 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S268653AbTBZFrN>; Wed, 26 Feb 2003 00:47:13 -0500
Date: Wed, 26 Feb 2003 14:56:59 +0900 (JST)
Message-Id: <20030226.145659.39100680.yoshfuji@linux-ipv6.org>
To: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for "Too many arguments for pnp_activate_dev()"
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030226.144806.06041481.yoshfuji@linux-ipv6.org>
References: <Pine.LNX.4.44.0302261256510.1039-100000@thor.cantech.net.au>
	<20030226.144806.06041481.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030226.144806.06041481.yoshfuji@linux-ipv6.org> (at Wed, 26 Feb 2003 14:48:06 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

> > 	The 2.5.63 kernel contains changes to pnp.h that mean the template arg
> > is nolonger there.  The object compiles with this patch.
> 
> Yes, I sent similar patch yesterday.
> Here's the revised patch for other drivers, too.

Ah, ChangeSet 1.1057 has fixed most of this problem.
http://linux.bkbits.net:8080/linux-2.5/cset@1.1057?nav=index.html

Please apply following patch.

Index: sound/oss/ad1848.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/sound/oss/ad1848.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 ad1848.c
--- sound/oss/ad1848.c	16 Feb 2003 04:06:51 -0000	1.1.1.9
+++ sound/oss/ad1848.c	26 Feb 2003 05:34:51 -0000
@@ -2987,7 +2987,7 @@
 	if (err < 0)
 		return(NULL);
 
-	if((err = pnp_activate_dev(dev,NULL)) < 0) {
+	if((err = pnp_activate_dev(dev)) < 0) {
 		printk(KERN_ERR "ad1848: %s %s config failed (out of resources?)[%d]\n", devname, resname, err);
 
 		pnp_device_detach(dev);

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
