Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261223AbSJYDqW>; Thu, 24 Oct 2002 23:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbSJYDqW>; Thu, 24 Oct 2002 23:46:22 -0400
Received: from p50813471.dip.t-dialin.net ([80.129.52.113]:13696 "EHLO
	debian.at.home.org") by vger.kernel.org with ESMTP
	id <S261223AbSJYDqW>; Thu, 24 Oct 2002 23:46:22 -0400
Message-ID: <3DB8C002.D2B94577@kph.uni-mainz.de>
Date: Fri, 25 Oct 2002 05:52:34 +0200
From: Thomas Reifferscheid <reiffer@kph.uni-mainz.de>
Organization: Institut =?iso-8859-1?Q?f=FCr?= Kernphysik, Mainz
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Patch for 2.4.19pre11/fs/filesystems.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I do
CONFIG_NFSD=M 
and want to insert the module I get:

unresolved symbol nfsd_linkage

which already was described by Jean-Luc Fontaine in 
http://marc.theaimsgroup.com/?l=linux-kernel&m=98173746131993&w=2


My patch solves this and works for me.

Cheers,
Thomas


--- linux-2.4.20pre11-orig/fs/filesystems.c     Sat Aug  3 02:39:45 2002
+++ linux-2.4.20pre11/fs/filesystems.c  Fri Oct 25 04:44:15 2002
@@ -13,7 +13,7 @@
 #include <linux/kmod.h>
 #include <linux/nfsd/interface.h>
 
-#if ! defined(CONFIG_NFSD)
+#if ! defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
 struct nfsd_linkage *nfsd_linkage;
 
 long
