Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbTLVTsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 14:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTLVTsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 14:48:24 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:48530 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264238AbTLVTsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 14:48:23 -0500
Message-ID: <3FE74984.3000602@us.ibm.com>
Date: Mon, 22 Dec 2003 11:44:04 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mbligh@aracnet.com, Andrew Morton <akpm@digeo.com>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [TRIVIAL PATCH] Ensure pfn_to_nid() is always defined for i386
Content-Type: multipart/mixed;
 boundary="------------020402010608040806030307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020402010608040806030307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

pfn_to_nid() is defined for *almost* all configurations for i386.  There 
is a small bug in that for CONFIG_X86_PC it is not.  This just sets up a 
generic definition so that this function is always defined in a 
reasonable manner.

Cheers!

-Matt

--------------020402010608040806030307
Content-Type: text/plain;
 name="pfn_to_nid_def.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pfn_to_nid_def.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-vanilla/include/asm-i386/mmzone.h linux-2.6.0-patched/include/asm-i386/mmzone.h
--- linux-2.6.0-vanilla/include/asm-i386/mmzone.h	Wed Dec 17 18:58:49 2003
+++ linux-2.6.0-patched/include/asm-i386/mmzone.h	Thu Dec 18 14:46:14 2003
@@ -123,6 +123,7 @@ static inline struct pglist_data *pfn_to
 #include <asm/srat.h>
 #elif CONFIG_X86_PC
 #define get_zholes_size(n) (0)
+#define pfn_to_nid(pfn)		(0)
 #else
 #define pfn_to_nid(pfn)		(0)
 #endif /* CONFIG_X86_NUMAQ */

--------------020402010608040806030307--

