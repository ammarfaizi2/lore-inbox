Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318756AbSIKMwr>; Wed, 11 Sep 2002 08:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318762AbSIKMwH>; Wed, 11 Sep 2002 08:52:07 -0400
Received: from dp.samba.org ([66.70.73.150]:39397 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318756AbSIKMwA>;
	Wed, 11 Sep 2002 08:52:00 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15743.15573.244173.684143@argo.ozlabs.ibm.com>
Date: Wed, 11 Sep 2002 22:53:41 +1000 (EST)
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kd_mksound inclusion on PPC
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

On PPC, we have many platforms which don't have an ISA timer chip and
on which therefore the default _kd_mksound does the wrong thing.  This
patch changes drivers/char/vt.c so we can use a config option,
CONFIG_PPC_ISATIMER, to control whether we get the default _kd_mksound
or not, rather than including it on all PPC machines.  (The
CONFIG_PPC_ISATIMER is derived from the user's choice of platform
support, we don't ask about it explicitly.)

Please apply this to your tree.

Thanks,
Paul.

diff -urN for-marcelo-ppc/drivers/char/vt.c linuxppc_2_4/drivers/char/vt.c
--- linux-2.4/drivers/char/vt.c	Wed Aug 28 08:40:07 2002
+++ linuxppc_2_4/drivers/char/vt.c	Thu Aug 29 13:11:39 2002
@@ -90,7 +90,7 @@
  * comments - KDMKTONE doesn't put the process to sleep.
  */
 
-#if defined(__i386__) || defined(__alpha__) || defined(__powerpc__) \
+#if defined(__i386__) || defined(__alpha__) || defined(CONFIG_PPC_ISATIMER) \
     || (defined(__mips__) && defined(CONFIG_ISA)) \
     || (defined(__arm__) && defined(CONFIG_HOST_FOOTBRIDGE)) \
     || defined(__x86_64__)
