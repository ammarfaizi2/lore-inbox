Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281783AbRKVVXx>; Thu, 22 Nov 2001 16:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281784AbRKVVXd>; Thu, 22 Nov 2001 16:23:33 -0500
Received: from dorf.wh.uni-dortmund.de ([129.217.255.136]:61707 "HELO
	mail.dorf.wh.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S281783AbRKVVXW>; Thu, 22 Nov 2001 16:23:22 -0500
Date: Thu, 22 Nov 2001 22:22:21 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Question about balance_classzone in mm/page_alloc.c
Message-ID: <20011122222220.A2355@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel Developers,

this question could probably be answered bt Andrea Arcangeli ?

I added a prink to balance_classzone in 2.4.15-pre9.
The message is not accurate because I moved it there,
but anyway ...

--- linux-2.4.15-9/mm/page_alloc.c	Thu Nov 22 19:53:46 2001
+++ work-2.4.15-9/mm/page_alloc.c	Thu Nov 22 22:02:15 2001
@@ -251,6 +251,8 @@
 		local_pages = &current->local_pages;
 
 		if (likely(__freed)) {
+                        printk(KERN_DEBUG "zone_balance: %d pages freed\n", current->nr_local_pages);
+
 			/* pick from the last inserted so we're lifo */
 			entry = local_pages->next;
 			do {

I bootet with mem=64M and started KDE/Konqueror and did a
bonnie++ run with 256M filesize. (I did not let it finish though).

The count of current->nr_local_pages from syslog shows always
'1'. Maybe I don't understand the code, but balance_classzone is
very often called (>20 times during one second according to syslog).
I could append syslog output, but it's pretty boring.

My question is, whats the logic behind those nr_local_pages
and the lifo while loop, when it's always called for one page ?

I had to kill bonnie++ and KDE because the box was absolutely
trashing and did not respond to anything.

thanks for clarifying.
Patrick
