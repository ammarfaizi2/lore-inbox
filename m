Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbTELVNb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTELVNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:13:30 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:51473 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262735AbTELVN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:13:28 -0400
Date: Mon, 12 May 2003 22:25:50 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Damian =?utf-8?Q?Ko=C5=82kowski?= <deimos@deimos.one.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.69 - no setfont and loadkeys on tty > 1
In-Reply-To: <20030511173817.GA2155@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0305122223570.14641-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi!
> 
> > I'am wondering why setfont and loadkeys in setting only on first tty.
> > It works (setting font map on all six tty) in 2.{2,4}.x.
> > 
> > I'am using _radeonfb_ with rv250if, could it be the reason?
> 
> FYI, its same as vesafb here.
> 								Pavel

Try this patch. If it works I will pass it on to linus. thank you.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1077  -> 1.1078 
#	drivers/char/vt_ioctl.c	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/12	jsimmons@maxwell.earthlink.net	1.1078
# [CONSOLE] This patch fixes the problem of not being able to set the fonts on VCs other than the first one. This also was the bug that was casuing dual head (vga and mda) to lock up.
# --------------------------------------------
#
diff -Nru a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
--- a/drivers/char/vt_ioctl.c	Mon May 12 14:12:47 2003
+++ b/drivers/char/vt_ioctl.c	Mon May 12 14:12:47 2003
@@ -869,13 +869,13 @@
 		if (clin > 32)
 			return -EINVAL;
 		    
-		if (vlin)
-			vc->vc_scan_lines = vlin;
-		if (clin)
-			vc->vc_font.height = clin;
-	
-		for (i = 0; i < MAX_NR_CONSOLES; i++)
+		for (i = 0; i < MAX_NR_CONSOLES; i++) {
+			if (vlin)
+				vc_cons[i].d->vc_scan_lines = vlin;
+			if (clin)
+				vc_cons[i].d->vc_font.height = clin;
 			vc_resize(i, cc, ll);
+		}
   		return 0;
 	}
 

