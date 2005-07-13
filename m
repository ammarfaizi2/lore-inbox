Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVGMSra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVGMSra (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVGMSpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:45:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:8931 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262304AbVGMSor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:44:47 -0400
Date: Wed, 13 Jul 2005 11:44:17 -0700
From: Greg KH <gregkh@suse.de>
To: jesse@cola.voip.idv.tw
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [10/11] fix semaphore handling in __unregister_chrdev_region
Message-ID: <20050713184417.GL9330@kroah.com>
References: <20050713184130.GA9330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713184130.GA9330@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

This up() should be down() instead.

Signed-off-by: Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/char_dev.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12.2.orig/fs/char_dev.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/fs/char_dev.c	2005-07-13 10:54:19.000000000 -0700
@@ -139,7 +139,7 @@
 	struct char_device_struct *cd = NULL, **cp;
 	int i = major_to_index(major);
 
-	up(&chrdevs_lock);
+	down(&chrdevs_lock);
 	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
 		if ((*cp)->major == major &&
 		    (*cp)->baseminor == baseminor &&
