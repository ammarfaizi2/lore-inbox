Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279981AbRKDP2a>; Sun, 4 Nov 2001 10:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280001AbRKDP2U>; Sun, 4 Nov 2001 10:28:20 -0500
Received: from cogito.cam.org ([198.168.100.2]:15891 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S279981AbRKDP2O>;
	Sun, 4 Nov 2001 10:28:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] vm_swap_full
Date: Sun, 4 Nov 2001 10:23:41 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011104152341.A4C289E898@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I my opinion, basing the vm_swap_full test on the size of swap is bogus.
If you have a 512M box with 128M of swap its a good idea to always release
aggressively.  If the same box has 2G of swap (has /tmp on tmpfs maybe), it
does not make sense to start the agressive release at 1G.  I suggest the 
following makes more sense.

--- linux/include/linux/swap.h.orig     Sun Nov  4 09:30:14 2001
+++ linux/include/linux/swap.h  Sun Nov  4 09:32:46 2001
@@ -80,8 +80,8 @@

 extern int nr_swap_pages;

-/* Swap 50% full? Release swapcache more aggressively.. */
-#define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
+/* Free swap less than inactive pages? Release swapcache more aggressively.. */
+#define vm_swap_full() (nr_swap_pages < nr_inactive_pages)

 extern unsigned int nr_free_pages(void);
 extern unsigned int nr_free_buffer_pages(void);

This starts aggressive swaping when the ammount of space left in swap is
less than the size of the inactive pages.

Comments?
Ed Tomlinson
