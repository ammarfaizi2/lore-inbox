Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbTLRFCx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 00:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbTLRFCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 00:02:53 -0500
Received: from H143.C231.tor.velocet.net ([216.138.231.143]:23959 "EHLO
	mjfrazer.org") by vger.kernel.org with ESMTP id S264934AbTLRFCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 00:02:50 -0500
Date: Thu, 18 Dec 2003 00:02:49 -0500
From: Mark Frazer <mark@mjfrazer.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Missing up_read after get_user_pages in arch/i386/lib/usercopy.c?
Message-ID: <20031218000249.A25268@mjfrazer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Outlook not so good.
Organization: Detectable, well, not really
X-Fry-1: Maybe you can't understand this, but I finally found what I need
X-Fry-2: to be happy, and it's not friends, it's things.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just browsing users of get_user_pages today and noticed what might be a
bug.

===== arch/i386/lib/usercopy.c 1.15 vs edited =====
--- 1.15/arch/i386/lib/usercopy.c	Thu Aug 21 01:31:58 2003
+++ edited/arch/i386/lib/usercopy.c	Wed Dec 17 23:59:16 2003
@@ -541,8 +541,10 @@
 				goto survive;
 			}
 
-			if (retval != 1)
+			if (retval != 1) {
+				up_read(&current->mm->mmap_sem);
 		       		break;
+			}
 
 			maddr = kmap_atomic(pg, KM_USER0);
 			memcpy(maddr + offset, from, len);


-- 
Like most of life's problems, this one can be solved with bending. - Bender
