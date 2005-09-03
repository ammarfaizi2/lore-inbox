Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVICIt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVICIt0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 04:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVICIt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 04:49:26 -0400
Received: from ybbsmtp06.mail.mci.yahoo.co.jp ([210.80.241.155]:62578 "HELO
	ybbsmtp06.mail.mci.yahoo.co.jp") by vger.kernel.org with SMTP
	id S1751194AbVICItZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 04:49:25 -0400
X-Apparently-From: <takeharu1219@yahoo.co.jp>
Message-ID: <43196393.2040801@ybb.ne.jp>
Date: Sat, 03 Sep 2005 17:49:23 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: trivial@rustcorp.com.au
CC: linux-kernel@vger.kernel.org
Subject: [TRIVAL] Runtime linkage fix for serial_cs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I found current serial_cs driver can not be loaded into the kernel.
The reason of this issue is serial_cs driver uses serial8250_unregister_port function
which is not exported for modules.
I fixed the issue, please apply this patch.

Signed-off-by: kato.takeharu@jp.fujitsu.com

diff -NBbur linux.orig/drivers/serial/serial_cs.c linux/drivers/serial/serial_cs.c
--- linux.orig/drivers/serial/serial_cs.c    2005-06-27 15:06:42.000000000 +0900
+++ linux/drivers/serial/serial_cs.c 2005-08-24 00:16:09.297664592 +0900
@@ -139,7 +139,7 @@
          */
         if (info->link.state & DEV_CONFIG) {
                 for (i = 0; i < info->ndev; i++)
-                       serial8250_unregister_port(info->line[i]);
+                       unregister_serial(info->line[i]);

                 info->link.dev = NULL;

