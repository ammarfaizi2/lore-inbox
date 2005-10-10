Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVJJWfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVJJWfD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 18:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVJJWfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 18:35:03 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:18882 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751299AbVJJWfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 18:35:01 -0400
Subject: [PATCH] mincore() should return EINVAL for length < 0
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-KcL+i6C3jzWydJHNKPtQ"
Date: Mon, 10 Oct 2005 15:34:17 -0700
Message-Id: <1128983657.4896.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KcL+i6C3jzWydJHNKPtQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Here is the simple patch to fix mincore() returning
wrong error. mincore(2) manpage says, it should
return EINVAL, if length is non-positive.

Bug details are in:

http://bugme.osdl.org/show_bug.cgi?id=4612

Thanks,
Badari



--=-KcL+i6C3jzWydJHNKPtQ
Content-Disposition: attachment; filename=mincore-fix.patch
Content-Type: text/x-patch; name=mincore-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Badari Pulabarty <pbadari@us.ibm.com>
--- linux-2.6.14-rc3.org/mm/mincore.c	2005-10-10 17:14:30.000000000 -0700
+++ linux-2.6.14-rc3/mm/mincore.c	2005-10-10 17:26:52.000000000 -0700
@@ -115,7 +115,7 @@ asmlinkage long sys_mincore(unsigned lon
 	long error;
 
 	/* check the arguments */
- 	if (start & ~PAGE_CACHE_MASK)
+ 	if ((start & ~PAGE_CACHE_MASK) || ((ssize_t)len < 0))
 		goto einval;
 
 	limit = TASK_SIZE;

--=-KcL+i6C3jzWydJHNKPtQ--

