Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266210AbUFYFvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266210AbUFYFvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 01:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUFYFvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 01:51:51 -0400
Received: from everest.2mbit.com ([24.123.221.2]:57519 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S266210AbUFYFvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 01:51:49 -0400
Message-ID: <40DBBD54.8090303@greatcn.org>
Date: Fri, 25 Jun 2004 13:51:16 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
References: <20040624014655.5d2a4bfb.akpm@osdl.org> <40DAE44D.2000305@greatcn.org>
In-Reply-To: <40DAE44D.2000305@greatcn.org>
X-Scan-Signature: e39eceae6eb4554774934c39b07fdc9c
X-SA-Exim-Connect-IP: 218.24.168.201
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [PATCH] (2.6.7-mm2) kbuild distclean srctree fix ii
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.168.201 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0 (built Wed, 05 May 2004 12:02:20 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

You've changed a wrong line.  There's several ``@find . 
$(RCS_FIND_IGNORE)'' in Makefile.
You want the line about 24 lines below. Please apply this patch to 
re-fix it.
http://greatcn.org/~coywolf/patches/2.6/kbuild-distclean-srctree-fix-ii.patch

     coywolf
===============================================================

--- linux-2.6.7-mm2/Makefile	2004-06-24 22:16:08.000000000 -0500
+++ linux-2.6.7-mm2-cy/Makefile	2004-06-25 00:13:55.885753597 -0500
@@ -866,7 +866,7 @@ $(clean-dirs):
 clean: archclean $(clean-dirs)
 	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
-	 @find $(srctree) $(RCS_FIND_IGNORE) \
+	 @find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \) \
 		-type f -print | xargs rm -f
@@ -890,7 +890,7 @@ mrproper: clean archmrproper $(mrproper-
 .PHONY: distclean
 
 distclean: mrproper
-	@find . $(RCS_FIND_IGNORE) \
+	@find $(srctree) $(RCS_FIND_IGNORE) \
 	 	\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
 	 	-o -name '.*.rej' -o -size 0 \


-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

