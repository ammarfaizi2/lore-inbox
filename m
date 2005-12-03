Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVLCBQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVLCBQM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 20:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVLCBQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 20:16:11 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:49020 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751124AbVLCBQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 20:16:11 -0500
Message-ID: <4390F1C2.7080602@cosmosbay.com>
Date: Sat, 03 Dec 2005 02:15:46 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove unused blkp field in percpu_data
References: <121a28810511282317j47a90f6t@mail.gmail.com> <20051129000916.6306da8b.akpm@osdl.org> <438C7218.8030109@cosmosbay.com>
In-Reply-To: <438C7218.8030109@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------090903010804080906010705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090903010804080906010705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[PATCH] remove unused blkp field in percpu_data

I found that blkp field was not used in kernel tree.

As most of the times NR_CPUS is a power of two and kmalloc() memory blocks 
too, this extra field basically doubles the memory space allocated in 
__alloc_percpu() to store the 'struct percpu_data'

(for example, if NR_CPUS=8 on i386, kmalloc(4*8+4) returns a 64 bytes block 
instead of a 32 bytes block after this patch)


Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------090903010804080906010705
Content-Type: text/plain;
 name="percpu_data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="percpu_data.patch"

--- linux-2.6/include/linux/percpu.h	2005-11-29 04:51:27.000000000 +0100
+++ linux-2.6-ed/linux/percpu.h	2005-12-03 01:57:23.000000000 +0100
@@ -19,7 +19,6 @@
 
 struct percpu_data {
 	void *ptrs[NR_CPUS];
-	void *blkp;
 };
 
 /* 

--------------090903010804080906010705--
