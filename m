Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWCBXbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWCBXbI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbWCBXbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:31:07 -0500
Received: from ns2.suse.de ([195.135.220.15]:36054 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751027AbWCBXbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:31:06 -0500
Date: Fri, 3 Mar 2006 00:30:56 +0100
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Oskar Senft <o.senft@sirrix.com>
Subject: [PATCH] Fix refcounting problem with ttyIx devices
Message-ID: <20060302233056.GB17717@pingi.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Oskar Senft <o.senft@sirrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15.7-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the same ttyIx device was opened by two processes the module
was not released and so the usage count went never to zero again.
This oneliner fix the issue.

Signed-off-by: Oskar Senft <o.senft@sirrix.com>
Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/i4l/isdn_tty.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

56365966816e47951a624c10ad2c24dfa979ee0e
diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index 3936336..aeaa1db 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1682,6 +1682,7 @@ isdn_tty_close(struct tty_struct *tty, s
 #ifdef ISDN_DEBUG_MODEM_OPEN
 		printk(KERN_DEBUG "isdn_tty_close after info->count != 0\n");
 #endif
+		module_put(info->owner);
 		return;
 	}
 	info->flags |= ISDN_ASYNC_CLOSING;

-- 
Karsten Keil
SuSE Labs
ISDN development
