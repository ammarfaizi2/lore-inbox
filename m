Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVFIJdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVFIJdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 05:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVFIJdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 05:33:16 -0400
Received: from p-mail1.rd.francetelecom.com ([195.101.245.15]:61445 "EHLO
	p-mail1.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S262333AbVFIJcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 05:32:39 -0400
Message-ID: <42A80C5A.1030908@cr0.org>
Date: Thu, 09 Jun 2005 11:31:06 +0200
From: Julien TINNES <julien-lkml@cr0.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Alexey Dobriyan <adobriyan@gmail.com>, akpm@osdl.org,
       julien.tinnes@francetelecom.com, linux-kernel@vger.kernel.org
Subject: Re: potential-null-pointer-dereference-in-amiga-serial-driver.patch
 added to -mm tree
References: <200505310909.j4V98xBR008727@shell0.pdx.osdl.net> <200505311949.15449.adobriyan@gmail.com> <20050531122215.GA5108@logos.cnet> <20050602052108.GA8042@kroah.com> <20050603075816.GA9922@logos.cnet>
In-Reply-To: <20050603075816.GA9922@logos.cnet>
Content-Type: multipart/mixed;
 boundary="------------050702000108090309070905"
X-OriginalArrivalTime: 09 Jun 2005 09:31:29.0918 (UTC) FILETIME=[043301E0:01C56CD6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050702000108090309070905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


> OK - so better just remove the check. Julien, care to follow Greg's 
> recommendation and refresh the patch? 

Here it is.


-- 
Julien TINNES

--------------050702000108090309070905
Content-Type: text/x-patch;
 name="2.6-amiserial-nocheck.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6-amiserial-nocheck.patch"

--- linux-2.6.11.orig/drivers/char/amiserial.c	2005-05-17 10:55:03.000000000 +0200
+++ linux-2.6.11/drivers/char/amiserial.c	2005-06-09 11:29:04.000000000 +0200
@@ -867,7 +867,7 @@
 	if (serial_paranoia_check(info, tty->name, "rs_put_char"))
 		return;
 
-	if (!tty || !info->xmit.buf)
+	if (!info->xmit.buf)
 		return;
 
 	local_irq_save(flags);
@@ -916,7 +916,7 @@
 	if (serial_paranoia_check(info, tty->name, "rs_write"))
 		return 0;
 
-	if (!tty || !info->xmit.buf || !tmp_buf)
+	if (!info->xmit.buf || !tmp_buf)
 		return 0;
 
 	local_save_flags(flags);

--------------050702000108090309070905--
