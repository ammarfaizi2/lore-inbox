Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266053AbUBBUGt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUBBUE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:04:26 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:46468 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S266041AbUBBUDq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:03:46 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 21:03:44 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 37/42]
Message-ID: <20040202200344.GK6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


siimage.c:65: warning: control reaches end of non-void function

The last statement before the end is BUG(), but I added a return to
silence the warning.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/ide/pci/siimage.c linux-2.4/drivers/ide/pci/siimage.c
--- linux-2.4-vanilla/drivers/ide/pci/siimage.c	Tue Nov 11 17:51:38 2003
+++ linux-2.4/drivers/ide/pci/siimage.c	Sat Jan 31 19:07:56 2004
@@ -62,6 +62,9 @@
 			return 0;
 	}
 	BUG();
+
+	/* gcc will complain */
+	return 0;
 }
  
 /**

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
You and me baby ain't nothin' but mammals
So let's do it like they do on the Discovery Channel
