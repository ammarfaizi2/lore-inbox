Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129761AbQLWOPQ>; Sat, 23 Dec 2000 09:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129786AbQLWOPG>; Sat, 23 Dec 2000 09:15:06 -0500
Received: from jalon.able.es ([212.97.163.2]:18680 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129761AbQLWOO5>;
	Sat, 23 Dec 2000 09:14:57 -0500
Date: Sat, 23 Dec 2000 14:44:11 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: kees <kees@schoen.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.19pre3
Message-ID: <20001223144411.A835@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.21.0012231358230.26427-100000@schoen3.schoen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0012231358230.26427-100000@schoen3.schoen.nl>; from kees@schoen.nl on Sat, Dec 23, 2000 at 14:00:59 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2000.12.23 kees wrote:
> Hi,
> 
> Trying to build 2.2.18+pe-patch-2.2.19-3 gives:
> 
>  
> /usr/bin/cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -O2
> -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe -fno-strength-reduce
> -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686   -c -o
> ne2k-pci.o ne2k-pci.c
> ne2k-pci.c: In function `ne2k_pci_probe':
> ne2k-pci.c:246: `version' undeclared (first use in this function)
> ne2k-pci.c:246: (Each undeclared identifier is reported only once

Sorry, I checked the driver as module but not built into the kernel.
Try this patch:

--- linux-2.2.19-pre3/drivers/net/ne2k-pci.c.org        Sat Dec 23 14:40:28 2000
+++ linux-2.2.19-pre3/drivers/net/ne2k-pci.c    Sat Dec 23 14:41:09 2000
@@ -243,7 +243,7 @@
                {
                        static unsigned version_printed = 0;
                        if (version_printed++ == 0)
-                               printk(KERN_INFO "%s", version);
+                               printk(KERN_INFO "%s %s", version1,version2);
                }
 #endif


-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.2.19-pre3 #1 SMP Fri Dec 22 02:38:17 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
