Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318124AbSGaMui>; Wed, 31 Jul 2002 08:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318200AbSGaMuh>; Wed, 31 Jul 2002 08:50:37 -0400
Received: from jurere.terra.com.br ([200.176.3.22]:32410 "EHLO
	jurere.terra.com.br") by vger.kernel.org with ESMTP
	id <S318124AbSGaMuh>; Wed, 31 Jul 2002 08:50:37 -0400
Date: Wed, 31 Jul 2002 09:53:37 +0000
From: Felipe W Damasio <felipewd@terra.com.br>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: __devexit_p(x) macro
Message-Id: <20020731095337.2d4ae927.felipewd@terra.com.br>
X-Mailer: Sylpheed version 0.7.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Since a lot of net drivers use the "remove" function wrapped with the
__devexit_p macro (which defines the address ONLY when CONFIG_HOTPLUG is
set), isn't the below patch needed for when drivers are compiled as
modules, so that the remove function can be set?

Felipe

--- ./init.h.orig	Wed Jul 31 09:43:44 2002
+++ ./init.h	Wed Jul 31 09:47:32 2002
@@ -183,7 +183,11 @@
 #define __devinitdata __initdata
 #define __devexit __exit
 #define __devexitdata __exitdata
+#ifdef CONFIG_MODULE
+#define __devexit_p(x)  &(x)
+#else
 #define __devexit_p(x)  0
-#endif
+#endif /* CONFIG_MODULE */
+#endif /* CONFIG_HOTPLUG */
 
 #endif /* _LINUX_INIT_H */
