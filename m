Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264341AbTIJEhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 00:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbTIJEhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 00:37:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:62633 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264341AbTIJEhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 00:37:00 -0400
Date: Tue, 9 Sep 2003 21:34:39 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pdc4030: return needs value; function needs return;
Message-Id: <20030909213439.4723e2b0.rddunlap@osdl.org>
In-Reply-To: <200309100314.26305.bzolnier@elka.pw.edu.pl>
References: <20030909165414.2f0a5113.rddunlap@osdl.org>
	<200309100314.26305.bzolnier@elka.pw.edu.pl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003 03:14:26 +0200 Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:

| 
| Hi,
| 
| On Wednesday 10 of September 2003 01:54, Randy.Dunlap wrote:
| > @@ -317,7 +317,7 @@ int __init ide_probe_for_pdc4030(void)
| >  #endif
| >  		}
| >  	}
| > -#ifdef MODULE
| > +#ifndef MODULE
| >  	return 0;
| >  #endif
| >  }
| 
| This is wrong, we will now get warning for module instead of built-in.
| Proper fix is to remove this #ifdef.

Yes, sorry about that.
Here's the corrected patch for 2.6.0-test5.

--
~Randy


patch_name:	pdc4030_returns.patch
patch_version:	2003-09-09.21:27:28
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	return needs a value; function needs a return;
product:	Linux
product_versions: 260-test5
maintainer:	B.Zolnierkiewicz@elka.pw.edu.pl
diffstat:	=
 drivers/ide/legacy/pdc4030.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -Naur ./drivers/ide/legacy/pdc4030.c~pdcleg ./drivers/ide/legacy/pdc4030.c
--- ./drivers/ide/legacy/pdc4030.c~pdcleg	2003-09-08 12:50:06.000000000 -0700
+++ ./drivers/ide/legacy/pdc4030.c	2003-09-09 21:25:20.000000000 -0700
@@ -304,7 +304,7 @@
 
 #ifndef MODULE
 	if (enable_promise_support == 0)
-		return;
+		return 0;
 #endif
 
 	for (index = 0; index < MAX_HWIFS; index++) {
@@ -317,9 +317,7 @@
 #endif
 		}
 	}
-#ifdef MODULE
 	return 0;
-#endif
 }
 
 static void __exit release_pdc4030(ide_hwif_t *hwif, ide_hwif_t *mate)
