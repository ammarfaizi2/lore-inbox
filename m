Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSHYS3Z>; Sun, 25 Aug 2002 14:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317468AbSHYS3Z>; Sun, 25 Aug 2002 14:29:25 -0400
Received: from verein.lst.de ([212.34.181.86]:36870 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S317463AbSHYS3Z>;
	Sun, 25 Aug 2002 14:29:25 -0400
Date: Sun, 25 Aug 2002 20:33:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] use -iwithprefix to find gcc headers
Message-ID: <20020825203336.A2787@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use -iwithprefix instead of my crude gcc -print-search-dirs hack to find
the directory where gcc puts stdarg.h.  Backport from 2.5.


diff -uNr -Xdontdiff -p linux-2.4.20-pre4/Makefile linux/Makefile
--- linux-2.4.20-pre4/Makefile	Tue Aug 20 11:36:59 2002
+++ linux/Makefile	Tue Aug 20 11:39:48 2002
@@ -260,7 +260,7 @@ include arch/$(ARCH)/Makefile
 # 'kbuild_2_4_nostdinc :=' or -I/usr/include for kernel code and you are not UML
 # then your code is broken!  KAO.
 
-kbuild_2_4_nostdinc	:= -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
+kbuild_2_4_nostdinc	:= -nostdinc -iwithprefix include
 export kbuild_2_4_nostdinc
 
 export	CPPFLAGS CFLAGS CFLAGS_KERNEL AFLAGS AFLAGS_KERNEL
