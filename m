Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292554AbSCKUHI>; Mon, 11 Mar 2002 15:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSCKUG7>; Mon, 11 Mar 2002 15:06:59 -0500
Received: from air-2.osdl.org ([65.201.151.6]:10886 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292554AbSCKUGr>;
	Mon, 11 Mar 2002 15:06:47 -0500
Date: Mon, 11 Mar 2002 12:06:45 -0800
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.6-pre3 Fix small race in BSD accounting [part 1]
Message-ID: <20020311120645.A5995@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Below is a patch to remove a small race in kernel/acct.c.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


diff -ur linux-2.5.6-orig/kernel/acct.c linux-2.5.6/kernel/acct.c
--- linux-2.5.6-orig/kernel/acct.c	Thu Mar  7 18:18:05 2002
+++ linux-2.5.6/kernel/acct.c	Mon Mar 11 10:52:10 2002
@@ -354,7 +354,7 @@
 		file = acct_file;
 		get_file(file);
 		unlock_kernel();
-		do_acct_process(exitcode, acct_file);
+		do_acct_process(exitcode, file);
 		fput(file);
 	} else
 		unlock_kernel();
