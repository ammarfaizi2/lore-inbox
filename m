Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbTDVTRk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTDVTRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:17:39 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:62359 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263372AbTDVTRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:17:37 -0400
Date: Tue, 22 Apr 2003 23:29:05 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: [2.4] Memleak in Essential RoadRunner HIPPI board driver (resend)
Message-ID: <20030422192905.GA7293@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

  I got no reply on the first try. Also the patch is not present neither
  in current 2.4 bk nor in 2.4.21-pre7-ac2, so I am resending.

----- Forwarded message from Oleg Drokin <green@linuxhacker.ru> -----

Date: Wed, 12 Mar 2003 22:08:46 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org, Jes.Sorensen@cern.ch
Subject: [2.4] Memleak in Essential RoadRunner HIPPI board driver
User-Agent: Mutt/1.4i

Hello!

   There is memleak on error exit path. Seems there was some confusion
   in the mind of whoever added that zeroing statement.
   The patch is trivial, 2.5 is not affected.
   Found with help of smatch + enhanced unfree script

Bye,
    Oleg

===== drivers/net/rrunner.c 1.6 vs edited =====
--- 1.6/drivers/net/rrunner.c	Thu Feb 28 16:57:24 2002
+++ edited/drivers/net/rrunner.c	Wed Mar 12 22:05:15 2003
@@ -1216,7 +1216,6 @@
 
 	rrpriv->info = kmalloc(sizeof(struct rr_info), GFP_KERNEL);
 	if (!rrpriv->info){
-		rrpriv->rx_ctrl = NULL;
 		ecode = -ENOMEM;
 		goto error;
 	}

----- End forwarded message -----
