Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264813AbTFTV0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264810AbTFTV0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:26:06 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:3150 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S264784AbTFTVZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:25:50 -0400
Date: Fri, 20 Jun 2003 16:39:50 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: dnotify readv/writev fix for 2.4.21
Message-ID: <20030620163950.A8502@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

This patch didn't make it into 2.4.21.  Zou Pengcheng's original patch
was whitespace-damaged, so here's a fresh copy against 2.4.21.

Issue DN_MODIFY on writev, and DN_ACCESS on readv, rather than vice versa.

I can provide a testcase if anyone wants one.

----- Forwarded message from Zou Pengcheng <pczou@redflag-linux.com> -----

From: Zou Pengcheng <pczou@redflag-linux.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] dnotify fix for readv/writev (Linux 2.4.20)
Date:	Mon, 2 Dec 2002 09:22:43 +0800
Message-Id: <200212020922.43820.pczou@redflag-linux.com>

hi, Marcelo,

this is a patch to fix the dnotify bug of readv/writev. 

Orignally DN_MODIFY is issued on readv while DN_ACCESS is issued on writev, 
which is obviously wrong. This patch fixes such problem.

cheers,
  -- Pengcheng Zou

diff -uNr fs/read_write.c.orig fs/read_write.c
...

----- End forwarded message -----


--- linux-2.4.21/fs/read_write.c	Fri Jun 13 09:51:37 2003
+++ linux-2.4.21-dnotify-fix/fs/read_write.c	Thu Jun 19 11:55:30 2003
@@ -322,7 +322,7 @@
 	/* VERIFY_WRITE actually means a read, as we write to user space */
 	if ((ret + (type == VERIFY_WRITE)) > 0)
 		dnotify_parent(file->f_dentry,
-			(type == VERIFY_WRITE) ? DN_MODIFY : DN_ACCESS);
+			(type == VERIFY_WRITE) ? DN_ACCESS : DN_MODIFY);
 	return ret;
 }
 

-andy
