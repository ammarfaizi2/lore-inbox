Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272059AbTHNAIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 20:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272066AbTHNAIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 20:08:30 -0400
Received: from evrtwa1-ar2-4-33-045-074.evrtwa1.dsl-verizon.net ([4.33.45.74]:7100
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S272059AbTHNAI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 20:08:29 -0400
Message-ID: <3F3AD2FB.8010109@candelatech.com>
Date: Wed, 13 Aug 2003 17:08:27 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.21: Increase dynamic proc slots to 8192 from 4096
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes problems I was seeing while trying to create a large number
of vlan interfaces (each interface has a proc file entry).

I hear it's even larger in 2.5.X, so if anyone wants to double it again,
please feel free!


+++ linux-2.4.21.amds/include/linux/proc_fs.h	2003-08-13 16:47:29.000000000 -0700
@@ -25,7 +25,8 @@
  /* Finally, the dynamically allocatable proc entries are reserved: */

  #define PROC_DYNAMIC_FIRST 4096
-#define PROC_NDYNAMIC      4096
+#define PROC_NDYNAMIC      8192 /* was 4096 previously, but was running out of
+                                 * slots when creating lots of VLANs --Ben */

  #define PROC_SUPER_MAGIC 0x9fa0


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


