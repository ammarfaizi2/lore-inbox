Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUI0K0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUI0K0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 06:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUI0K0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 06:26:13 -0400
Received: from c211-30-229-77.rivrw4.nsw.optusnet.com.au ([211.30.229.77]:18436
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S266611AbUI0K0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 06:26:11 -0400
Date: Mon, 27 Sep 2004 20:25:52 +1000
To: akpm@osdl.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: mdz@canonical.com
Subject: [PATCH] Use msleep_interruptible for therm_adt7467.c kernel thread
Message-ID: <20040927102552.GA19183@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

Using msleep() in a kernel thread causes it to show up in the D state
and contribute towards the system load average.  The following patch
converts it to msleep_interruptible().

The continue is just paranoia in case something relies on the sleep
to take 2 seconds or more.

This bug was reported at

https://bugzilla.no-name-yet.com/show_bug.cgi?id=1804

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== drivers/macintosh/therm_adt746x.c 1.5 vs edited =====
--- 1.5/drivers/macintosh/therm_adt746x.c	2004-09-23 06:31:14 +10:00
+++ edited/drivers/macintosh/therm_adt746x.c	2004-09-27 20:24:58 +10:00
@@ -246,7 +246,8 @@
 
 	while(monitor_running)
 	{
-		msleep(2000);
+		if (msleep_interruptible(2000))
+			continue;
 
 		/* Check status */
 		/* local   : chip */

--qMm9M+Fa2AknHoGS--
