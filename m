Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTLJQLq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 11:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbTLJQLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 11:11:46 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:39578 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S263732AbTLJQLn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 11:11:43 -0500
Date: Wed, 10 Dec 2003 09:11:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
Message-ID: <20031210161142.GE23731@stop.crashing.org>
References: <20031020203338.GJ6062@ip68-0-152-218.tc.ph.cox.net> <Pine.GSO.4.44.0312101519590.26871-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0312101519590.26871-100000@math.ut.ee>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 03:21:32PM +0200, Meelis Roos wrote:

> Current 2.4.24-pre is also misbehaving - now it too finds only 32M RAM
> on my Powerstack. 2.4.23-pre9 is OK.

Okay.  That's not totally unsurprising.  Can you try the following and
let me know what the output is?  Thanks.

===== arch/ppc/boot/prep/misc.c 1.14 vs edited =====
--- 1.14/arch/ppc/boot/prep/misc.c	Mon Oct 20 11:49:35 2003
+++ edited/arch/ppc/boot/prep/misc.c	Wed Dec 10 09:11:05 2003
@@ -251,15 +251,21 @@
 		{
 			phandle dev_handle;
 			int mem_info[2];
+			int n;
+			puts("Trying OF\n");
 
 			/* get handle to memory description */
 			if (!(dev_handle = finddevice("/memory@0")))
 				break;
+			puts("Found /memory@0\n");
 
 			/* get the info */
 			if (getprop(dev_handle, "reg", mem_info,
-						sizeof(mem_info) != 8))
+						sizeof(mem_info) != 8)) {
+				puts("n = 0x");puthex(n);puts("\n");
 				break;
+			}
+			puts("Found reg prop\n");
 
 			TotalMemory = mem_info[1];
 			break;

-- 
Tom Rini
http://gate.crashing.org/~trini/
