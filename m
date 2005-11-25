Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbVKYNgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbVKYNgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 08:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVKYNgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 08:36:54 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:30375 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751420AbVKYNgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 08:36:53 -0500
Message-ID: <4387134B.7090203@cosmosbay.com>
Date: Fri, 25 Nov 2005 14:36:11 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, levon@movementarian.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] oprofile : Use vmalloc_node() in alloc_cpu_buffers()
References: <20051123033550.00d6a6e8.akpm@osdl.org>	<438530F2.2020904@jp.fujitsu.com> <20051123210252.05cac86c.akpm@osdl.org>
In-Reply-To: <20051123210252.05cac86c.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040908080000030600030307"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 25 Nov 2005 14:36:10 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040908080000030600030307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This small patch makes oprofile alloc_cpu_buffers() function NUMA aware, 
allocating each CPU local buffer in its memory node if possible.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------040908080000030600030307
Content-Type: text/plain;
 name="vmalloc_node_in_oprofile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vmalloc_node_in_oprofile.patch"

--- linux-2.6-orig/drivers/oprofile/cpu_buffer.c	2005-11-25 10:24:00.000000000 +0100
+++ linux-2.6/drivers/oprofile/cpu_buffer.c	2005-11-25 14:29:04.000000000 +0100
@@ -52,7 +52,8 @@
 	for_each_online_cpu(i) {
 		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
  
-		b->buffer = vmalloc(sizeof(struct op_sample) * buffer_size);
+		b->buffer = vmalloc_node(sizeof(struct op_sample) * buffer_size,
+			cpu_to_node(i));
 		if (!b->buffer)
 			goto fail;
  

--------------040908080000030600030307--
