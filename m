Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266277AbUFPNtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266277AbUFPNtY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 09:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUFPNtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 09:49:24 -0400
Received: from everest.2mbit.com ([24.123.221.2]:12983 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S266277AbUFPNtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 09:49:22 -0400
Message-ID: <40D04FC9.6080204@greatcn.org>
Date: Wed, 16 Jun 2004 21:48:57 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, kai@germaschewski.name, sam@ravnborg.org
X-Scan-Signature: fad39d3eb0bc82a8daaaab38959dee5c
X-SA-Exim-Connect-IP: 218.24.173.192
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [PATCH] [BUG FIX] kbuild distclean srctree fix
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  3.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.173.192 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.0 (built Wed, 05 May 2004 12:02:20 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I just find a bug that ``make distclean'' cannot remove the editor 
backup files and the like when using build directory.
That is because the find command is improperly searching the build 
directory instead of the $(srctree) it should.
.
This simple patch fixes the problem.
 
    -- coywolf

===============================================================

--- linux-2.6.7/Makefile	Wed Jun  9 01:07:00 2004
+++ linux-2.6.7-cy/Makefile	Wed Jun 16 21:33:57 2004
@@ -841,7 +841,7 @@ mrproper: clean archmrproper $(mrproper-
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

