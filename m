Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWACTlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWACTlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWACTlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:41:36 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:47807 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932505AbWACTlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:41:35 -0500
Subject: [PATCH] set_page_count
From: Avishay Traeger <atraeger@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 03 Jan 2006 14:41:34 -0500
Message-Id: <1136317294.21485.5.camel@rockstar.fsl.cs.sunysb.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I sent this to linux-mm, but haven't gotten a response - hope it's OK to
send here.  I believe the set_page_count() macro is broken, and should
have parentheses around the 'v' in the second argument (otherwise more
complex arguments will break).  Here is a patch to 2.6.15 - I haven't
really tested it, but it looks simple enough.  Any objections?  Anything
else I need to do?

Thanks,
Avishay Traeger
http://www.fsl.cs.sunysb.edu/~avishay/


diff -Naur linux-2.6.15/include/linux/mm.h
linux-2.6.15-mod/include/linux/mm.h
--- linux-2.6.15/include/linux/mm.h     2006-01-02 22:21:10.000000000
-0500
+++ linux-2.6.15-mod/include/linux/mm.h 2006-01-03 11:28:19.000000000
-0500
@@ -308,7 +308,7 @@
  */
 #define get_page_testone(p)    atomic_inc_and_test(&(p)->_count)

-#define set_page_count(p,v)    atomic_set(&(p)->_count, v - 1)
+#define set_page_count(p,v)    atomic_set(&(p)->_count, (v) - 1)
 #define __put_page(p)          atomic_dec(&(p)->_count)

 extern void FASTCALL(__page_cache_release(struct page *));

