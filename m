Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264253AbUDVWbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbUDVWbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 18:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264663AbUDVWbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 18:31:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:8112 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264253AbUDVWbD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 18:31:03 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core fixes for 2.6.6-rc2
In-Reply-To: <10826730482684@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 22 Apr 2004 15:30:48 -0700
Message-Id: <10826730481875@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1928, 2004/04/22 14:36:55-07:00, lkml@lievin.net

[PATCH] tipar char driver: wrong timeout value

this patch (2.4 & 2.6) fixes a bug about the timeout value. The formula
used to calculate jiffies from timeout is wrong.
The new formula is ok and takes care of integer computation/rounding.
There is the same bug in the tiglusb.c module which will be fixed by another
patch.


 drivers/char/tipar.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/char/tipar.c b/drivers/char/tipar.c
--- a/drivers/char/tipar.c	Thu Apr 22 15:27:12 2004
+++ b/drivers/char/tipar.c	Thu Apr 22 15:27:12 2004
@@ -121,7 +121,7 @@
 
 /* ----- global defines ----------------------------------------------- */
 
-#define START(x) { x=jiffies+HZ/(timeout/10); }
+#define START(x) { x = jiffies + (HZ * timeout) / 10; }
 #define WAIT(x)  { \
   if (time_before((x), jiffies)) return -1; \
   if (need_resched()) schedule(); }

