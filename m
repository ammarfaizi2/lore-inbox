Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTILTNP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbTILTNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:13:15 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:5256 "EHLO fed1mtao02.cox.net")
	by vger.kernel.org with ESMTP id S261807AbTILTNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:13:09 -0400
Message-ID: <3F621AC4.4070507@cox.net>
Date: Fri, 12 Sep 2003 12:13:08 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] new ioctl type checking causes gcc warning
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Submitted by: Kevin P. Fleming (kpfleming at cox dot net)
Date: 2003-09-12
Initial Package Version: 2.6.0-test5
Origin: Kevin P. Fleming (kpfleming at cox dot net)
Description: The definition of __invalid_size_argument_for_IOC is signed,
              which causes an signed/unsigned comparison error to be
              emitted by GCC (at least for 3.3.1).

--- linux-2.6.0-test5/include/asm-i386/ioctl.h~	Mon Sep  8 12:49:52 2003
+++ linux-2.6.0-test5/include/asm-i386/ioctl.h	Fri Sep 12 11:58:41 2003
@@ -53,7 +53,7 @@
  	 ((size) << _IOC_SIZESHIFT))

  /* provoke compile error for invalid uses of size argument */
-extern int __invalid_size_argument_for_IOC;
+extern unsigned int __invalid_size_argument_for_IOC;
  #define _IOC_TYPECHECK(t) \
  	((sizeof(t) == sizeof(t[1]) && \
  	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \

