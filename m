Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWB0Wpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWB0Wpl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWB0WpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:45:06 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45955 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751781AbWB0WbW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:22 -0500
Message-Id: <20060227223351.159851000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:19 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 19/39] [PATCH] it87: Fix oops on removal
Content-Disposition: inline; filename=it87-fix-oops-on-removal.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fix an oops on it87 module removal when no supported hardware was
found.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/hwmon/it87.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.15.4.orig/drivers/hwmon/it87.c
+++ linux-2.6.15.4/drivers/hwmon/it87.c
@@ -1180,7 +1180,8 @@ static int __init sm_it87_init(void)
 
 static void __exit sm_it87_exit(void)
 {
-	i2c_isa_del_driver(&it87_isa_driver);
+	if (isa_address)
+		i2c_isa_del_driver(&it87_isa_driver);
 	i2c_del_driver(&it87_driver);
 }
 

--
