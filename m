Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129992AbRACOAv>; Wed, 3 Jan 2001 09:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131524AbRACOAl>; Wed, 3 Jan 2001 09:00:41 -0500
Received: from 62-6-229-89.btconnect.com ([62.6.229.89]:62213 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131368AbRACOAY>;
	Wed, 3 Jan 2001 09:00:24 -0500
Date: Wed, 3 Jan 2001 13:31:35 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-ac4] bugfix in the microcode driver.
Message-ID: <Pine.LNX.4.21.0101031330150.1025-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I sent this one-liner to Linus ages ago but he didn't notice it. The bug
is obvious -- the goal of microcode_init() is to succeed at least in one
of either devfs or misc registration.

Regards,
Tigran

--- linux/arch/i386/kernel/microcode.c	Mon Dec 11 21:42:08 2000
+++ work/arch/i386/kernel/microcode.c	Wed Jan  3 12:13:27 2001
@@ -126,6 +126,7 @@
 		printk(KERN_ERR "microcode: failed to devfs_register()\n");
 		goto out;
 	}
+	error = 0;
 	printk(KERN_INFO 
 		"IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n", 
 		MICROCODE_VERSION);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
