Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130573AbQLLL0X>; Tue, 12 Dec 2000 06:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131016AbQLLL0N>; Tue, 12 Dec 2000 06:26:13 -0500
Received: from 213-123-74-239.btconnect.com ([213.123.74.239]:16900 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130768AbQLLL0L>;
	Tue, 12 Dec 2000 06:26:11 -0500
Date: Tue, 12 Dec 2000 10:57:50 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test12] oneliner bugfix (microcode driver again)
In-Reply-To: <Pine.LNX.4.21.0012120915280.859-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0012121055090.924-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

If misc registration fails but devfs registration succeeds then we should
return 0 from microcode_init.

Regards,
Tigran

--- linux/arch/i386/kernel/microcode.c	Tue Dec 12 09:25:10 2000
+++ work/arch/i386/kernel/microcode.c	Tue Dec 12 09:55:28 2000
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
