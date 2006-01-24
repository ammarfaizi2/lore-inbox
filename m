Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWAXSV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWAXSV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWAXSV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:21:56 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:34056 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S932478AbWAXSVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:21:55 -0500
Date: Tue, 24 Jan 2006 18:19:45 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Export symbols so CONFIG_INPUT works as a module
Message-ID: <20060124181945.GA21955@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, modular input support fails to load with the following error:

qube:# modprobe input
input: Unknown symbol kobject_get_path
input: Unknown symbol add_input_randomness

In the short run, this can be solved by exporting these two symbols.
There have been discussions about fixing this in a different manner,
see http://www.ussg.iu.edu/hypermail/linux/kernel/0505.2/1068.html
Since this was in the days of 2.6.12-rc4 and modular input support is
still broken, I suggest these symbols to be exported for now.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 drivers/char/random.c |    2 ++
 lib/kobject.c         |    1 +
 2 files changed, 3 insertions(+)

--- a/drivers/char/random.c	2006-01-24 18:11:26.000000000 +0000
+++ b/drivers/char/random.c	2006-01-24 18:11:57.000000000 +0000
@@ -647,6 +647,8 @@
 			     (type << 4) ^ code ^ (code >> 4) ^ value);
 }
 
+EXPORT_SYMBOL(add_input_randomness);
+
 void add_interrupt_randomness(int irq)
 {
 	if (irq >= NR_IRQS || irq_timer_state[irq] == 0)
--- a/lib/kobject.c	2006-01-24 18:12:15.000000000 +0000
+++ b/lib/kobject.c	2006-01-24 18:12:43.000000000 +0000
@@ -527,6 +527,7 @@
 EXPORT_SYMBOL(kobject_init);
 EXPORT_SYMBOL(kobject_register);
 EXPORT_SYMBOL(kobject_unregister);
+EXPORT_SYMBOL(kobject_get_path);
 EXPORT_SYMBOL(kobject_get);
 EXPORT_SYMBOL(kobject_put);
 EXPORT_SYMBOL(kobject_add);

-- 
Martin Michlmayr
http://www.cyrius.com/
