Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131181AbQKUXws>; Tue, 21 Nov 2000 18:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130510AbQKUXwj>; Tue, 21 Nov 2000 18:52:39 -0500
Received: from 213-120-136-183.btconnect.com ([213.120.136.183]:49924 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131181AbQKUXwd>;
	Tue, 21 Nov 2000 18:52:33 -0500
Date: Tue, 21 Nov 2000 23:22:52 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test11] show_mem() to dump free pages
In-Reply-To: <Pine.LNX.4.21.0011212210270.780-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0011212321400.950-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, Tigran Aivazian wrote:

> Hi Linus,
> 
> In arch/i386/mm/init.c:show_mem() we calculate the number of free pages
> but don't printk it out. Therefore, we must either a) remove the variable
> and the calculation or b) make use of it. I think b) is obviously better.
> 
> The patch below was tested under 2.4.0-test11.

apparently, IA64, SuperH and S390 architectures are just as broken as i386
wrt not showing 'free'in show_mem() so here is more complete patch which
covers all architectures:

--- linux/arch/ia64/mm/init.c	Tue Oct 10 01:54:56 2000
+++ work/arch/ia64/mm/init.c	Tue Nov 21 23:18:31 2000
@@ -264,6 +264,7 @@
 			shared += page_count(mem_map + i) - 1;
 	}
 	printk("%d pages of RAM\n", total);
+	printk("%d free pages\n", free);
 	printk("%d reserved pages\n", reserved);
 	printk("%d pages shared\n", shared);
 	printk("%d pages swap cached\n", cached);
--- linux/arch/s390/mm/init.c	Mon Oct 16 20:58:51 2000
+++ work/arch/s390/mm/init.c	Tue Nov 21 23:19:51 2000
@@ -211,6 +211,7 @@
                         shared += atomic_read(&mem_map[i].count) - 1;
         }
         printk("%d pages of RAM\n",total);
+        printk("%d free pages\n",free);
         printk("%d reserved pages\n",reserved);
         printk("%d pages shared\n",shared);
         printk("%d pages swap cached\n",cached);
--- linux/arch/sh/mm/init.c	Mon Oct 16 20:58:51 2000
+++ work/arch/sh/mm/init.c	Tue Nov 21 23:20:28 2000
@@ -169,6 +169,7 @@
 			shared += page_count(mem_map+i) - 1;
 	}
 	printk("%d pages of RAM\n",total);
+	printk("%d free pages\n",free);
 	printk("%d reserved pages\n",reserved);
 	printk("%d pages shared\n",shared);
 	printk("%d pages swap cached\n",cached);
--- arch/i386/mm/init.c.0	Tue Nov 21 22:00:52 2000
+++ arch/i386/mm/init.c	Tue Nov 21 22:00:36 2000
@@ -221,6 +221,7 @@
 	}
 	printk("%d pages of RAM\n", total);
 	printk("%d pages of HIGHMEM\n",highmem);
+	printk("%d free pages\n",free);
 	printk("%d reserved pages\n",reserved);
 	printk("%d pages shared\n",shared);
 	printk("%d pages swap cached\n",cached);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
