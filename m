Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162978AbWLBMRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162978AbWLBMRi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 07:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162979AbWLBMRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 07:17:38 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51730 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1162978AbWLBMRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 07:17:37 -0500
Date: Sat, 2 Dec 2006 13:17:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <npiggin@suse.de>,
       dhowells@redhat.com
Subject: [-mm patch] arch/frv/kernel/futex.c must #include <linux/uaccess.h>
Message-ID: <20061202121742.GN11084@stusta.de>
References: <20061128020246.47e481eb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128020246.47e481eb.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error with 
-Werror-implicit-function-declaration
(without -Werror-implicit-function-declaration it's a link error):

<--  snip  -->

...
  CC      arch/frv/kernel/futex.o
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc6-mm2/arch/frv/kernel/futex.c: 
In function 'futex_atomic_op_inuser':
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc6-mm2/arch/frv/kernel/futex.c:203:
error: implicit declaration of function 'pagefault_disable'
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc6-mm2/arch/frv/kernel/futex.c:226: 
error: implicit declaration of function 'pagefault_enable'
make[2]: *** [arch/frv/kernel/futex.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm2/arch/frv/kernel/futex.c.old	2006-12-02 13:06:45.000000000 +0100
+++ linux-2.6.19-rc6-mm2/arch/frv/kernel/futex.c	2006-12-02 13:07:17.000000000 +0100
@@ -10,9 +10,9 @@
  */
 
 #include <linux/futex.h>
+#include <linux/uaccess.h>
 #include <asm/futex.h>
 #include <asm/errno.h>
-#include <asm/uaccess.h>
 
 /*
  * the various futex operations; MMU fault checking is ignored under no-MMU












