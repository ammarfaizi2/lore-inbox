Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUJGQAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUJGQAE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 12:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267421AbUJGQAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 12:00:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2309 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267431AbUJGP7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:59:02 -0400
Date: Thu, 7 Oct 2004 16:58:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Fix ide-cs resource management
Message-ID: <20041007165857.D8579@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCMCIA resource management is no longer brain dead, and acts just like
any other bus subsystem.  Therefore, there's no need to play games with
the resource subsystem anymore.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/ide/legacy/ide-cs.c linux/drivers/ide/legacy/ide-cs.c
--- orig/drivers/ide/legacy/ide-cs.c	Sun Aug  8 12:13:09 2004
+++ linux/drivers/ide/legacy/ide-cs.c	Thu Oct  7 16:56:06 2004
@@ -412,12 +412,6 @@ void ide_release(dev_link_t *link)
 	/* FIXME: if this fails we need to queue the cleanup somehow
 	   -- need to investigate the required PCMCIA magic */
 	ide_unregister(info->hd);
-	/* deal with brain dead IDE resource management */
-	request_region(link->io.BasePort1, link->io.NumPorts1,
-		       info->node.dev_name);
-	if (link->io.NumPorts2)
-	    request_region(link->io.BasePort2, link->io.NumPorts2,
-			   info->node.dev_name);
     }
     info->ndev = 0;
     link->dev = NULL;

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
