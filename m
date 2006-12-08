Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425071AbWLHH1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425071AbWLHH1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 02:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425072AbWLHH1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 02:27:34 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:47435 "HELO
	smtp107.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1425071AbWLHH1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 02:27:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=BMv2hHjM6TEc59B9DzZHRHE/mZFg+YEiCjxuGA++Y5aeTBqHsufL7+wdism7UUmRZhmyKG5f8oHsPyKgY+HxyAOMrdrFDjtIXt7VBk0RobInvPXl0noCwFipML/bhJtsYDvC+7igvQ2o3zBI+GqVERfkAmzM9EoLUI/eYDWoWpA=  ;
X-YMail-OSG: NdqqMokVM1l536X7p7y4UTWq8eHLKQIh0C7BfpJLzUUPhT.1QrLoNH59X57adj1DKKlQ7bOF5yccF2dTE6iSvbHrX_H.I3seVvzbidxRXgW3vgbXw363AHdInYJrYekDxoKU4JWHQgBmuoNZWzJPmH_hWaRxb844bWTSid94TYVlSZe4KtRwf8totSE-
Date: Thu, 07 Dec 2006 23:27:22 -0800
From: David Brownell <david-b@pacbell.net>
To: wim@iguana.be, linux-kernel@vger.kernel.org
Subject: [patch 2.6.19-git] watchdog:  at91_wdt build fix
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061208072722.85DCE1EB27F@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent miscdev changes broke various drivers, so they won't build.
This fixes another one.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: at91/drivers/char/watchdog/at91rm9200_wdt.c
===================================================================
--- at91.orig/drivers/char/watchdog/at91rm9200_wdt.c	2006-12-07 21:37:00.000000000 -0800
+++ at91/drivers/char/watchdog/at91rm9200_wdt.c	2006-12-07 21:38:28.000000000 -0800
@@ -203,9 +203,9 @@ static int __init at91wdt_probe(struct p
 {
 	int res;
 
-	if (at91wdt_miscdev.dev)
+	if (at91wdt_miscdev.parent)
 		return -EBUSY;
-	at91wdt_miscdev.dev = &pdev->dev;
+	at91wdt_miscdev.parent = &pdev->dev;
 
 	res = misc_register(&at91wdt_miscdev);
 	if (res)
@@ -221,7 +221,7 @@ static int __exit at91wdt_remove(struct 
 
 	res = misc_deregister(&at91wdt_miscdev);
 	if (!res)
-		at91wdt_miscdev.dev = NULL;
+		at91wdt_miscdev.parent = NULL;
 
 	return res;
 }
