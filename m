Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319638AbSIMNb7>; Fri, 13 Sep 2002 09:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319645AbSIMNb7>; Fri, 13 Sep 2002 09:31:59 -0400
Received: from 166.Red-80-36-134.pooles.rima-tde.net ([80.36.134.166]:6183
	"EHLO apocalipsis") by vger.kernel.org with ESMTP
	id <S319638AbSIMNb6>; Fri, 13 Sep 2002 09:31:58 -0400
Date: Fri, 13 Sep 2002 15:38:55 +0200
From: "Juan M. de la Torre" <jmtorre@gmx.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Trivial patch in the bootmem allocator
Message-ID: <20020913133855.GA623@apocalipsis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 If the requested align is PAGE_SIZE, it is impossible to merge with the
previous allocation request, because the allocated area must begin in a
page boundary.

Regards,
Juanma

--- linux/mm/bootmem.c.orig     Fri Sep 13 15:23:22 2002
+++ linux/mm/bootmem.c  Fri Sep 13 15:24:31 2002
@@ -205,7 +205,7 @@
         * of this allocation's buffer? If yes then we can 'merge'
         * the previous partial page with this allocation.
         */
-       if (align <= PAGE_SIZE
+       if (align < PAGE_SIZE
            && bdata->last_offset && bdata->last_pos+1 == start) {
                offset = (bdata->last_offset+align-1) & ~(align-1);
                if (offset > PAGE_SIZE)

 
-- 
/jm

