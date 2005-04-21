Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVDUP1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVDUP1L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 11:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVDUP1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 11:27:11 -0400
Received: from hermes.domdv.de ([193.102.202.1]:35848 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261423AbVDUP1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 11:27:08 -0400
Message-ID: <4267C64C.4000608@domdv.de>
Date: Thu, 21 Apr 2005 17:27:08 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: Linux 2.6.12-rc3: Oops on IDE flash disk eject
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <4267B78D.9000408@domdv.de>
In-Reply-To: <4267B78D.9000408@domdv.de>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes the Oops though I don't know if this is the
correct solution.

--- linux-2.6.12-rc3/drivers/ide/ide.c.ast
+++ linux-2.6.12-rc3/drivers/ide/ide.c
@@ -2082,7 +2082,8 @@
 static int ide_drive_remove(struct device * dev)
 {
 	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
-	DRIVER(drive)->cleanup(drive);
+	if(DRIVER(drive))
+		DRIVER(drive)->cleanup(drive);
 	return 0;
 }


-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
