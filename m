Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267403AbUIWWnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267403AbUIWWnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267482AbUIWWj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:39:57 -0400
Received: from bart.webpack.hosteurope.de ([217.115.142.76]:47843 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S267403AbUIWWhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:37:21 -0400
Date: Fri, 24 Sep 2004 00:37:27 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2-mm2: devmem_is_allowed
Message-ID: <Pine.LNX.4.44.0409240030210.14340-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

after switching from working 2.6.9-rc2 to -mm2, X refused to start on my 
testbox. It turned out this was because it failed (EPERM) reading from 
/dev/mem beyond the 1MB limit.

IMHO there is a typo in the test in devmem_is_allowed. The patch below 
fixed the issue for me. Despite I think it's pretty clear the logic there 
needs to be reverted, I'm somewhat uncertain because AFAICS nobody else 
complained so far - did I miss something?

Martin

-------------

diff -urp linux-2.6.9-rc2-mm2/arch/i386/mm/init.c v2.6.9-rc2-mm2-md/arch/i386/mm/init.c
--- linux-2.6.9-rc2-mm2/arch/i386/mm/init.c	Thu Sep 23 11:41:20 2004
+++ v2.6.9-rc2-mm2-md/arch/i386/mm/init.c	Fri Sep 24 00:13:26 2004
@@ -239,7 +239,7 @@ int devmem_is_allowed(unsigned long page
 {
 	if (pagenr <= 256)
 		return 1;
-	if (!page_is_ram(pagenr))
+	if (page_is_ram(pagenr))
 		return 1;
 	return 0;
 }

