Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262938AbTCKOsH>; Tue, 11 Mar 2003 09:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262939AbTCKOsH>; Tue, 11 Mar 2003 09:48:07 -0500
Received: from angband.namesys.com ([212.16.7.85]:39824 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262938AbTCKOsG>; Tue, 11 Mar 2003 09:48:06 -0500
Date: Tue, 11 Mar 2003 17:58:48 +0300
From: Oleg Drokin <green@namesys.com>
To: neilb@cse.unsw.edu.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: [2.5] nfsd/export.c memleak.
Message-ID: <20030311175848.A3142@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

     There is trivial memleak on error exit path in nfsd.
     See the patch below.
     Found with help of smatch + enhanced unfree script.

Bye,
    Oleg

===== fs/nfsd/export.c 1.71 vs edited =====
--- 1.71/fs/nfsd/export.c	Tue Feb 25 13:08:50 2003
+++ edited/fs/nfsd/export.c	Tue Mar 11 17:55:18 2003
@@ -294,7 +294,10 @@
 
 	/* client */
 	len = qword_get(&mesg, buf, PAGE_SIZE);
-	if (len <= 0) return -EINVAL;
+	if (len <= 0) {
+		err = -EINVAL;
+		goto out;
+	}
 	err = -ENOENT;
 	dom = auth_domain_find(buf);
 	if (!dom)
