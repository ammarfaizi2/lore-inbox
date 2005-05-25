Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVEYVwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVEYVwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 17:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVEYVwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 17:52:14 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:54417 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261240AbVEYVwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 17:52:08 -0400
Message-ID: <4294F35A.9090602@ens-lyon.org>
Date: Wed, 25 May 2005 23:51:22 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc5-mm1
References: <20050525134933.5c22234a.akpm@osdl.org>
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------050208030707000809020209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050208030707000809020209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/

Hi Andrew,

It looks like dlm assumes that CONFIG_DLM_DEBUG is set.
The attached patch fixes this.

Regards,
Brice

--------------050208030707000809020209
Content-Type: text/x-patch;
 name="fix-dlm-without-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-dlm-without-debug.patch"

--- linux-mm/drivers/dlm/main.c.old	2005-05-25 23:44:27.000000000 +0200
+++ linux-mm/drivers/dlm/main.c	2005-05-25 23:46:41.000000000 +0200
@@ -19,8 +19,20 @@
 #include "memory.h"
 #include "lowcomms.h"
 
+#ifdef CONFIG_DLM_DEBUG
 int dlm_register_debugfs(void);
 void dlm_unregister_debugfs(void);
+#else
+int dlm_register_debugfs(void)
+{
+	return 0;
+}
+
+void dlm_unregister_debugfs(void)
+{
+}
+#endif
+
 int dlm_node_ioctl_init(void);
 void dlm_node_ioctl_exit(void);
 

--------------050208030707000809020209--

