Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVADQDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVADQDf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVADQDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:03:35 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:30987 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261696AbVADQDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:03:25 -0500
Date: Tue, 4 Jan 2005 23:56:50 +0800 (WST)
From: raven@themaw.net
To: Marcello Tosatti <marcelo.tosatti@cyclades.com>
cc: Francesco Paolo Lovergine <frankie@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] autofs4 2.4.29-pre3 add missing compat ioctls
Message-ID: <Pine.LNX.4.61.0501042309380.20305@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-98.2, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, RCVD_IN_ORBS,
	RCVD_IN_OSIRUSOFT_COM, UPPERCASE_50_75, USER_AGENT_PINE,
	USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcello,

Can you merge this into the 2.4 kernel please.

It is a patch to add compat ioctls for autofs4 for architectures that 
need them. They are used by autofs version 4.1.0 and above (current 
version soon to be 4.1.4). So they have been missing for some time now.

This will also allow poeple to use my autofs4 module build package 
without needing to patch and rebuild their kernel.

Regards
Ian

--- linux-2.4.29-pre3/include/linux/auto_fs4.h.compat-ioctl	2005-01-04 23:04:37.000000000 +0800
+++ linux-2.4.29-pre3/include/linux/auto_fs4.h	2005-01-04 23:07:16.000000000 +0800
@@ -41,7 +41,10 @@
  	struct autofs_packet_expire_multi expire_multi;
  };

-#define AUTOFS_IOC_EXPIRE_MULTI _IOW(0x93,0x66,int)
-
+#define AUTOFS_IOC_EXPIRE_MULTI		_IOW(0x93,0x66,int)
+#define AUTOFS_IOC_PROTOSUBVER		_IOR(0x93,0x67,int)
+#define AUTOFS_IOC_ASKREGHOST		_IOR(0x93,0x68,int)
+#define AUTOFS_IOC_TOGGLEREGHOST	_IOR(0x93,0x69,int)
+#define AUTOFS_IOC_ASKUMOUNT		_IOR(0x93,0x70,int)

  #endif /* _LINUX_AUTO_FS4_H */
--- linux-2.4.29-pre3/arch/x86_64/ia32/ia32_ioctl.c.compat-ioctl	2005-01-04 23:05:02.000000000 +0800
+++ linux-2.4.29-pre3/arch/x86_64/ia32/ia32_ioctl.c	2005-01-04 23:07:16.000000000 +0800
@@ -4099,6 +4099,10 @@
  COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOVER)
  COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE)
  COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE_MULTI)
+COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOSUBVER)
+COMPATIBLE_IOCTL(AUTOFS_IOC_ASKREGHOST)
+COMPATIBLE_IOCTL(AUTOFS_IOC_TOGGLEREGHOST)
+COMPATIBLE_IOCTL(AUTOFS_IOC_ASKUMOUNT)
  /* DEVFS */
  COMPATIBLE_IOCTL(DEVFSDIOC_GET_PROTO_REV)
  COMPATIBLE_IOCTL(DEVFSDIOC_SET_EVENT_MASK)
--- linux-2.4.29-pre3/arch/ppc64/kernel/ioctl32.c.compat-ioctl	2005-01-04 23:05:17.000000000 +0800
+++ linux-2.4.29-pre3/arch/ppc64/kernel/ioctl32.c	2005-01-04 23:07:16.000000000 +0800
@@ -4278,6 +4278,11 @@
  COMPATIBLE_IOCTL(AUTOFS_IOC_CATATONIC),
  COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOVER),
  COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE),
+COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE_MULTI),
+COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOSUBVER),
+COMPATIBLE_IOCTL(AUTOFS_IOC_ASKREGHOST),
+COMPATIBLE_IOCTL(AUTOFS_IOC_TOGGLEREGHOST),
+COMPATIBLE_IOCTL(AUTOFS_IOC_ASKUMOUNT),
  /* DEVFS */
  COMPATIBLE_IOCTL(DEVFSDIOC_GET_PROTO_REV),
  COMPATIBLE_IOCTL(DEVFSDIOC_SET_EVENT_MASK),
--- linux-2.4.29-pre3/arch/sparc64/kernel/ioctl32.c.compat-ioctl	2005-01-04 23:05:53.000000000 +0800
+++ linux-2.4.29-pre3/arch/sparc64/kernel/ioctl32.c	2005-01-04 23:07:16.000000000 +0800
@@ -4918,6 +4918,10 @@
  COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOVER)
  COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE)
  COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE_MULTI)
+COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOSUBVER)
+COMPATIBLE_IOCTL(AUTOFS_IOC_ASKREGHOST)
+COMPATIBLE_IOCTL(AUTOFS_IOC_TOGGLEREGHOST)
+COMPATIBLE_IOCTL(AUTOFS_IOC_ASKUMOUNT)
  /* DEVFS */
  COMPATIBLE_IOCTL(DEVFSDIOC_GET_PROTO_REV)
  COMPATIBLE_IOCTL(DEVFSDIOC_SET_EVENT_MASK)
--- linux-2.4.29-pre3/arch/mips64/kernel/ioctl32.c.compat-ioctl	2005-01-04 23:06:10.000000000 +0800
+++ linux-2.4.29-pre3/arch/mips64/kernel/ioctl32.c	2005-01-04 23:07:16.000000000 +0800
@@ -2352,6 +2352,10 @@
  	IOCTL32_HANDLER(AUTOFS_IOC_SETTIMEOUT32, ioc_settimeout),
  	IOCTL32_DEFAULT(AUTOFS_IOC_EXPIRE),
  	IOCTL32_DEFAULT(AUTOFS_IOC_EXPIRE_MULTI),
+	IOCTL32_DEFAULT(AUTOFS_IOC_PROTSUBVER),
+	IOCTL32_DEFAULT(AUTOFS_IOC_ASKREGHOST),
+	IOCTL32_DEFAULT(AUTOFS_IOC_TOGGLEREGHOST),
+	IOCTL32_DEFAULT(AUTOFS_IOC_ASKUMOUNT),

  	/* DEVFS */
  	IOCTL32_DEFAULT(DEVFSDIOC_GET_PROTO_REV),
--- linux-2.4.29-pre3/arch/parisc/kernel/ioctl32.c.compat-ioctl	2005-01-04 23:06:35.000000000 +0800
+++ linux-2.4.29-pre3/arch/parisc/kernel/ioctl32.c	2005-01-04 23:07:16.000000000 +0800
@@ -3375,6 +3375,11 @@
  COMPATIBLE_IOCTL(AUTOFS_IOC_CATATONIC)
  COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOVER)
  COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE)
+COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE_MULTI)
+COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOSUBVER)
+COMPATIBLE_IOCTL(AUTOFS_IOC_ASKREGHOST)
+COMPATIBLE_IOCTL(AUTOFS_IOC_TOGGLEREGHOST)
+COMPATIBLE_IOCTL(AUTOFS_IOC_ASKUMOUNT)
  /* DEVFS */
  COMPATIBLE_IOCTL(DEVFSDIOC_GET_PROTO_REV)
  COMPATIBLE_IOCTL(DEVFSDIOC_SET_EVENT_MASK)
