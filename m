Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVGJWyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVGJWyX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVGJThR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:37:17 -0400
Received: from ns2.suse.de ([195.135.220.15]:55260 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262039AbVGJTg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:27 -0400
Date: Sun, 10 Jul 2005 19:36:27 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 79/82] move KERNEL_VERSION from linux/version.h to linux/utsname.h
Message-ID: <20050710193627.79.OiyzkS4369.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

KERNEL_VERSION is a static macro, it doesnt belong to a changing header file.
stuff which relies on UTS_RELEASE or LINUX_VERSION_CODE does already
include linux/version.h
some drivers use KERNEL_VERSION for different purposes

Signed-off-by: Olaf Hering <olh@suse.de>

Makefile                |    1 -
include/linux/utsname.h |    3 +++
2 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.13-rc2-mm1/include/linux/utsname.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/include/linux/utsname.h
+++ linux-2.6.13-rc2-mm1/include/linux/utsname.h
@@ -33,4 +33,7 @@ struct new_utsname {
extern struct new_utsname system_utsname;

extern struct rw_semaphore uts_sem;
+
+#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
+
#endif
Index: linux-2.6.13-rc2-mm1/Makefile
===================================================================
--- linux-2.6.13-rc2-mm1.orig/Makefile
+++ linux-2.6.13-rc2-mm1/Makefile
@@ -836,7 +836,6 @@ define filechk_version.h
fi;  	(echo #define UTS_RELEASE "$(KERNELRELEASE)";  	  echo #define LINUX_VERSION_CODE `expr $(VERSION) \* 65536 + $(PATCHLEVEL) \* 256 + $(SUBLEVEL)`; -	 echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))';  	)
endef

