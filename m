Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWJVUiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWJVUiG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 16:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWJVUiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 16:38:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:62290 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751459AbWJVUiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 16:38:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=nLyibodZIFypLtk2OctCPjeQkv/DzF9Lhxt3E2R+wKaExmZPRjhv8UQDis0uhSVM9OzXTdHBBt6+4KWm5b45OoxCI2KiFRZLd/nDsS2scG8u2IdkBlPmHrRFcgeHzIJho3TbqfGb1l70P1L8BljKNE7FTkund8s73EozdzpJtpQ=
Date: Sun, 22 Oct 2006 13:37:51 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc2] mm/slab.c: check kmalloc() return value.
Message-Id: <20061022133751.5f1d8281.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function setup_cpu_cache(), in file mm/slab.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/mm/slab.c b/mm/slab.c
index 84c631f..613ae61 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2021,6 +2021,7 @@ static int setup_cpu_cache(struct kmem_c
 	} else {
 		cachep->array[smp_processor_id()] =
 			kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+		BUG_ON(!cachep->array[smp_processor_id()]);
 
 		if (g_cpucache_up == PARTIAL_AC) {
 			set_up_list3s(cachep, SIZE_L3);
