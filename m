Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWDOSOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWDOSOr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 14:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWDOSOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 14:14:47 -0400
Received: from xenotime.net ([66.160.160.81]:2515 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030291AbWDOSOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 14:14:46 -0400
Date: Sat, 15 Apr 2006 11:17:12 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, sam@ravnborg.org
Subject: [PATCH] modpost: relax driver data name
Message-Id: <20060415111712.311372aa.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

modpost:  Relax driver data name from *_driver to *driver.
This fixes the 26 section mismatch warnings in drivers/ide/pci.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 scripts/mod/modpost.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2617-rc1g8.orig/scripts/mod/modpost.c
+++ linux-2617-rc1g8/scripts/mod/modpost.c
@@ -487,14 +487,14 @@ static int strrcmp(const char *s, const 
  *   atsym   =__param*
  *
  * Pattern 2:
- *   Many drivers utilise a *_driver container with references to
+ *   Many drivers utilise a *driver container with references to
  *   add, remove, probe functions etc.
  *   These functions may often be marked __init and we do not want to
  *   warn here.
  *   the pattern is identified by:
  *   tosec   = .init.text | .exit.text | .init.data
  *   fromsec = .data
- *   atsym = *_driver, *_template, *_sht, *_ops, *_probe, *probe_one
+ *   atsym = *driver, *_template, *_sht, *_ops, *_probe, *probe_one
  **/
 static int secref_whitelist(const char *tosec, const char *fromsec,
 			    const char *atsym)
@@ -502,7 +502,7 @@ static int secref_whitelist(const char *
 	int f1 = 1, f2 = 1;
 	const char **s;
 	const char *pat2sym[] = {
-		"_driver",
+		"driver",
 		"_template", /* scsi uses *_template a lot */
 		"_sht",      /* scsi also used *_sht to some extent */
 		"_ops",


---
