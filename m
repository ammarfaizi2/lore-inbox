Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVCRXuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVCRXuy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVCRXuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:50:54 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:50232 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S261593AbVCRXus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:50:48 -0500
Message-ID: <423B6A16.5090701@nvidia.com>
Date: Fri, 18 Mar 2005 15:53:58 -0800
From: achew <achew@nvidia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mpspec.h: Fix MAX_MP_BUSSES for compliance with MP specification
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Mar 2005 23:50:47.0613 (UTC) FILETIME=[4EB1AED0:01C52C15]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MP specification uses an 8-bit field for bus ID.  Therefore, the highest bus ID is 0xff.
Since the tables allocated and used in mpparse.c are indexed by bus ID, we need to make
sure we allocate 256 entries for these tables.

Note that bus IDs can be noncontiguous, according to the MP specification.  The only
requirement is that they be listed in increasing order.


Signed-off-by: Andrew Chew <achew@nvidia.com>

---

diff -ru linux-2.4.29/include/asm-i386/mpspec.h linux/include/asm-i386/mpspec.h
--- linux-2.4.29/include/asm-i386/mpspec.h	2004-11-17 03:54:22.000000000 -0800
+++ linux/include/asm-i386/mpspec.h	2005-03-18 15:02:20.000000000 -0800
@@ -191,7 +191,7 @@
 #define MAX_IRQ_SOURCES 256
 #endif /* CONFIG_MULTIQUAD */
 
-#define MAX_MP_BUSSES 32
+#define MAX_MP_BUSSES 256
 enum mp_bustype {
 	MP_BUS_ISA = 1,
 	MP_BUS_EISA,


