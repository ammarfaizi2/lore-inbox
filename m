Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWHHRr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWHHRr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWHHRrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:47:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16064 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030206AbWHHRry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:47:54 -0400
Subject: PATCH: Voyager, tty locking
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       James.Bottomley@HansenPartnership.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Aug 2006 19:07:49 +0100
Message-Id: <1155060469.5729.109.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voyager fiddles with current->signal.tty without locking. It turns out
that the code in question has already cleared current->signal.tty
correctly because daemonize() does the right thing already.

The signal handling also appears to be incorrect as it does an
unprotected sigfillset that also appears unneccessary. As I don't have a
bowtie and am therefore not a qualified voyager maintainer I leave that
to James.

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.18-rc3-mm2/arch/i386/mach-voyager/voyager_thread.c	2006-08-07 16:15:02.000000000 +0100
+++ linux-2.6.18-rc3-mm2/arch/i386/mach-voyager/voyager_thread.c	2006-08-08 18:19:11.496378872 +0100
@@ -130,7 +130,6 @@
 	init_timer(&wakeup_timer);
 
 	sigfillset(&current->blocked);
-	current->signal->tty = NULL;
 
 	printk(KERN_NOTICE "Voyager starting monitor thread\n");
 

