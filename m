Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262080AbTCRBkD>; Mon, 17 Mar 2003 20:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262082AbTCRBkD>; Mon, 17 Mar 2003 20:40:03 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:64227 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262080AbTCRBkB>;
	Mon, 17 Mar 2003 20:40:01 -0500
Message-ID: <3E767953.2040908@us.ibm.com>
Date: Mon, 17 Mar 2003 17:41:39 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
CC: Andrew Morton <akpm@zip.com.au>, Martin Bligh <mjbligh@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [patch][trivial] GFP_ZONEMASK fix
Content-Type: multipart/mixed;
 boundary="------------070209040707050001010205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070209040707050001010205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

GFP_ZONEMASK is set up as 0xf, meaning the low four bits specify the 
zone type.  As there are only 3 zone types (DMA, NORMAL, & HIGHMEM), and 
only 2 of them (DMA & HIGHMEM) have flags (NORMAL is the default), this 
is wrong.  This simple patch changes one comment, and changes the value 
of GFP_ZONEMASK from 0xf to 0x3.

I'm not sure if this was specified this way to allow for future 
expansion, or what.  If so, please ignore this.  If anyone can tell me 
why this is set to four bits, I'm all ears.

Cheers!

-Matt

--------------070209040707050001010205
Content-Type: text/plain;
 name="GFP_ZONEMASK_fix-2.5.65.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="GFP_ZONEMASK_fix-2.5.65.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/include/linux/gfp.h linux-2.5.64-gfp_zonemask_fix/include/linux/gfp.h
--- linux-2.5.64-vanilla/include/linux/gfp.h	Tue Mar  4 19:29:03 2003
+++ linux-2.5.64-gfp_zonemask_fix/include/linux/gfp.h	Mon Mar 17 14:16:28 2003
@@ -7,7 +7,7 @@
 /*
  * GFP bitmasks..
  */
-/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low four bits) */
+/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low two bits) */
 #define __GFP_DMA	0x01
 #define __GFP_HIGHMEM	0x02
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/include/linux/mmzone.h linux-2.5.64-gfp_zonemask_fix/include/linux/mmzone.h
--- linux-2.5.64-vanilla/include/linux/mmzone.h	Tue Mar  4 19:29:22 2003
+++ linux-2.5.64-gfp_zonemask_fix/include/linux/mmzone.h	Mon Mar 17 14:16:28 2003
@@ -162,7 +162,7 @@
 	struct zone *zones[MAX_NUMNODES * MAX_NR_ZONES + 1]; // NULL delimited
 };
 
-#define GFP_ZONEMASK	0x0f
+#define GFP_ZONEMASK	0x03
 
 /*
  * The pg_data_t structure is used in machines with CONFIG_DISCONTIGMEM

--------------070209040707050001010205--

