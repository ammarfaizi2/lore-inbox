Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVAEU2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVAEU2W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVAEU2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:28:21 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:40642 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262647AbVAEU2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:28:07 -0500
Date: Wed, 5 Jan 2005 14:27:56 -0600
To: akpm@osdl.org
Cc: paulus@samba.org, anton@samba.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: xmon recursion
Message-ID: <20050105202756.GF22274@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I've had a number of problems with recursive xmon calls, primarily
because longjump was returning incorrectly.  The following patch
fixes this problem.

Please review and forward upstream.

--linas

Signed-off-by: Linas Vepstas <linas@linas.org>


===== arch/ppc64/xmon/setjmp.c 1.1 vs edited =====
--- 1.1/arch/ppc64/xmon/setjmp.c	2002-02-14 06:14:36 -06:00
+++ edited/arch/ppc64/xmon/setjmp.c	2004-12-14 17:51:29 -06:00
@@ -73,5 +73,6 @@ xmon_longjmp(long *buf, int val)
 	 ld	2,16(%0)\n\
 	 mtlr	0\n\
 	 mr	3,%1\n\
+	 blr	\n\
 	 " : : "r" (buf), "r" (val));
 }
