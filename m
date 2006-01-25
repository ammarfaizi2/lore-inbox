Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWAYJP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWAYJP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWAYJPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:15:24 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:15293 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751069AbWAYJPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:15:03 -0500
Message-ID: <43D7418B.30805@cosmosbay.com>
Date: Wed, 25 Jan 2006 10:14:51 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] convert a for (i = 0 ; i < NR_CPUS ; i++) to for_each_cpu(i)
  in files_defer_init()
References: <20060124232406.50abccd1.akpm@osdl.org> <43D73913.9070200@cosmosbay.com> <43D739EF.5000609@cosmosbay.com>
In-Reply-To: <43D739EF.5000609@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------080502030806050404020606"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 25 Jan 2006 10:14:50 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080502030806050404020606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[PATCH] converts a for (i = 0 ; i < NR_CPUS ; i++) to for_each_cpu(i)  in 
files_defer_init().

The comment 'Really early - can't use for_each_cpu' is probably outdated, 
because if we access &per_cpu(fdtable_defer_list, cpu), then for_each_cpu() or 
cpu_possible() should be available (It was available at setup_per_cpu_areas() 
time)

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------080502030806050404020606
Content-Type: text/plain;
 name="files_defer_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="files_defer_init.patch"

--- linux-2.6.16-rc1-mm3/fs/file.c	2006-01-25 10:55:13.000000000 +0100
+++ linux-2.6.16-rc1-mm3-ed/fs/file.c	2006-01-25 10:54:39.000000000 +0100
@@ -373,7 +373,6 @@
 void __init files_defer_init(void)
 {
 	int i;
-	/* Really early - can't use for_each_cpu */
-	for (i = 0; i < NR_CPUS; i++)
+	for_each_cpu(i)
 		fdtable_defer_list_init(i);
 }

--------------080502030806050404020606--
