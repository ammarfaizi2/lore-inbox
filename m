Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbUBZQ33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbUBZQ3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:29:14 -0500
Received: from ram.rentec.com ([192.5.35.66]:43453 "EHLO ram.rentec.com")
	by vger.kernel.org with ESMTP id S262826AbUBZQ06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:26:58 -0500
From: Brian Childs <brian@rentec.com>
Date: Thu, 26 Feb 2004 11:26:54 -0500
To: linux-kernel@vger.kernel.org
Subject: Multicast broken on x86_64 (Patch Included)
Message-ID: <20040226162652.GG1760@rentec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

csum-partial.c in 2.4.25 and 2.6.3 has a bug that causes it to compute
the checksum incorrectly.

As a result, multicast doesn't work.  It looks as though iptables is
also affected.

Anyway, here's a simple patch.

Brian

diff -ruN linux-2.4.25-orig/arch/x86_64/lib/csum-partial.c linux-2.4.25/arch/x86_64/lib/csum-partial.c
--- linux-2.4.25-orig/arch/x86_64/lib/csum-partial.c	2003-06-13 10:51:32.000000000 -0400
+++ linux-2.4.25/arch/x86_64/lib/csum-partial.c	2004-02-26 11:20:17.000000000 -0500
@@ -141,6 +141,6 @@
  */
 unsigned short ip_compute_csum(unsigned char * buff, int len)
 {
-	return ~csum_partial(buff,len,0); 
+	return csum_fold(csum_partial(buff,len,0));
 }
 

