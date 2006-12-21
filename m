Return-Path: <linux-kernel-owner+w=401wt.eu-S1422932AbWLUKDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422932AbWLUKDa (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 05:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422933AbWLUKDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 05:03:30 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:60203 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422932AbWLUKD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 05:03:29 -0500
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 05:03:29 EST
Message-ID: <458A5BEB.8090400@bx.jp.nec.com>
Date: Thu, 21 Dec 2006 19:03:23 +0900
From: Keiichi KII <k-keiichi@bx.jp.nec.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 2.6.19 take2 1/5] marking __init and remove drop initialization
References: <458A5AAE.30209@bx.jp.nec.com>
In-Reply-To: <458A5AAE.30209@bx.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keiichi KII <k-keiichi@bx.jp.nec.com>

This patch contains the following cleanups.
 - add __init for initialization functions(option_setup() and
   init_netconsole()).
 - remove "drop" initialization in the netpoll structure.

Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
---
[changes]
1. stop to use anoymous enum.
2. remove unrelated changes(formatting changes).

--- linux-2.6.19/drivers/net/netconsole.c	2006-12-21 18:26:04.017895000 +0900
+++ enhanced-netconsole/drivers/net/netconsole.c.cleanup	2006-12-21 18:38:34.080771000 +0900
@@ -60,7 +60,6 @@ static struct netpoll np = {
 	.local_port = 6665,
 	.remote_port = 6666,
 	.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
-	.drop = netpoll_queue,
 };
 static int configured = 0;
 
@@ -92,7 +91,7 @@ static struct console netconsole = {
 	.write = write_msg
 };
 
-static int option_setup(char *opt)
+static int __init option_setup(char *opt)
 {
 	configured = !netpoll_parse_options(&np, opt);
 	return 1;
@@ -100,7 +99,7 @@ static int option_setup(char *opt)
 
 __setup("netconsole=", option_setup);
 
-static int init_netconsole(void)
+static int __init init_netconsole(void)
 {
 	if(strlen(config))
 		option_setup(config);

-- 
Keiichi KII
NEC Corporation OSS Promotion Center
E-mail: k-keiichi@bx.jp.nec.com
