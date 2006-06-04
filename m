Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWFDCQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWFDCQf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 22:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWFDCQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 22:16:16 -0400
Received: from [198.99.130.12] ([198.99.130.12]:41645 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751422AbWFDCQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 22:16:11 -0400
Message-Id: <200606040216.k542GG9q004842@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4/6] UML - __user annotation in arch_prctl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Jun 2006 22:16:16 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

fix uml/amd64 prctl()
   
put_user() there should go to (long __user *)addr, not &addr

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17-mm/arch/um/sys-x86_64/syscalls.c
===================================================================
--- linux-2.6.17-mm.orig/arch/um/sys-x86_64/syscalls.c	2006-05-31 12:14:58.000000000 -0400
+++ linux-2.6.17-mm/arch/um/sys-x86_64/syscalls.c	2006-06-02 18:39:09.000000000 -0400
@@ -45,7 +45,7 @@ static long arch_prctl_tt(int code, unsi
 	case ARCH_GET_GS:
 		ret = arch_prctl(code, (unsigned long) &tmp);
 		if(!ret)
-			ret = put_user(tmp, &addr);
+			ret = put_user(tmp, (long __user *)addr);
 		break;
 	default:
 		ret = -EINVAL;


