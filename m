Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUIDRzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUIDRzD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUIDRxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:53:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41483 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S265144AbUIDRx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:53:27 -0400
Date: Sat, 4 Sep 2004 19:52:56 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Maximilian Attems <janitor@sternwelten.at>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.9-rc1-mm3: cdrom/cdu31a.c doesn't compile
Message-ID: <20040904175256.GC10029@fs.tum.de>
References: <20040903014811.6247d47d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903014811.6247d47d.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 01:48:11AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.9-rc1-mm2:
>...
> +cdu31a-replace-schedule_timeout-with-msleep.patch
>...
>  Janitorial things
>...

Doesn't compile:

<--  snip  -->

...
  CC      drivers/cdrom/cdu31a.o
drivers/cdrom/cdu31a.c: In function `do_sony_cd_cmd':
drivers/cdrom/cdu31a.c:962: parse error before `:'
drivers/cdrom/cdu31a.c:932: warning: label `retry_cd_operation' defined but not used
make[2]: *** [drivers/cdrom/cdu31a.o] Error 1

<--  snip  -->


Trivial fix:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm3-full/drivers/cdrom/cdu31a.c.old	2004-09-04 11:30:21.000000000 +0200
+++ linux-2.6.9-rc1-mm3-full/drivers/cdrom/cdu31a.c	2004-09-04 11:31:08.000000000 +0200
@@ -959,7 +959,7 @@
 	if (((result_buffer[0] & 0xf0) == 0x20)
 	    && (num_retries < MAX_CDU31A_RETRIES)) {
 		num_retries++;
-		msleep(100):
+		msleep(100);
 		goto retry_cd_operation;
 	}
 

