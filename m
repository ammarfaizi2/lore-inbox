Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUCVXzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 18:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUCVXzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 18:55:07 -0500
Received: from ozlabs.org ([203.10.76.45]:26287 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261627AbUCVXzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 18:55:03 -0500
Subject: [TRIVIAL] avoid "expr length" (improved version)
From: Rusty Russell <rusty@rustcorp.com.au>
To: kai@germaschewski.name, sam@ravnborg.org
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1079999622.6601.114.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Mar 2004 10:53:43 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From:  Martin Schaffner <maschaffner@gmx.ch>

---
  I improved my patch to avoid the "expr length" GNU-ism. It should be 
  much clearer now. It uses "wc -c" to count the letters.
  
  Thanks,
  Martin
  

--- trivial-2.6.5-rc2-bk2/Makefile.orig	2004-03-23 10:11:35.000000000 +1100
+++ trivial-2.6.5-rc2-bk2/Makefile	2004-03-23 10:11:35.000000000 +1100
@@ -652,7 +652,7 @@
 uts_len := 64
 
 define filechk_version.h
-	if expr length "$(KERNELRELEASE)" \> $(uts_len) >/dev/null ; then \
+	if ((`echo -n "$(KERNELRELEASE)" | wc -c ` > $(uts_len))); then \
 	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2; \
 	  exit 1; \
 	fi; \
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Martin Schaffner <maschaffner@gmx.ch>: [PATCH] avoid "expr length" (improved version)

