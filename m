Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWHPQP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWHPQP5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWHPQP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:15:57 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45029 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751102AbWHPQP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:15:56 -0400
Subject: PATCH: Lock tty directly in acct layer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 17:36:41 +0100
Message-Id: <1155746201.24077.364.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm1/kernel/acct.c linux-2.6.18-rc4-mm1/kernel/acct.c
--- linux.vanilla-2.6.18-rc4-mm1/kernel/acct.c	2006-08-15 15:40:19.000000000 +0100
+++ linux-2.6.18-rc4-mm1/kernel/acct.c	2006-08-15 16:03:18.000000000 +0100
@@ -483,10 +484,10 @@
 	ac.ac_ppid = current->parent->tgid;
 #endif
 
-	read_lock(&tasklist_lock);	/* pin current->signal */
+	mutex_lock(&tty_mutex);
 	ac.ac_tty = current->signal->tty ?
 		old_encode_dev(tty_devnum(current->signal->tty)) : 0;
-	read_unlock(&tasklist_lock);
+	mutex_unlock(&tty_mutex);
 
 	spin_lock_irq(&current->sighand->siglock);
 	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(cputime_to_jiffies(pacct->ac_utime)));

