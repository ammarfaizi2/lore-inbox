Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbUCUXAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUCUXAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:00:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:54012 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261457AbUCUXAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:00:04 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make inflate use less stack space with gcc3.5
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Cc: <akpm@osdl.org>, =?iso-8859-1?Q?Matt_Mackall?= <mpm@selenic.com>,
       =?iso-8859-1?Q?Linus_Torvalds?= <torvalds@osdl.org>
Message-Id: <26879984$1079909449405e1c49c64029.64633716@config20.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 26879984
X-Mailer: Webmail
X-Routing: DE
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Mon, 22 Mar 2004 00:00:01 +0100
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.147
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The gcc-3.5 patch broke building on x86_64 and possibly
others, because inflate.c does not pull in the definition
for noinline.

--- 1.7/lib/inflate.c	Sun Mar 21 09:00:58 2004
+++ edited/lib/inflate.c	Sun Mar 21 23:53:16 2004
@@ -102,6 +102,7 @@
       a repeat code (16, 17, or 18) to go across the boundary between
       the two sets of lengths.
  */
+#include <linux/compiler.h>
 
 #ifdef RCSID
 static char rcsid[] = "#Id: inflate.c,v 0.14 1993/06/10 13:27:04 jloup
Exp #";
