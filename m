Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275024AbTHQGNl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 02:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275053AbTHQGNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 02:13:40 -0400
Received: from codepoet.org ([166.70.99.138]:53903 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S275024AbTHQGNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 02:13:10 -0400
Date: Sun, 17 Aug 2003 00:13:12 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2/8 Backport recent 2.6 IDE updates to 2.4.x
Message-ID: <20030817061312.GC17621@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andries Brouwer <aebr@win.tue.nl>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some accounting problems where values were
unconditionally incremented,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--- linux-2.4.22-pre.orig/drivers/ide/ide-disk.c	2003-06-13 08:51:33.000000000 -0600
+++ linux/drivers/ide/ide-disk.c	2003-08-16 19:52:24.000000000 -0600
@@ -1029,8 +1029,8 @@
 		     | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
 		     | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
 		     | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+		addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	}
-	addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	return addr;
 }
 
@@ -1057,8 +1057,8 @@
 			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
 			    (args.tfRegister[IDE_SECTOR_OFFSET]);
 		addr = ((__u64)high << 24) | low;
+		addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	}
-	addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	return addr;
 }
 
@@ -1089,8 +1089,8 @@
 			 | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
 			 | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
 			 | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+		addr_set++;
 	}
-	addr_set++;
 	return addr_set;
 }
 
@@ -1124,6 +1124,7 @@
 			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
 			    (args.tfRegister[IDE_SECTOR_OFFSET]);
 		addr_set = ((__u64)high << 24) | low;
+		addr_set++;
 	}
 	return addr_set;
 }
