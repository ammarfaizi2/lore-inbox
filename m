Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVGUTC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVGUTC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 15:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVGUTC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 15:02:26 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42648 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261846AbVGUTCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 15:02:10 -0400
Date: Thu, 21 Jul 2005 21:02:09 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] add -Wun-def to global CFLAGS
Message-ID: <20050721190209.GA13633@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A recent change to the aic scsi driver removed two defines to detect 
endianness. cpp handles undefined strings as 0. As a result, the test turned
into #if 0 == 0 and the wrong code was selected.
Adding -Wundef to global CFLAGS will catch such errors.

Signed-off-by: Olaf Hering <olh@suse.de>

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.12.aic-fixing/Makefile
===================================================================
--- linux-2.6.12.aic-fixing.orig/Makefile
+++ linux-2.6.12.aic-fixing/Makefile
@@ -203,7 +203,7 @@ CONFIG_SHELL := $(shell if [ -x "$$BASH"
 
 HOSTCC  	= gcc
 HOSTCXX  	= g++
-HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+HOSTCFLAGS	= -Wall -Wundef -Wstrict-prototypes -O2 -fomit-frame-pointer
 HOSTCXXFLAGS	= -O2
 
 # 	Decide whether to build built-in, modular, or both.
@@ -348,7 +348,7 @@ LINUXINCLUDE    := -Iinclude \
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
-CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
+CFLAGS 		:= -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 	  	   -fno-strict-aliasing -fno-common \
 		   -ffreestanding
 AFLAGS		:= -D__ASSEMBLY__
