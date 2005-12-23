Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161122AbVLWWvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbVLWWvQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbVLWWtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:49:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:21200 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161113AbVLWWtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:40 -0500
Date: Fri, 23 Dec 2005 14:48:44 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       jason.wessel@windriver.com, bunk@stusta.de
Subject: [patch 16/19] kernel/params.c: fix sysfs access with CONFIG_MODULES=n
Message-ID: <20051223224844.GP19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="kernel-params.c-fix-sysfs-access-with-config_modules-n.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jason Wessel <jason.wessel@windriver.com>

All the work was done to setup the file and maintain the file handles but
the access functions were zeroed out due to the #ifdef.  Removing the
#ifdef allows full access to all the parameters when CONFIG_MODULES=n.

akpm: put it back again, but use CONFIG_SYSFS instead.

This patch has already been included in Linus' tree.


Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 kernel/params.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.4.orig/kernel/params.c
+++ linux-2.6.14.4/kernel/params.c
@@ -618,7 +618,7 @@ static void __init param_sysfs_builtin(v
 
 
 /* module-related sysfs stuff */
-#ifdef CONFIG_MODULES
+#ifdef CONFIG_SYSFS
 
 #define to_module_attr(n) container_of(n, struct module_attribute, attr);
 #define to_module_kobject(n) container_of(n, struct module_kobject, kobj);

--
