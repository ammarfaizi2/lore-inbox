Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTJFNoa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 09:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbTJFNoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 09:44:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11528 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262092AbTJFNnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 09:43:31 -0400
Date: Mon, 6 Oct 2003 14:43:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix sysrq-t free stack output
Message-ID: <20031006144328.A24910@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that we're attempting to work out the free stack size using two
unrelated pointers for the lowest address of the stack.  Fix this to use
the correct pointer.

--- orig/kernel/sched.c	Sun Sep 28 09:55:57 2003
+++ linux/kernel/sched.c	Mon Oct  6 14:40:37 2003
@@ -2465,7 +2465,7 @@
 		unsigned long * n = (unsigned long *) (p->thread_info+1);
 		while (!*n)
 			n++;
-		free = (unsigned long) n - (unsigned long)(p+1);
+		free = (unsigned long) n - (unsigned long)(p->thread_info+1);
 	}
 	printk("%5lu %5d %6d ", free, p->pid, p->parent->pid);
 	if ((relative = eldest_child(p)))

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
