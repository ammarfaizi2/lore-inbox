Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316067AbSEWFyu>; Thu, 23 May 2002 01:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316096AbSEWFyt>; Thu, 23 May 2002 01:54:49 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:1667 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S316067AbSEWFyt>;
	Thu, 23 May 2002 01:54:49 -0400
Date: Wed, 22 May 2002 22:54:16 -0700
From: "Martin J. Bligh" <fletch@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, gone@us.ibm.com
Subject: [PATCH] fix paging_init for i386 discontigmem support (-aa kernel)
Message-ID: <1454405545.1022108056@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One small fix to make the latest code work properly in
conjunction with the zone_start_pfn change ... this is
only needed for Andrea's tree at the moment. Without it,
you get no memory on nodes > 0; all I'm doing is taking
out the PAGE_SHIFT.

--- virgin-2.4.19-pre8-aa3/arch/i386/mm/discontig.c	Wed May 22 17:19:11 2002
+++ linux-2.4.19-pre8-aa3-paging_init/arch/i386/mm/discontig.c	Wed May 22 21:21:28 2002
@@ -259,7 +259,7 @@
 #endif
 			}
 		}
-		free_area_init_node(nid, NODE_DATA(nid), 0, zones_size, start << PAGE_SHIFT, 0);
+		free_area_init_node(nid, NODE_DATA(nid), 0, zones_size, start, 0);
 	}
 	return;
 }



