Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315757AbSEJCnD>; Thu, 9 May 2002 22:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSEJCnC>; Thu, 9 May 2002 22:43:02 -0400
Received: from zok.SGI.COM ([204.94.215.101]:39096 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315757AbSEJCnC>;
	Thu, 9 May 2002 22:43:02 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.15 laziness in export-objs
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 May 2002 12:42:51 +1000
Message-ID: <25744.1020998571@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.15 has four Makefiles where all objects are marked as exporting
symbols.  This is lazy coding and causes spurious rebuilds.  Please
specify only those objects that really export symbols.

Also the export list is independent of whether an object is selected or
not.  That is, export-objs is unconditional.

fs/nls/Makefile:export-objs = $(obj-y)
arch/i386/pci/Makefile:export-objs     +=      $(obj-y)
drivers/base/Makefile:export-objs     := $(obj-y)
drivers/pci/Makefile:export-objs := $(obj-y)

cd directory
echo $(fgrep -l EXPORT_SYMBOL *.c | tr '\n' ' ' | sed -e '{s/^/export-objs := /; s/\.c/.o/g; }')
will get the correct list.  arch/i386/pci/Makefile exports nothing at all.

