Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031880AbWLGJLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031880AbWLGJLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031879AbWLGJLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:11:14 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:32776 "HELO
	smtp102.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1031878AbWLGJLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:11:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=SLMRqwYz/NT/34DtpgeTGlOpL86P8+wLyv5RMPCmIrbGKIVurmfMeHFUt9m90K5okcXVWWn1tdKowGnVocY1gOPvsFkgo6NMIyJeDb8b398Mtsi5xy7ZiYcHuKQ/sY3rU829lUFYEDKEyA/nQz5CTwLJuFRLYkwsUVI2kCeuvTM=  ;
X-YMail-OSG: gLey6W8VM1lrnPl6bNCAJuK4_dG5aaxiZjt8iI7CCkkimxp8OHGPFnqAR8ijh3eGLU6Jk1hgKLshCKNDTuOE_5fVudzv04BTwWNM7_muoGP2RwecQtsh
Date: Thu, 07 Dec 2006 01:11:09 -0800
From: David Brownell <david-b@pacbell.net>
To: wim@iguana.be, linux-kernel@vger.kernel.org
Subject: [patch 2.6.19-git] watchdog:  omap_wdt build fix
Cc: tony@atomide.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061207091109.6AF1C1E8CE0@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent driver model changes affected "miscdev" and broke
the build for the OMAP watchdog timer; fixed by this patch.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk/drivers/char/watchdog/omap_wdt.c
===================================================================
--- osk.orig/drivers/char/watchdog/omap_wdt.c	2006-10-16 19:24:18.000000000 -0700
+++ osk/drivers/char/watchdog/omap_wdt.c	2006-12-05 19:43:53.000000000 -0800
@@ -290,7 +290,7 @@ static int __init omap_wdt_probe(struct 
 	omap_wdt_disable();
 	omap_wdt_adjust_timeout(timer_margin);
 
-	omap_wdt_miscdev.dev = &pdev->dev;
+	omap_wdt_miscdev.parent = &pdev->dev;
 	ret = misc_register(&omap_wdt_miscdev);
 	if (ret)
 		goto fail;
