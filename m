Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVBCQjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVBCQjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbVBCQjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:39:17 -0500
Received: from mailfe10.swip.net ([212.247.155.33]:61944 "EHLO
	mailfe10.swip.net") by vger.kernel.org with ESMTP id S262391AbVBCQi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:38:57 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: Re: 2.6.11-rc1-mm2
From: Alexander Nyberg <alexn@dsv.su.se>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mikpe@csd.uu.se
In-Reply-To: <200501311934.16057.tomlins@cam.org>
References: <20050119213818.55b14bb0.akpm@osdl.org>
	 <200501311934.16057.tomlins@cam.org>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 17:36:59 +0100
Message-Id: <1107448619.691.3.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bootdata ok (command line is root=/dev/hda3 ro console=tty0 console=ttyS0,38400)
> Linux version 2.6.11-rc2-mm2 (ed@grover) (gcc version 3.4.4 20041218 (prerelease) (Debian 3.4.3-7)) #1 Sun Jan 30 09:18:40 EST 2005
                ^^^^^^^^^^^^^^

Me thinks this will fix it for you:

--- 25/include/linux/stop_machine.h~fix-kallsyms-insmod-rmmod-race-fix-fix-fix	2005-01-29 16:17:47.936137064 -0800
+++ 25-akpm/include/linux/stop_machine.h	2005-01-29 16:18:09.493859792 -0800
@@ -57,7 +57,7 @@ static inline int stop_machine_run(int (
 static inline int stop_machine_run(int (*fn)(void *), void *data,
 				   unsigned int cpu)
 {
-	return 0;
+	return fn(data);
 }
 
 #endif	/* CONFIG_STOP_MACHINE */
_

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



