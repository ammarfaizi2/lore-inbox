Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbTGROss (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267587AbTGROsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:48:46 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29317
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271797AbTGROJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:09:43 -0400
Date: Fri, 18 Jul 2003 15:24:04 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181424.h6IEO41F017806@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix a copy_user return
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/fs/proc/proc_misc.c linux-2.6.0-test1-ac2/fs/proc/proc_misc.c
--- linux-2.6.0-test1/fs/proc/proc_misc.c	2003-07-10 21:05:28.000000000 +0100
+++ linux-2.6.0-test1-ac2/fs/proc/proc_misc.c	2003-07-15 17:49:25.000000000 +0100
@@ -536,7 +536,8 @@
 		buf++; p++; count--; read++;
 	}
 	pnt = (char *)prof_buffer + p - sizeof(unsigned int);
-	copy_to_user(buf,(void *)pnt,count);
+	if(copy_to_user(buf,(void *)pnt,count))
+		return -EFAULT;
 	read += count;
 	*ppos += read;
 	return read;
