Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSFQNiw>; Mon, 17 Jun 2002 09:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSFQNiv>; Mon, 17 Jun 2002 09:38:51 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:48145 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S313537AbSFQNir>;
	Mon, 17 Jun 2002 09:38:47 -0400
Message-ID: <3D0DE42C.E2F8C328@torque.net>
Date: Mon, 17 Jun 2002 09:29:16 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jason Straight <jason@blazeconnect.net>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: constants.c fix for 2.5.22 compile error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Straight wrote:
> line 997 in /drivers/scsi/constants.c tries to use 
> i without declaring it.
> add i to the int declaration in 910 seems to fix.

This occurs when CONFIG_SCSI_CONSTANTS is not set in
the .config file.

BTW Defining CONFIG_SCSI_CONSTANTS adds about 30KB to
the size of the kernel (not 12 KB as indicated during
configuration).

Doug Gilbert

--- linux/drivers/scsi/constants.c	Mon Jun 17 08:44:48 2002
+++ linux/drivers/scsi/constants.c2522fix	Mon Jun 17 09:20:48 2002
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
 

