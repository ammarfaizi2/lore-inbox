Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262625AbTCIVEq>; Sun, 9 Mar 2003 16:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262626AbTCIVEq>; Sun, 9 Mar 2003 16:04:46 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:54167 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262625AbTCIVEp>;
	Sun, 9 Mar 2003 16:04:45 -0500
Date: Mon, 10 Mar 2003 00:14:34 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Memleak in ircomm_core
Message-ID: <20030309211434.GA31791@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There seems to be a memleak on error exit path. The same patch should apply
   to 2.5 and 2.4

   Found with help of smatch + enhanced unfree script.

Bye,
    Oleg

===== net/irda/ircomm/ircomm_core.c 1.5 vs edited =====
--- 1.5/net/irda/ircomm/ircomm_core.c	Tue Aug  6 22:23:24 2002
+++ edited/net/irda/ircomm/ircomm_core.c	Mon Mar 10 00:10:10 2003
@@ -121,8 +121,10 @@
 	} else
 		ret = ircomm_open_tsap(self);
 
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(self);
 		return NULL;
+	}
 
 	self->service_type = service_type;
 	self->line = line;
