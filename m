Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317074AbSEXCmL>; Thu, 23 May 2002 22:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317075AbSEXCmL>; Thu, 23 May 2002 22:42:11 -0400
Received: from zok.SGI.COM ([204.94.215.101]:62393 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317074AbSEXCmK>;
	Thu, 23 May 2002 22:42:10 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, alan@redhat.com
Subject: [patch] 2.4.19-pre8 Prevent cl2llc.c corrupting linked files
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 May 2002 12:41:46 +1000
Message-ID: <2676.1022208106@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When cl2llc.c is a multi-linked file, any build will affect all the
other copies.  cl2llc.c should not even be in the kernel tarball but AC
says that 802 is being cleaned up, so do just the minimal fix.

Index: 19-pre8.1/net/802/Makefile
--- 19-pre8.1/net/802/Makefile Thu, 01 Nov 2001 00:41:41 +1100 kaos (linux-2.4/i/41_Makefile 1.2 644)
+++ 19-pre8.1(w)/net/802/Makefile Fri, 24 May 2002 12:37:13 +1000 kaos (linux-2.4/i/41_Makefile 1.2 644)
@@ -57,4 +57,5 @@ endif
 include $(TOPDIR)/Rules.make
 
 cl2llc.c: cl2llc.pre
+	@rm -f $@
 	sed -f ./pseudo/opcd2num.sed cl2llc.pre >cl2llc.c

