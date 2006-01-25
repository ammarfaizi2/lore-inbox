Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWAYIi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWAYIi6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 03:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWAYIi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 03:38:58 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:57993 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750937AbWAYIi6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 03:38:58 -0500
Message-ID: <43D73913.9070200@cosmosbay.com>
Date: Wed, 25 Jan 2006 09:38:43 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] convert a for (i = 0 ; i < NR_CPUS ; i++) to for_each_cpu(i)
  in sched_init()
References: <20060124232406.50abccd1.akpm@osdl.org>
In-Reply-To: <20060124232406.50abccd1.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060106030706000109090705"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 25 Jan 2006 09:38:43 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060106030706000109090705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This one was not triggered by yesterday patch : My test machine doesnt crash 
when dereferencing (runqueue_t *)0x3420, I wonder why ?

[PATCH] converts a for (i = 0 ; i < NR_CPUS ; i++) to for_each_cpu(i)  in 
sched_init().


Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------060106030706000109090705
Content-Type: text/plain;
 name="sched_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched_init.patch"

--- kernel/sched.c.orig	2006-01-25 10:28:15.000000000 +0100
+++ kernel/sched.c	2006-01-25 10:28:32.000000000 +0100
@@ -6258,7 +6258,7 @@
 	runqueue_t *rq;
 	int i, j, k;
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		prio_array_t *array;
 
 		rq = cpu_rq(i);

--------------060106030706000109090705--
