Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSFQV1Q>; Mon, 17 Jun 2002 17:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317035AbSFQV1P>; Mon, 17 Jun 2002 17:27:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47350 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317034AbSFQV1M>; Mon, 17 Jun 2002 17:27:12 -0400
Subject: Re: 2.5.22 fails to compile, constants.c
From: Robert Love <rml@tech9.net>
To: Dominik Geisel <devnull@geisel.info>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com
In-Reply-To: <Pine.LNX.4.44.0206172304100.14277-100000@pc1.geisel.info>
References: <Pine.LNX.4.44.0206172304100.14277-100000@pc1.geisel.info>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Jun 2002 14:27:11 -0700
Message-Id: <1024349231.922.145.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-17 at 14:06, Dominik Geisel wrote:

> with gcc-3.1.1, kernel 2.5.22 fails to compile with the following output:
> [...]
> constants.c: In function `print_sense_internal':
> constants.c:997: `i' undeclared (first use in this function)
> constants.c:997: (Each undeclared identifier is reported only once
> constants.c:997: for each function it appears in.)

Hm, not my code but looks simple enough.

Attached patch is against 2.5.22 and fixes the problem ...

	Robert Love

diff -urN linux-2.5.22/drivers/scsi/constants.c linux/drivers/scsi/constants.c
--- linux-2.5.22/drivers/scsi/constants.c	Sun Jun 16 19:31:34 2002
+++ linux/drivers/scsi/constants.c	Mon Jun 17 14:25:02 2002
@@ -993,10 +993,14 @@
 	}
     
 #if !(CONSTANTS & CONST_SENSE)
-	printk("Raw sense data:");
-	for (i = 0; i < s; ++i) 
-		printk("0x%02x ", sense_buffer[i]);
-	printk("\n");
+	{
+		int i;
+
+		printk("Raw sense data:");
+		for (i = 0; i < s; ++i) 
+			printk("0x%02x ", sense_buffer[i]);
+		printk("\n");
+	}
 #endif
 }
 

