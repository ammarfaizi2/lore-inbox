Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265611AbUABQNl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 11:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265618AbUABQNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 11:13:41 -0500
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:55083
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S265611AbUABQNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 11:13:09 -0500
Date: Fri, 2 Jan 2004 11:13:06 -0500
From: Omkhar Arasaratnam <omkhar@rogers.com>
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       randy@kerneljanitors.org
Subject: [PATCH] drivers/cdrom/cdu31c.c check_region() fix
Message-ID: <20040102161306.GA7122@omkhar.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.192.237.88] using ID <omkhar@rogers.com> at Fri, 2 Jan 2004 11:11:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a check_region fix for cdu31a

As usual feel free to poke / prod / suggest / include this patch as you see fit


--- linux-clean/drivers/cdrom/cdu31a.c.org	2004-01-02 10:54:01.000000000 -0500
+++ linux-clean/drivers/cdrom/cdu31a.c	2004-01-02 11:03:56.000000000 -0500
@@ -3345,7 +3345,7 @@
 		i = 0;
 		while ((cdu31a_addresses[i].base != 0)
 		       && (!drive_found)) {
-			if (check_region(cdu31a_addresses[i].base, 4)) {
+			if (!request_region(cdu31a_addresses[i].base, 4,"cdu31a")) {
 				i++;
 				continue;
 			}
@@ -3359,6 +3359,7 @@
 				cdu31a_irq = cdu31a_addresses[i].int_num;
 			} else {
 				i++;
+				release_region(cdu31a_address[i].base,4);
 			}
 		}
 	}
@@ -3366,9 +3367,6 @@
 	if (!drive_found)
 		goto errout3;
 
-	if (!request_region(cdu31a_port, 4, "cdu31a"))
-		goto errout3;
-
 	if (register_blkdev(MAJOR_NR, "cdu31a"))
 		goto errout2;

O
