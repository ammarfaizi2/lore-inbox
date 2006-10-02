Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWJBQC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWJBQC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWJBQC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:02:26 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:43883 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965006AbWJBQCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:02:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=YLGiY1jOqCVROzK7yXG2wSbnyv6d6bhCg0xqOqOsbEg0ka70Lo+n/76XDOqV4MiHnvm2gYrIJAUSbS9Er7it+E7PfnnXSQ5WPYqBKKsInHi9XNFWvWKwdTu4rtxTYtk2xFeZPrcjfQi75fVVkAcF2hr3RveG/PNjGdGRJYNCYWA=  ;
From: David Brownell <david-b@pacbell.net>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [patch 2.6.18-git] ide-cs (CompactFlash) driver, rm irq warning
Date: Mon, 2 Oct 2006 09:02:19 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610020902.20030.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Git rid of the runtime warning about pcmcia not supporting
exclusive IRQs, so "the driver needs updating".

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- osk.orig/drivers/ide/legacy/ide-cs.c	2006-09-28 19:27:51.000000000 -0700
+++ osk/drivers/ide/legacy/ide-cs.c	2006-10-02 08:25:21.000000000 -0700
@@ -120,7 +120,7 @@ static int ide_probe(struct pcmcia_devic
     link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
     link->io.Attributes2 = IO_DATA_PATH_WIDTH_8;
     link->io.IOAddrLines = 3;
-    link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
+    link->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING;
     link->irq.IRQInfo1 = IRQ_LEVEL_ID;
     link->conf.Attributes = CONF_ENABLE_IRQ;
     link->conf.IntType = INT_MEMORY_AND_IO;
