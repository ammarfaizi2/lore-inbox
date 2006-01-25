Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWAYIm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWAYIm3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 03:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWAYIm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 03:42:29 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:22922 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750943AbWAYIm3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 03:42:29 -0500
Message-ID: <43D739EF.5000609@cosmosbay.com>
Date: Wed, 25 Jan 2006 09:42:23 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH, resent] convert a for (i = 0 ; i < NR_CPUS ; i++) to for_each_cpu(i)
  in sched_init()
References: <20060124232406.50abccd1.akpm@osdl.org> <43D73913.9070200@cosmosbay.com>
In-Reply-To: <43D73913.9070200@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------000309000605070804020205"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 25 Jan 2006 09:42:22 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000309000605070804020205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Oops, sorry for the patch -p0, this one is resent with correct -p1 format

This one was not triggered by yesterday patch : My test machine doesnt crash 
when dereferencing (runqueue_t *)0x3420, I wonder why ?

[PATCH] converts a for (i = 0 ; i < NR_CPUS ; i++) to for_each_cpu(i)  in 
sched_init().


Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------000309000605070804020205
Content-Type: text/plain;
 name="sched_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched_init.patch"

--- linux-2.6.16-rc1-mm3/kernel/sched.c	2006-01-25 10:28:15.000000000 +0100
+++ linux-2.6.16-rc1-mm3-ed/kernel/sched.c	2006-01-25 10:28:32.000000000 +0100
@@ -6258,7 +6258,7 @@
 	runqueue_t *rq;
 	int i, j, k;
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		prio_array_t *array;
 
 		rq = cpu_rq(i);

--------------000309000605070804020205--
